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
    
    func setupLayout() -> UICollectionViewLayout
}
