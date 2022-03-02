//
//  CategoriesCollectionDataSource.swift
//  Meta Ryders
//
//  Created by Vladislav on 16.02.2022.


import UIKit

class CategoriesCollectionViewDataSource: NSObject, HorizontalCollectionViewDataSource {
    
    var collectionViewLayout: UICollectionViewLayout {
        return setupLayout()
    }
    
    var cellType: UICollectionViewCell.Type {
        return CategoryCollectionViewCell.self
    }
    
    private var categories: [Category] = []
    
    func update(with categories:  [Category]) {
        self.categories = categories
    }
    
    private var selectedCategory: Category?
    
    internal func setupLayout() -> UICollectionViewLayout {
        
        let estimatedHeight: CGFloat = 42
        let estimatedWidth: CGFloat = 100
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(estimatedWidth),
                                              heightDimension: .absolute(estimatedHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(estimatedWidth),
                                               heightDimension: .absolute(estimatedHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 20
        section.interGroupSpacing = 6
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        let layout = UICollectionViewCompositionalLayout(section: section, configuration: config)
        return layout
    }
}

extension CategoriesCollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.item]
        
        if category == selectedCategory {
            self.selectedCategory = nil
        } else {
            self.selectedCategory = category
        }
        
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        
        let category = categories[indexPath.item]
        
        cell.configureCategoryCollectionViewCell(by: category, selectedCategory: selectedCategory)
        
        return cell
    }
}
