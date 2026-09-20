import FirebaseFirestore
import Foundation

/// Live view of the (single, hardcoded) group: everyone in the `users`
/// collection appears on the map. Firestore snapshot listeners deliver on the
/// main queue by default.
final class GroupStore: ObservableObject {
    @Published var members: [GroupMember] = []

    private var listener: ListenerRegistration?
    private var currentUID: String?

    func startListening(currentUID: String) {
        self.currentUID = currentUID
        listener?.remove()
        listener = Firestore.firestore().collection("users")
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self else { return }
                if let error {
                    print("[MapMoment] Group listener error: \(error.localizedDescription)")
                    return
                }
                guard let documents = snapshot?.documents else { return }
                let parsed = documents.map { document -> GroupMember in
                    let data = document.data()
                    let geoPoint = data["location"] as? GeoPoint
                    return GroupMember(
                        id: document.documentID,
                        displayName: data["displayName"] as? String ?? "Friend",
                        latitude: geoPoint?.latitude,
                        longitude: geoPoint?.longitude,
                        updatedAt: (data["locationUpdatedAt"] as? Timestamp)?.dateValue(),
                        isMe: document.documentID == self.currentUID
                    )
                }
                DispatchQueue.main.async { self.members = parsed }
            }
    }

    func stop() {
        listener?.remove()
        listener = nil
        currentUID = nil
        members = []
    }
}
