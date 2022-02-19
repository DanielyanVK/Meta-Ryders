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
    
    var categories: [Category] = []
    
    internal func setupLayout() -> UICollectionViewLayout {
        // section -> groups -> items -> size
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100),
                                              heightDimension: .absolute(40))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
        //                                               heightDimension: .absolute(40))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitem: item, count: 1)
        let spacing = CGFloat(12)
        group.interItemSpacing = .fixed(spacing)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)
        section.orthogonalScrollingBehavior = .continuous
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension CategoriesCollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        
        let category = categories[indexPath.item]
        
        cell.configureCategoryCollectionViewCell(by: category)
        
        return cell
    }
}
