//
//  CompactItemCollectionViewDataSource.swift
//  Meta Ryders
//
//  Created by Vladislav on 10.03.2022.
//
import UIKit

class CompactItemCollectionViewDataSource: NSObject, HorizontalCollectionViewDataSource {
    
    var cellType: UICollectionViewCell.Type {
        return CompactItemCollectionViewCell.self
    }
    
    var collectionViewLayout: UICollectionViewLayout{
        return setupLayout()
    }
    
    var items: [Item] = []
    
    func update(with items: [Item]) {
        self.items = items
    }
    
    internal func setupLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(100),
                                              heightDimension: .absolute(106))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(100),
                                               heightDimension: .absolute(106))
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
extension CompactItemCollectionViewDataSource: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        print(item)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompactItemCollectionViewCell.identifier, for: indexPath) as! CompactItemCollectionViewCell
        
        let item = items[indexPath.item]
        
        cell.configureCompactCollectionViewCell(by: item)
        
        return cell
    }
}
