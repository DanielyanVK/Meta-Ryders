//
//  CategoryTableViewCell.swift
//  Meta Ryders
//
//  Created by Vladislav on 16.02.2022.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    
    private var collectionView: UICollectionView? = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupCollectionView()
        sendSubviewToBack(contentView)
    }
    
    func configureTableViewCell(with dataSource: HorizontalCollectionViewDataSource, direction: UICollectionView.ScrollDirection) {
        collectionView?.collectionViewLayout = dataSource.collectionViewLayout
        collectionView?.register(dataSource.cellType, forCellWithReuseIdentifier: dataSource.cellType.identifier)
        collectionView?.delegate = dataSource
        collectionView?.dataSource = dataSource
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.isScrollEnabled = false
        collectionView?.reloadData()
        dataSource.collectionView = collectionView
        let govno = collectionView?.collectionViewLayout.collectionViewContentSize.height ?? 0
        collectionView?.snp.updateConstraints { (make) in
            make.height.equalTo(govno)
        }
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    private func setupCollectionView() {
        guard let subview = collectionView else {
            return
        }
        addSubview(subview)
        collectionView?.backgroundColor = .mediumWeightGray
        collectionView?.snp.makeConstraints { (make) in
           make.edges.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
