import UIKit

final class BreedCell: UITableViewCell {
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var name: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit() {
        containerView.backgroundColor = Colors.cell
        containerView.cornerRadius = ViewConstants.cornerRadius
        setBottomShadow()
        
        name.textColor = Colors.greyPrimary
    }
    
    func setViewData(_ data: BreedsListItemViewModel) {
        name.text = data.name.capitalizedFirst()
    }
    
    private func setBottomShadow() {
        containerView.layer.shadowColor = Colors.greyQuaternary.cgColor
        containerView.layer.shadowOpacity = ViewConstants.shadowOpacity
        containerView.layer.shadowRadius = ViewConstants.shadowRadius
        containerView.layer.shadowOffset = ViewConstants.shadowOffset
    }
}

