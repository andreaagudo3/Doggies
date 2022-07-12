import Foundation

// MARK: View model comunication
protocol BreedDetailViewModel {
    // Input
    func viewDidLoad()
    
    // Output
    var title: String { get }
    var items: Observable<[BreedDetailItemViewModel]> { get }
    var columnLayout: ColumnFlowLayout { get }
}

// MARK: Navigation
protocol BreedDetailSceneDelegate: AlertScene, LoadScene  {}

// MARK: Bookings List
struct BreedDetailSectionHeader {
    let title: String
}

enum BreedDetailSection: Int, CaseIterable {
    case images
}

enum BreedDetailCellType {
    case image(BreedDetailItemViewModel)
}
