//
//  CollectionViewCell.swift
//  Meta Ryders
//
//  Created by Vladislav on 16.02.2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        backgroundColor = .white
        clipsToBounds = true
         
        addNameLabel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height / 2
    }
    
    //MARK: Cell configuration
    public func configureCategoryCollectionViewCell(by category: Category, selectedCategory: Category?) {
        nameLabel.text = category.name
        
        let isSelected = selectedCategory == category
        backgroundColor = isSelected ? UIColor.highlithenedColor : UIColor.white
        nameLabel.textColor = isSelected ? UIColor.highlightenedTextColor : UIColor.lightweightGray
    }
    
    private func addNameLabel() {
        nameLabel.numberOfLines =  1
        nameLabel.textAlignment = .center
        nameLabel.textColor = .lightweightGray
        nameLabel.font = .standart(ofSize: 14, weight: .regular)
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(12)
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.bottom.equalTo(-12)
        }
    }
}
