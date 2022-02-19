//
//  CategoryTableViewCell.swift
//  Meta Ryders
//
//  Created by Vladislav on 16.02.2022.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    
    // Initializing it with flow layout and switching it to compositional in setupCollectionView function because we cant initialize empty collectionView otherwise 
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupCollectionView()
        sendSubviewToBack(contentView)
    }
    
    func configureTableViewCell(with dataSource: HorizontalCollectionViewDataSource, layout: UICollectionViewLayout) {
        collectionView.collectionViewLayout = dataSource.collectionViewLayout
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
        collectionView.register(dataSource.cellType, forCellWithReuseIdentifier: dataSource.cellType.identifier)
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        
        addSubview(collectionView)
        setupCollectionViewConstraints()
        collectionView.backgroundColor = .mediumWeightGray
    }
    
    private func setupCollectionViewConstraints () {
        collectionView.snp.makeConstraints { (make) in
           make.edges.equalToSuperview()
        }
    }
}
