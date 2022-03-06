import UIKit

class DynamicCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        return self.contentSize
    }
    
    override func reloadData() {
        super.reloadData()
        self.layoutIfNeeded()
        self.invalidateIntrinsicContentSize()
    }
}
