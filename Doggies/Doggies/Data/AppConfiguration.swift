import Foundation

final class AppConfiguration {
    enum Keys {
        enum Plist: String {
            case urlHost = "URL_HOST"
        }
    }
    
    static func getValue(_ key: Keys.Plist) -> String {
        guard let infoString = AppConfiguration.infoDictionary[key.rawValue] as? String else {
            fatalError("\(key) not set in plist for this environment")
        }
        return infoString
    }
    
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
}
