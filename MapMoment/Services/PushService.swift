import Foundation
import UIKit
import UserNotifications

/// Notification permission + remote-notification registration.
/// The FCM token arrives via AppDelegate (MessagingDelegate) and is published
/// here; AppModel persists it to the signed-in user's Firestore doc.
final class PushService: NSObject, ObservableObject {
    static let shared = PushService()

    @Published var fcmToken: String?

    func requestAuthorizationAndRegister() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
                guard granted else { return }
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
    }
}
