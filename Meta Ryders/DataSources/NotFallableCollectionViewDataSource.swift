//
//  NotFallableDataSource.swift
//  Meta Ryders
//
//  Created by Vladislav on 25.02.2022.
//

import UIKit

class NotFallableCollectionViewDataSource: NSObject, HorizontalCollectionViewDataSource {
    var itemSelected: ItemClosure<Item>?
    var cellType: UICollectionViewCell.Type {
        return ItemCollectionViewCell.self
    }
    var collectionViewLayout: UICollectionViewLayout {
        return setupLayout()
    }
    var fallableItems: [Item] = []
    internal func setupLayout() -> UICollectionViewLayout {
        // section -> groups -> items -> size
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(260),
                                              heightDimension: .estimated(390))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(260),
                                               heightDimension: .estimated(390))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let spacing = CGFloat(20)
        group.interItemSpacing = .fixed(spacing)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)
        section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
extension NotFallableCollectionViewDataSource: UICollectionViewDelegate, UICollectionViewDataSource {
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = fallableItems[indexPath.item]
        itemSelected?(item)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fallableItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as! ItemCollectionViewCell
        let item = fallableItems[indexPath.item]
        cell.configureHorizontalCollectionViewCell(by: item, imageViewHeroId: item.imageName)
        return cell
        
    }
}
