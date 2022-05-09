import Foundation
import UIKit

final class Application {
    static let shared = Application()

    func configureMainInterface(in window: UIWindow) -> AppCoordinator {
        // create the main navigation controller to be used for our app
        let navController = UINavigationController()

        // send that into our coordinator so that it can display view controllers
        let coordinator = AppCoordinator(navController)
        
        // tell the coordinator to take over control
        coordinator.start()

        // create a basic UIWindow and activate it
        window.backgroundColor = .white
        window.rootViewController = navController
        window.makeKeyAndVisible()
        
        return coordinator
    }
}
