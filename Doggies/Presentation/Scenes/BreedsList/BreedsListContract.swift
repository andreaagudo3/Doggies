import Foundation

// MARK: View model comunication
protocol BreedsListViewModel {
    // Input
    func viewDidLoad()
    func didSelect(item: BreedsListItemViewModel)
    
    // Output
    var title: String { get }
    var items: Observable<[BreedsListItemViewModel]> { get }
}

// MARK: Navigation
protocol BreedsListSceneDelegate: LoadScene, AlertScene {
    func didSelect(breedName: String)
}
