import Foundation
import UIKit

final class DefaultBreedDetailViewModel: BreedDetailViewModel {
    weak var delegate: BreedDetailSceneDelegate?
    private let getRandomBreedImageUseCase: GetRandomBreedImage
    private let breedName: String
    private let imagesCount = 10
    
    var items: Observable<[BreedDetailItemViewModel]> = Observable([])
    var title: String {
        breedName.capitalizedFirst()
    }
    
    // TODO: Move values to constants
    var columnLayout = ColumnFlowLayout(
        cellsPerRow: 3,
        cellHeight: 116,
        minimumInteritemSpacing: 8,
        minimumLineSpacing: 8,
        sectionInset: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    )
            
    init(breedName: String,
         getRandomBreedImageUseCase: GetRandomBreedImage) {
        self.getRandomBreedImageUseCase = getRandomBreedImageUseCase
        self.breedName = breedName
    }
    
    private func fetchBreeds() async {
        do {
            delegate?.startLoading(.lockView)
            items.value = try await getRandomBreedImageUseCase.run(breed: breedName,
                                                                   count: imagesCount).map({
                    .init(imageUrl: URL(string: $0))
            })
            
            delegate?.stopLoading(.lockView)
        } catch {
            delegate?.stopLoading(.lockView)
            delegate?.showErrorAlert(error.localizedDescription, handler: nil)
        }
    }
}

// MARK: BreedDetailViewModel
extension DefaultBreedDetailViewModel {
    func viewDidLoad() {
        Task {
            await fetchBreeds()
        }
    }
}

