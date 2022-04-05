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
        selectionStyle = .none
        setupCollectionView()
        sendSubviewToBack(contentView)
    }
    
    func configureTableViewCell(with dataSource: HorizontalCollectionViewDataSource, layout: UICollectionViewLayout, for viewController: BackgroundMode) {
        
        switch viewController {
        case .lightBackground:
            collectionView.backgroundColor = .mediumWeightGray
        case .darkBackground:
            collectionView.backgroundColor = .black
        }
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
        collectionView.snp.makeConstraints { (make) in
           make.edges.equalToSuperview()
        }
    }
    enum BackgroundMode {
        case lightBackground
        case darkBackground
    }
}
