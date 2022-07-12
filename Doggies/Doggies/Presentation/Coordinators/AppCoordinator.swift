import UIKit

class AppCoordinator: Coordinator {
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorType { .app }

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        DebugPrint.info("AppCoordinator deinit")
    }

    func start() {
        runBreedsFlow()
    }
    
    func runBreedsFlow() {
        let coordintator = DefaultBreedsCoordinator(self.navigationController)
        coordintator.start()
        self.childCoordinators.append(coordintator)
    }
}
