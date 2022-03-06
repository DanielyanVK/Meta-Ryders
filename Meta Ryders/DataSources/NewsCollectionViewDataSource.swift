//
//  NewsCollectionViewDataSource.swift
//  Meta Ryders
//
//  Created by Vladislav on 26.02.2022.
//

import UIKit

class NewsCollectionViewDataSource: NSObject, HorizontalCollectionViewDataSource {
    var collectionView: UICollectionView?
    
    
    var itemSelected: ItemClosure<News>?
    
    var collectionViewLayout: UICollectionViewLayout {
        return setupLayout()
    }
    
    var cellType: UICollectionViewCell.Type {
        return NewsCollectionViewCell.self
    }
    
    var news: [News] = []
    
    internal func setupLayout() -> UICollectionViewLayout {
           
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }
    
}

extension NewsCollectionViewDataSource: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: 96)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    // Consider implementing hero animation with new ViewController("NewsViewController"). Ask Danil about it.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // let singularNews = news[indexPath.item]
      //  itemSelected?(singularNews)
        print("Row number \(indexPath.row) is tapped")
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
