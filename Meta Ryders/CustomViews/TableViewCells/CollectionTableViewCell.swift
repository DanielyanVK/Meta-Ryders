//
//  HorizontalTableViewCell.swift
//  Meta Ryders
//
//  Created by Vladislav on 12.02.2022.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    static let identifier = "CollectionTableViewCell"
    
    var horizontalCollectionView: UICollectionView?
    
    var items: [Item] = []

   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCollectionView()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureTableViewCell(with items: [Item]) {
        self.items = items
     //   horizontalCollectionView?.reloadData()
        print("test")
    }
    
    func setupCollectionView() {
        horizontalCollectionView = UICollectionView(frame: bounds, collectionViewLayout: setupLayout())
        
        guard let horizontalCollectionView = horizontalCollectionView else {
            return
        }
        
   //     addSubview(horizontalCollectionView)
        
        setupCollectionViewConstraints()
        
        horizontalCollectionView.register(HorizontalCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalCollectionViewCell.identifier)
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self
        
    }
    
    private func setupLayout() -> UICollectionViewLayout {
        // section -> groups -> items -> size
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = CGFloat(26)
        group.interItemSpacing = .fixed(spacing)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)
        
        
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func setupCollectionViewConstraints () {
        horizontalCollectionView?.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

    extension CollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return items.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = horizontalCollectionView?.dequeueReusableCell(withReuseIdentifier: HorizontalCollectionViewCell.identifier, for: indexPath) as! HorizontalCollectionViewCell
            
            let item = items[indexPath.item]
            
            cell.configureCell(by: item)
            horizontalCollectionView?.reloadData()
            return cell
            
        }
    }
