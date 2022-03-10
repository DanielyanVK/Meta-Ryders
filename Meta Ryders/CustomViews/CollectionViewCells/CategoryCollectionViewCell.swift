//
//  CollectionViewCell.swift
//  Meta Ryders
//
//  Created by Vladislav on 16.02.2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    enum DisplayMode {
        case light
        case dark
    }
    private let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        clipsToBounds = true
        addNameLabel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
    //MARK: Cell configuration
    public func configure(by category: Category, selectedCategory: Category?, displayMode: DisplayMode) {
        let isSelected = selectedCategory == category
        switch displayMode {
        case .light:
            backgroundColor = isSelected ? UIColor.highlithenedColor : UIColor.white
            nameLabel.textColor = isSelected ? UIColor.highlightenedTextColor : UIColor.lightweightGray
        case .dark:
            backgroundColor = isSelected ? UIColor.darkBlue : UIColor.fillGray
            nameLabel.textColor = isSelected ? UIColor.white : UIColor.lightweightGray
        }
        nameLabel.text = category.name
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

