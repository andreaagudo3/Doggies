import UIKit
import Foundation

final class BreedsListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: BreedsListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setTable()
        configureView()
        
        // viewModel
        bind(to: viewModel)
    }
    
    private func bind(to viewModel: BreedsListViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in self?.reloadTable() }
    }
    
    private func configureView() {
        title = viewModel.title
    }
    
    private func setTable() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: BreedCell.reuseID, bundle: nil),
                           forCellReuseIdentifier: BreedCell.reuseID)
    }
    
    
    private func reloadTable() {
        tableView.reloadData()
    }
}

// MARK: UITableViewDelegate & UITableViewDataSource
extension BreedsListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewData = viewModel.items.value[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BreedCell.reuseID,
                                                       for: indexPath) as? BreedCell else {
            fatalError("Could not dequeue cell with identifier: \(BreedCell.reuseID)")
        }
        cell.setViewData(viewData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(item: viewModel.items.value[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
