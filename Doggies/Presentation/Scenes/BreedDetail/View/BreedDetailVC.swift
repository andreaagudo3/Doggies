import UIKit

final class BreedDetailVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: BreedDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setCollection()
        configureView()
        
        // viewModel
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    private func configureView() {
        title = viewModel.title
    }
    
    private func setCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = viewModel.columnLayout
        
        collectionView.register(
            UINib(nibName: BreedImageCell.reuseID, bundle: nil),
            forCellWithReuseIdentifier: BreedImageCell.reuseID
        )
    }
    
    private func bind(to viewModel: BreedDetailViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in self?.reloadCollection() }
    }
    
    private func reloadCollection() {
        collectionView.reloadData()
    }
}

// MARK: UICollectionViewDataSource & UICollectionViewDelegate
extension BreedDetailVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewData = viewModel.items.value[indexPath.row]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreedImageCell.reuseID,
                                                            for: indexPath) as? BreedImageCell else {
            fatalError("Could not dequeue cell with identifier: \(BreedImageCell.reuseID)")
        }
        
        cell.setViewData(viewData)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


