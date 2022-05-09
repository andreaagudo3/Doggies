import UIKit

protocol BreedsCoordinator: Coordinator {
    func showBreedsScene()
}

class DefaultBreedsCoordinator: BreedsCoordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorType { .breeds }

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showBreedsScene()
    }

    deinit {
        DebugPrint.info("BreedsCoordinator deinit")
    }

    func showBreedsScene() {
        DispatchQueue.main.async {
            let controller = BreedsListConfigurator.create(delegate: self)
            self.navigationController.pushViewController(controller, animated: true)
        }
    }
    
    func showBreedDetailScene(breedName: String) {
        DispatchQueue.main.async {
            let controller = BreedDetailConfigurator.create(breedName: breedName,
                                                            delegate: self)
            self.navigationController.pushViewController(controller, animated: true)
        }
    }
}

extension DefaultBreedsCoordinator: BreedsListSceneDelegate {
    func didSelect(breedName: String) {
        showBreedDetailScene(breedName: breedName)
    }
}

extension DefaultBreedsCoordinator: BreedDetailSceneDelegate {}

