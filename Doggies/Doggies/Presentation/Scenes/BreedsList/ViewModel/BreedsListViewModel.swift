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
        Task { await fetchBreeds() }
    }
    
    private func fetchBreeds() async {
        do {
            delegate?.startLoading(.lockView)
            let breeds = try await getBreedsUseCase.run()
            let sortedKeys = Array(breeds.keys).sorted(by: <)
            
            // Sorting alphabetically
            let sortedBreeds: [BreedsListItemViewModel] = sortedKeys.map({ .init(name: $0) })
            items.value = sortedBreeds

            delegate?.stopLoading(.lockView)
        } catch {
            delegate?.stopLoading(.lockView)
            delegate?.showErrorAlert(error.localizedDescription, handler: nil)
        }
    }
    
    
}

// MARK: BreedsListViewModel
extension DefaultBreedsListViewModel {
    func didSelect(item: BreedsListItemViewModel) {
        delegate?.didSelect(breedName: item.name)
    }
}
