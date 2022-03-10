//
//  CompactItemCollectionViewCell.swift
//  Meta Ryders
//
//  Created by Vladislav on 10.03.2022.
//

import UIKit
import SnapKit

class CompactItemCollectionViewCell: UICollectionViewCell {
    private let itemImageView: UIImageView = {
        let itemImageView = UIImageView()
        itemImageView.image = UIImage()
        return itemImageView
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        sendSubviewToBack(contentView)
        addItemImageView()
    }
    
    public func configureCompactCollectionViewCell(by item: Item) {
        itemImageView.image = UIImage(named: item.imageName)
    }
    
    private func addItemImageView() {
        addSubview(itemImageView)
        let borderColor: UIColor = .borderGray
        itemImageView.clipsToBounds = true
        itemImageView.layer.cornerRadius = 16
        itemImageView.layer.borderColor =  borderColor.cgColor
        itemImageView.layer.borderWidth = 2
        
        itemImageView.snp.makeConstraints { make in
            make.top.equalTo(6)
            make.bottom.equalTo(-6)
            make.leading.trailing.equalToSuperview()
        }
    }
}
