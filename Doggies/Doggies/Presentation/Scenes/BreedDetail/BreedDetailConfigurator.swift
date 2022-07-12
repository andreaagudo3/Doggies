import UIKit

class BreedDetailConfigurator {
    
    static func create(breedName: String,
                       delegate: BreedDetailSceneDelegate?) -> BreedDetailVC {
        // MARK: ViewModel
        func makeBreedDetailViewModel() -> BreedDetailViewModel {
            let viewModel = DefaultBreedDetailViewModel(breedName: breedName,
                                                        getRandomBreedImageUseCase: makeGetRandomBreedImageUseCase())
            viewModel.delegate = delegate
            return viewModel
        }
        
        // MARK: Repository
        func makeBreedDetailRepository() -> BreedsRepository {
            return DefaultBreedsRepository()
        }
        
        // MARK: Use Case
        func makeGetRandomBreedImageUseCase() -> GetRandomBreedImage {
            return DefaultGetRandomBreedImage(repository: makeBreedDetailRepository())
        }
        
        let storyboard = UIStoryboard(name: "BreedDetailVC", bundle: nil)
        let controller = storyboard.instantiateViewController(ofType: BreedDetailVC.self)
        controller.viewModel = makeBreedDetailViewModel()
        
        return controller
    }
}

