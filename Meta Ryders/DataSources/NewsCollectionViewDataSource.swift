//
//  NewsCollectionViewDataSource.swift
//  Meta Ryders
//
//  Created by Vladislav on 26.02.2022.
//

import UIKit
import Combine

class NewsCollectionViewDataSource: NSObject, HorizontalCollectionViewDataSource {
    var collectionViewLayout: UICollectionViewLayout {
        return setupLayout()
    }
    var newsSubject: PassthroughSubject<News,Never> = .init()
    var cellType: UICollectionViewCell.Type {
        return NewsCollectionViewCell.self
    }
    var news: [News] = []
    
    internal func setupLayout() -> UICollectionViewLayout {
           
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 32
        section.contentInsets.leading = 20
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
}

extension NewsCollectionViewDataSource: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedNews = news[indexPath.item]
        newsSubject.send(selectedNews)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.identifier, for: indexPath) as! NewsCollectionViewCell
        
        let item = news[indexPath.item]
        cell.configureNewsCollectionViewCell(by: item)
        
        return cell
        
    }
}
