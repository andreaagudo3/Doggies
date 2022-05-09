import Foundation
import UIKit

final class DefaultBreedsListViewModel: BreedsListViewModel {
    weak var delegate: BreedsListSceneDelegate?
    private let getBreedsUseCase: GetBreedsUseCase
    
    // MARK: - OUTPUT
    var items: Observable<[BreedsListItemViewModel]> = Observable([])
    var title: String {
        Locales.dogBreeds
    }
        
    init(getBreedsUseCase: GetBreedsUseCase) {
        self.getBreedsUseCase = getBreedsUseCase
    }
    
    private func fetchBreeds() async {
        do {
            delegate?.startLoading(.lockView)
            items.value = try await getBreedsUseCase.run().map({
                .init(name: $0.key)
            })
            delegate?.stopLoading(.lockView)
        } catch {
            delegate?.stopLoading(.lockView)
            delegate?.showErrorAlert(error.localizedDescription, handler: nil)
        }
    }
}

// MARK: BreedsListViewModel
extension DefaultBreedsListViewModel {
    func viewDidLoad() {
        Task {
            await fetchBreeds()
        }
    }
    
    func didSelect(item: BreedsListItemViewModel) {
        delegate?.didSelect(breedName: item.name)
    }
}
