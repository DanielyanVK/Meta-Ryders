//
//  OwnersAndFavoritesTableViewCell.swift
//  Meta Ryders
//
//  Created by Vladislav on 06.03.2022.
//

import UIKit

class OwnersAndFavoritesTableViewCell: UITableViewCell {
    private let followersIconView: UIImageView = {
        let followersIconView = UIImageView()
        followersIconView.image = UIImage()
        
        return followersIconView
    }()
    
    private let totalItemsIconView: UIImageView = {
        let totalItemsIconView = UIImageView()
        totalItemsIconView.image = UIImage()
        
        return totalItemsIconView
    }()
    
    private let favoritesIconView: UIImageView = {
        let favoritesIconView = UIImageView()
        favoritesIconView.image = UIImage()
        
        return favoritesIconView
    }()
    
    private let followersCountLabel: UILabel = {
        let followersCountLabel = UILabel()
        
        return followersCountLabel
    }()
    
    private let totalItemsCountLabel: UILabel = {
        let totalItemsCountLabel = UILabel()
        
        return totalItemsCountLabel
    }()
    
    private let favoritesCountLabel: UILabel = {
        let favoritesCountLabel = UILabel()
        
        return favoritesCountLabel
    }()

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        backgroundColor = .black
        selectionStyle = .none
        
        addFollowersIconView()
        addFollowersCountLabel()
        addTotalItemsIconView()
        addTotalItemsCountLabel()
        addFavoritesIconView()
        addFavoritesCountLabel()
    }
    public func configureOwnersAndFavorites(by item: Item) {
        followersCountLabel.text = "8.7K owners"
        totalItemsCountLabel.text = "20.0K total"
        favoritesCountLabel.text = "2.3K favorites"
    }

    private func addFollowersCountLabel() {
        addSubview(followersCountLabel)
        
        followersCountLabel.textColor = .white
        followersCountLabel.textAlignment = .left
        followersCountLabel.font = .standart(ofSize: 12, weight: .regular)
        
        followersCountLabel.snp.makeConstraints { make in
            make.left.equalTo(followersIconView.snp.right).offset(6)
            make.top.equalTo(2)
        }
    }
    
    private func addTotalItemsIconView() {
        addSubview(totalItemsIconView)
        
        totalItemsIconView.image = UIImage(named: "totalItemsIcon")
        totalItemsIconView.clipsToBounds = true
        
        totalItemsIconView.snp.makeConstraints { make in
            make.top.equalTo(2)
            make.left.equalTo(followersCountLabel.snp.right).offset(30)
        }
    }
    
    private func addFollowersIconView() {
        addSubview(followersIconView)
        
        followersIconView.image = UIImage(named: "followersIcon")
        followersIconView.clipsToBounds = true
        
        followersIconView.snp.makeConstraints { make in
            make.top.equalTo(2)
            make.leading.equalTo(32)
        }
    }

    
    private func addTotalItemsCountLabel() {
        addSubview(totalItemsCountLabel)
        
        totalItemsCountLabel.textColor = .white
        totalItemsCountLabel.textAlignment = .left
        totalItemsCountLabel.font = .standart(ofSize: 12, weight: .regular)
        
        totalItemsCountLabel.snp.makeConstraints { make in
            make.left.equalTo(totalItemsIconView.snp.right).offset(6)
            make.top.equalTo(2)
        }
    }
    
    private func addFavoritesIconView() {
        addSubview(favoritesIconView)
        
        favoritesIconView.image = UIImage(named: "heartIcon")
        favoritesIconView.clipsToBounds = true
        
        favoritesIconView.snp.makeConstraints { make in
            make.top.equalTo(2)
            make.left.equalTo(totalItemsCountLabel.snp.right).offset(32)
        }
    }
    
    private func addFavoritesCountLabel() {
        addSubview(favoritesCountLabel)
        
        favoritesCountLabel.textColor = .white
        favoritesCountLabel.textAlignment = .left
        favoritesCountLabel.font = .standart(ofSize: 12, weight: .regular)

        favoritesCountLabel.snp.makeConstraints { make in
            make.left.equalTo(favoritesIconView.snp.right).offset(6)
            make.top.equalTo(2)
        }
    }
}
