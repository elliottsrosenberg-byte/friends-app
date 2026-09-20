import CoreLocation
import Foundation

/// CoreLocation wrapper: requests When-In-Use first, then upgrades to Always
/// (Apple's required two-step flow), and publishes significant-change updates.
///
/// MVP fidelity per scope v2: significant-change based (roughly 500 m / cell-tower
/// granularity, very low battery cost) plus a fresh one-shot fix on each foreground.
/// Zenly-grade battery polish is explicitly not the bar for slice 1.
final class LocationService: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined

    /// Wired by AppModel to publish fixes to Firestore.
    var onLocation: ((CLLocation) -> Void)?

    private let manager = CLLocationManager()
    private var hasRequestedAlwaysUpgrade = false

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }

    /// Entry point, called once the user is signed in and looking at the map.
    func requestPermissions() {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            requestAlwaysUpgrade()
            start()
        case .authorizedAlways:
            start()
        default:
            break
        }
    }

    /// One-shot refresh (e.g. on app foreground).
    func refresh() {
        guard isAuthorized else { return }
        manager.requestLocation()
    }

    private var isAuthorized: Bool {
        manager.authorizationStatus == .authorizedWhenInUse
            || manager.authorizationStatus == .authorizedAlways
    }

    private func requestAlwaysUpgrade() {
        guard !hasRequestedAlwaysUpgrade else { return }
        hasRequestedAlwaysUpgrade = true
        manager.requestAlwaysAuthorization()
    }

    private func start() {
        manager.startMonitoringSignificantLocationChanges()
        manager.requestLocation()
    }

    // MARK: - CLLocationManagerDelegate

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        DispatchQueue.main.async {
            self.authorizationStatus = manager.authorizationStatus
        }
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            start()
            requestAlwaysUpgrade()
        case .authorizedAlways:
            // Requires the "location" background mode (declared in Info.plist).
            manager.allowsBackgroundLocationUpdates = true
            start()
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        onLocation?(location)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // kCLErrorLocationUnknown is transient and common in the Simulator.
        print("[MapMoment] Location error: \(error.localizedDescription)")
    }
}
