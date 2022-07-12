import UIKit

struct BreedDetailItemViewModel {
    let imageUrl: URL?
}

final class BreedImageCell: UICollectionViewCell {

    @IBOutlet weak var dogImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit() {
        dogImageView.cornerRadius = ViewConstants.cornerRadius
    }
    
    func setViewData(_ data: BreedDetailItemViewModel) {
        if let imageUrl = data.imageUrl {
            self.loadImage(url: imageUrl, into: dogImageView, placeHolder: UIImage(named: "placeholder"))
        }
    }
}
