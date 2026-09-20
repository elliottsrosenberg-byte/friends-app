import Foundation

/// DEBUG/mock-mode stand-in for the whole backend: five fake friends around
/// the Mission (SF), gently drifting so the map feels live. No Firebase calls.
final class MockGroupSimulator: ObservableObject {
    @Published var members: [GroupMember]

    private var timer: Timer?

    init() {
        let now = Date()
        members = [
            GroupMember(id: "me", displayName: "You", latitude: 37.7599, longitude: -122.4148,
                        updatedAt: now, isMe: true),
            GroupMember(id: "maya", displayName: "Maya K", latitude: 37.7648, longitude: -122.4230,
                        updatedAt: now.addingTimeInterval(-120)),
            GroupMember(id: "dev", displayName: "Dev P", latitude: 37.7534, longitude: -122.4214,
                        updatedAt: now.addingTimeInterval(-300)),
            GroupMember(id: "sam", displayName: "Sam R", latitude: 37.7691, longitude: -122.4090,
                        updatedAt: now.addingTimeInterval(-45)),
            GroupMember(id: "jess", displayName: "Jess T", latitude: 37.7480, longitude: -122.4032,
                        updatedAt: now.addingTimeInterval(-900)),
        ]
    }

    func start() {
        stop()
        timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { [weak self] _ in
            self?.jitter()
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }

    private func jitter() {
        members = members.map { member in
            var member = member
            if !member.isMe, let lat = member.latitude, let lng = member.longitude {
                member.latitude = lat + Double.random(in: -0.0005...0.0005)
                member.longitude = lng + Double.random(in: -0.0005...0.0005)
                member.updatedAt = Date()
            }
            return member
        }
    }
}
