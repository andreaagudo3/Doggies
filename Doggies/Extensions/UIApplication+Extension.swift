import UIKit

extension UIApplication {
    class func topViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({ $0.activationState == .foregroundActive })
                .compactMap({ $0 as? UIWindowScene })
                .first?.windows
                .filter({ $0.isKeyWindow} ).first

        return keyWindow?.rootViewController?.topViewController()
    }
}

extension UIViewController {
    func topViewController() -> UIViewController {

        if let presented = self.presentedViewController {
            return presented.topViewController()
        }

        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topViewController() ?? navigation
        }

        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topViewController() ?? tab
        }

        return self
    }
}
