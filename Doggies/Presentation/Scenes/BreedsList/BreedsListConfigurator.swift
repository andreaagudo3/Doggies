import Foundation
import UIKit
import SwiftUI

class BreedsListConfigurator {
    // TODO: Create DI Container
    static func create(delegate: BreedsListSceneDelegate?) -> UIViewController {
        
        // MARK: ViewModel
        func makeBreedsListViewModel() -> BreedsListViewModel {
            let viewModel = DefaultBreedsListViewModel(getBreedsUseCase: makeGetBreedsUseCase())
            viewModel.delegate = delegate
            return viewModel
        }
        
        func makeBreedsListViewModelWrapper() -> BreedsListViewModelWrapper {
            return BreedsListViewModelWrapper(viewModel: makeBreedsListViewModel())
        }
        
        // MARK: Repository
        func makeBreedsListRepository() -> BreedsRepository {
            return DefaultBreedsRepository()
        }
        
        // MARK: Use Case
        func makeGetBreedsUseCase() -> GetBreedsUseCase {
            return DefaultGetBreedsUseCase(repository: makeBreedsListRepository())
        }
        
        
        if #available(iOS 14, *) {
            let view = BreedsListView(viewModelWrapper: makeBreedsListViewModelWrapper())
            return UIHostingController(rootView: view)
        } else { // UIKit
            let storyboard = UIStoryboard(name: "BreedsListVC", bundle: nil)
            let controller = storyboard.instantiateViewController(ofType: BreedsListVC.self)
            controller.viewModel = makeBreedsListViewModel()
            
            return controller
        }
    }
}
