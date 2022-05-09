import UIKit

class BreedDetailConfigurator {
    static func create(breedName: String,
                       delegate: BreedDetailSceneDelegate?) -> BreedDetailVC {
        let storyboard = UIStoryboard(name: "BreedDetailVC", bundle: nil)
        let controller = storyboard.instantiateViewController(ofType: BreedDetailVC.self)
        
        let repository = DefaultBreedsRepository()
        let useCase = DefaultGetRandomBreedImage(repository: repository)
        let viewModel = DefaultBreedDetailViewModel(breedName: breedName,
                                                    getRandomBreedImageUseCase: useCase)
        viewModel.delegate = delegate
        controller.viewModel = viewModel
        return controller
    }
}

