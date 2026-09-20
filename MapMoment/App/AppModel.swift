import AuthenticationServices
import Combine
import CoreLocation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFunctions
import Foundation

/// Orchestrates auth, the group listener, location publishing, and push
/// registration. In mock mode it swaps the whole backend for
/// MockGroupSimulator so the UI runs in the Simulator with no credentials.
final class AppModel: ObservableObject {
    @Published var isSignedIn = false
    @Published var members: [GroupMember] = []
    @Published var statusMessage: String?

    let isMock = AppEnvironment.isMock
    let auth = AuthService()
    let location = LocationService()

    private let group = GroupStore()
    private var mock: MockGroupSimulator?
    private var cancellables = Set<AnyCancellable>()
    private var lastPublishAt: Date?

    init() {
        if isMock {
            let simulator = MockGroupSimulator()
            mock = simulator
            isSignedIn = true
            simulator.$members
                .receive(on: DispatchQueue.main)
                .assign(to: &$members)
            simulator.start()
        } else {
            group.$members
                .receive(on: DispatchQueue.main)
                .assign(to: &$members)
            auth.$user
                .receive(on: DispatchQueue.main)
                .sink { [weak self] user in self?.userChanged(user) }
                .store(in: &cancellables)
            PushService.shared.$fcmToken
                .compactMap { $0 }
                .receive(on: DispatchQueue.main)
                .sink { [weak self] token in self?.saveFCMToken(token) }
                .store(in: &cancellables)
            auth.startListening()
        }
    }

    // MARK: - Auth

    func completeAppleSignIn(_ result: Result<ASAuthorization, Error>) {
        Task { [weak self] in
            guard let self else { return }
            do {
                let appleName = try await self.auth.handleCompletion(result)
                if let appleName, let uid = Auth.auth().currentUser?.uid {
                    self.userDoc(uid).setData(["displayName": appleName], merge: true)
                }
            } catch {
                await MainActor.run { self.statusMessage = error.localizedDescription }
            }
        }
    }

    private func userChanged(_ user: FirebaseAuth.User?) {
        isSignedIn = user != nil
        guard let user else {
            group.stop()
            return
        }
        statusMessage = nil

        // Ensure a user doc exists so this member shows up in the group.
        var seed: [String: Any] = ["lastActiveAt": FieldValue.serverTimestamp()]
        if let name = user.displayName, !name.isEmpty {
            seed["displayName"] = name
        }
        userDoc(user.uid).setData(seed, merge: true)

        group.startListening(currentUID: user.uid)

        location.onLocation = { [weak self] fix in self?.publishLocation(fix) }
        location.requestPermissions()

        PushService.shared.requestAuthorizationAndRegister()
        if let token = PushService.shared.fcmToken {
            saveFCMToken(token)
        }
    }

    // MARK: - Location publishing

    private func publishLocation(_ fix: CLLocation) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        // Light throttle; significant-change monitoring is already coarse.
        if let last = lastPublishAt, Date().timeIntervalSince(last) < 30 { return }
        lastPublishAt = Date()
        userDoc(uid).setData([
            "location": GeoPoint(latitude: fix.coordinate.latitude,
                                 longitude: fix.coordinate.longitude),
            "locationUpdatedAt": FieldValue.serverTimestamp(),
            "lastActiveAt": FieldValue.serverTimestamp(),
        ], merge: true)
    }

    // MARK: - Push

    private func saveFCMToken(_ token: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        userDoc(uid).setData(["fcmToken": token], merge: true)
    }

    /// Calls the sendTestPing Cloud Function — the seed of the future moment
    /// ping. Every registered device (including this one) should get a push.
    func sendTestPing() {
        guard !isMock else {
            statusMessage = "Mock mode — no real push. This would ping every registered device."
            return
        }
        statusMessage = "Sending ping…"
        Functions.functions().httpsCallable("sendTestPing").call { [weak self] result, error in
            DispatchQueue.main.async {
                if let error {
                    self?.statusMessage = "Ping failed: \(error.localizedDescription)"
                } else if let data = result?.data as? [String: Any],
                          let sent = data["sent"] as? Int {
                    self?.statusMessage = "Ping sent to \(sent) device(s)"
                } else {
                    self?.statusMessage = "Ping sent"
                }
            }
        }
    }

    // MARK: - Helpers

    private func userDoc(_ uid: String) -> DocumentReference {
        Firestore.firestore().collection("users").document(uid)
    }
}
