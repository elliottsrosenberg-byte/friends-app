import Foundation

/// Decides whether the app runs against Firebase or in mock mode.
///
/// Mock mode = fake friends + fake locations, no Firebase calls at all.
/// It activates when:
///   1. (DEBUG only) launched with the `--mock` argument or MAPMOMENT_MOCK=1, or
///   2. GoogleService-Info.plist is missing from the bundle (so the app is
///      runnable in the Simulator before the Firebase project exists).
enum AppEnvironment {
    static let isMock: Bool = {
        #if DEBUG
        if ProcessInfo.processInfo.arguments.contains("--mock") { return true }
        if ProcessInfo.processInfo.environment["MAPMOMENT_MOCK"] == "1" { return true }
        #endif
        return !isFirebaseConfigured
    }()

    static let isFirebaseConfigured: Bool =
        Bundle.main.url(forResource: "GoogleService-Info", withExtension: "plist") != nil
}
