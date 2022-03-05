//
//  PriceAndImageTableViewCell.swift
//  Meta Ryders
//
//  Created by Vladislav on 05.03.2022.
//

import UIKit

class PriceAndImageTableViewCell: UITableViewCell {
        
        let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        
        return imageView
    }()
    
    private let currencyIconView: UIImageView = {
        let currencyIconView = UIImageView()
        currencyIconView.image = UIImage()
        
        return currencyIconView
    }()
    
    private let priceLabel: UILabel = {
        let priceLabel = UILabel()
        
        return priceLabel
    }()

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        addHeroImageView()
        addPriceLabel()
        addCurrencyIconView()
    }
    
    public func configurePriceAndImageCell(by item: Item, hero: String) {
        heroImageView.image = UIImage(named: item.imageName)
        priceLabel.text = "ETH \(item.price.description)"
        heroImageView.hero.id = hero
    }

    private func addHeroImageView() {
        addSubview(heroImageView)
        backgroundColor = .black

        heroImageView.clipsToBounds = true
        heroImageView.layer.cornerRadius = 13
        
        heroImageView.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.height.equalTo(350)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
    }
    
    private func addCurrencyIconView() {
        addSubview(currencyIconView)
        
        currencyIconView.image = UIImage(named: "ethBigIcon")
        currencyIconView.clipsToBounds = true
        currencyIconView.snp.makeConstraints { make in
            make.right.equalTo(priceLabel.snp.left).offset(-6)
            make.top.equalTo(heroImageView.snp.bottom).offset(38)
        }
    }

    private func addPriceLabel() {
        addSubview(priceLabel)
        
        priceLabel.textColor = .white
        priceLabel.numberOfLines = 2
        priceLabel.textAlignment = .left
        // setting font without extension because we are using this font once throughout all project
        priceLabel.font = UIFont(name: "Orbitron-Bold", size: 18)
        
        priceLabel.snp.makeConstraints { make in
            make.trailing.equalTo(-32)
            make.top.equalTo(heroImageView.snp.bottom).offset(28)
            make.width.lessThanOrEqualTo(70)
        }
    }
}
