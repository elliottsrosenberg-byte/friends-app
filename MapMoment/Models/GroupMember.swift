import CoreLocation
import Foundation

/// One person in the (single, hardcoded) friend group.
/// Everyone in the Firestore `users` collection IS the group — no group model yet.
struct GroupMember: Identifiable, Equatable {
    let id: String
    var displayName: String
    var latitude: Double?
    var longitude: Double?
    var updatedAt: Date?
    var isMe: Bool = false

    var coordinate: CLLocationCoordinate2D? {
        guard let latitude, let longitude else { return nil }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var initials: String {
        let parts = displayName.split(separator: " ").prefix(2)
        let letters = parts.compactMap(\.first).map(String.init).joined()
        return letters.isEmpty ? "?" : letters.uppercased()
    }
}
