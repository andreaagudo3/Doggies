import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppAppearance.setupAppearance()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        coordinator = Application.shared.configureMainInterface(in: window)

        return true
    }
}

