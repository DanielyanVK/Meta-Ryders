//
//  HorizontalCollectionViewDataSource.swift
//  Meta Ryders
//
//  Created by Vladislav on 16.02.2022.
//
import UIKit

protocol HorizontalCollectionViewDataSource: UICollectionViewDelegate, UICollectionViewDataSource {
    
    var cellType: UICollectionViewCell.Type { get }
    var collectionViewLayout: UICollectionViewLayout { get }
    var height: CGFloat { get }
    func setupLayout() -> UICollectionViewLayout
    var collectionView: UICollectionView? { get set }
}

extension HorizontalCollectionViewDataSource {
    var scrollDirection: UICollectionView.ScrollDirection {
        return .horizontal
    }
    
    var height: CGFloat {
        return collectionViewLayout.collectionViewContentSize.height
    }
}
