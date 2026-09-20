import AuthenticationServices
import CryptoKit
import FirebaseAuth
import Foundation

enum AuthError: LocalizedError {
    case missingCredential

    var errorDescription: String? {
        switch self {
        case .missingCredential: return "Apple sign-in returned no usable credential."
        }
    }
}

/// Sign in with Apple -> Firebase Auth.
final class AuthService: ObservableObject {
    @Published var user: FirebaseAuth.User?

    private var currentNonce: String?
    private var listenerHandle: AuthStateDidChangeListenerHandle?

    func startListening() {
        listenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async { self?.user = user }
        }
    }

    /// Configure the ASAuthorization request with a fresh nonce.
    func configureRequest(_ request: ASAuthorizationAppleIDRequest) {
        let nonce = Self.randomNonceString()
        currentNonce = nonce
        request.requestedScopes = [.fullName]
        request.nonce = Self.sha256(nonce)
    }

    /// Completes Apple sign-in against Firebase.
    /// Returns the display name Apple provided (first sign-in only), if any.
    func handleCompletion(_ result: Result<ASAuthorization, Error>) async throws -> String? {
        let authorization: ASAuthorization
        switch result {
        case .success(let value): authorization = value
        case .failure(let error): throw error
        }

        guard
            let appleCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
            let nonce = currentNonce,
            let tokenData = appleCredential.identityToken,
            let idToken = String(data: tokenData, encoding: .utf8)
        else { throw AuthError.missingCredential }

        let credential = OAuthProvider.appleCredential(
            withIDToken: idToken,
            rawNonce: nonce,
            fullName: appleCredential.fullName
        )
        try await Auth.auth().signIn(with: credential)

        let name = [appleCredential.fullName?.givenName, appleCredential.fullName?.familyName]
            .compactMap { $0 }
            .joined(separator: " ")
        return name.isEmpty ? nil : name
    }

    func signOut() {
        try? Auth.auth().signOut()
    }

    // MARK: - Nonce helpers (standard Sign in with Apple + Firebase pattern)

    private static func randomNonceString(length: Int = 32) -> String {
        let charset = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remaining = length
        while remaining > 0 {
            var random: UInt8 = 0
            let status = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
            guard status == errSecSuccess else { continue }
            if random < charset.count {
                result.append(charset[Int(random)])
                remaining -= 1
            }
        }
        return result
    }

    private static func sha256(_ input: String) -> String {
        let hashed = SHA256.hash(data: Data(input.utf8))
        return hashed.map { String(format: "%02x", $0) }.joined()
    }
}
