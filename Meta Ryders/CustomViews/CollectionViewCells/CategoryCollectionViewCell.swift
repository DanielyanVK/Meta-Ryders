//
//  CollectionViewCell.swift
//  Meta Ryders
//
//  Created by Vladislav on 16.02.2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoryCollectionViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    
    override func didMoveToSuperview() {
        layer.cornerRadius = 20
        backgroundColor = .white
        clipsToBounds = true
        
        addNameLabel()
    }
    
    override var isSelected: Bool {
            didSet {
                self.backgroundColor = isSelected ? UIColor.highlithenedColor : UIColor.white
                nameLabel.textColor = isSelected ? UIColor.highlightenedTextColor : UIColor.lightweightGray
            }
        }
    
    //MARK: Cell configuration
    public func configureCategoryCollectionViewCell(by category: Category) {
        
        nameLabel.text = category.name
      
    }
    
    private func addNameLabel() {
        nameLabel.numberOfLines =  1
        nameLabel.textAlignment = .center
        nameLabel.textColor = .lightweightGray
        nameLabel.font = .standart(ofSize: 14, weight: .regular)
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
