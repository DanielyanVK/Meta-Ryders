//
//  ItemsCollectionDataSource.swift
//  Meta Ryders
//
//  Created by Vladislav on 17.02.2022.
//

import UIKit
import Combine

class ItemsCollectionViewDataSource: NSObject, HorizontalCollectionViewDataSource {
    // creating Subject. That's one way to create publisher in combine
    var itemSubject: PassthroughSubject<Item,Never> = .init()
    
    var cellType: UICollectionViewCell.Type {
        return ItemCollectionViewCell.self
    }
    var collectionViewLayout: UICollectionViewLayout {
        return setupLayout()
    }
    var items: [Item] = []
    
    internal func setupLayout() -> UICollectionViewLayout {
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

extension ItemsCollectionViewDataSource: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        // we command our publisher to send specifict value type. We will subscribe to this publisher wherever we need it to be
        itemSubject.send(item)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as! ItemCollectionViewCell
        
        let item = items[indexPath.item]
        cell.configureHorizontalCollectionViewCell(by: item, imageViewHeroId: item.imageName)
        return cell
    }
}
