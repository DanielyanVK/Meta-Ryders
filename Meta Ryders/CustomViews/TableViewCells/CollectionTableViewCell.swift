//
//  CategoryTableViewCell.swift
//  Meta Ryders
//
//  Created by Vladislav on 16.02.2022.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupCollectionView()
        sendSubviewToBack(contentView)
    }
    
    func configureTableViewCell(with dataSource: HorizontalCollectionViewDataSource, layout: UICollectionViewLayout) {
        collectionView.register(dataSource.cellType, forCellWithReuseIdentifier: dataSource.cellType.identifier)
        collectionView.collectionViewLayout = dataSource.collectionViewLayout
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        addSubview(collectionView)
        collectionView.backgroundColor = .mediumWeightGray
        collectionView.snp.makeConstraints { (make) in
           make.edges.equalToSuperview()
        }
    }
}
