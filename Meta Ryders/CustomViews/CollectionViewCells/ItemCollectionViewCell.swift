//
//  HorizontalCollectionViewCell.swift
//  Meta Ryders
//
//  Created by Vladislav on 12.02.2022.
//

import UIKit
import SnapKit

class ItemCollectionViewCell: UICollectionViewCell {
        
    //MARK: Initializing cell's elements
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        return imageView
    }()
    private let currencyIconView: UIImageView = {
        let ethImageView = UIImageView()
        return ethImageView
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        return descriptionLabel
    }()
    private let priceLabel: UILabel = {
        let ethLabel = UILabel()
        return ethLabel
    }()
    private let growthLabel: UILabel = {
        let growthLabel = UILabel()
        return growthLabel
    }()
    private let verificationIconView: UIImageView = {
        let verificationIconView = UIImageView()
        return verificationIconView
    }()
    private let shadowView: UIView = {
        let shadowView = UIView()
        shadowView.addShadowParallaxEffect(amount: 35)
        return shadowView
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        layer.cornerRadius = 14
        backgroundColor = .white
        clipsToBounds = true
        addShadowView()
        addBackgroundImageView()
        addNameLabel()
        addCurrencyIconView()
        addDescriptionLabel()
        addPriceLabel()
        addGrowthLabel()
        addVerificationIconView()
    }
    
    //MARK: Cell configuration
    public func configureHorizontalCollectionViewCell(by item: Item, imageViewHeroId: String?) {
        nameLabel.text = item.name
        backgroundImageView.image = UIImage(named: item.imageName)
        descriptionLabel.text = item.description
        priceLabel.text = "\(item.price.description) ETH"
        backgroundImageView.hero.id = imageViewHeroId
        if item.growth > 0 {
            growthLabel.text = "+\(item.growth.description)%"
            growthLabel.textColor = .lightweightGreen
        } else if item.growth == 0 {
            growthLabel.text = "\(item.growth.description)%"
            growthLabel.textColor = .black
        } else {
            growthLabel.text = "\(item.growth.description)%"
            growthLabel.textColor = .red
        }
    }
    
    //MARK: Cell's elements setup
    private func addShadowView() {
        shadowView.layer.cornerRadius = 13
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.22
        shadowView.layer.shadowRadius = 12
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 28)
        
        shadowView.addShadowParallaxEffect(amount: 35)
        addSubview(shadowView)
        
        shadowView.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.leading.equalTo(18)
            make.trailing.equalTo(-18)
        }
    }
    
    private func addBackgroundImageView() {
        backgroundImageView.clipsToBounds = true
        backgroundImageView.layer.cornerRadius = 14
        shadowView.addSubview(backgroundImageView)
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func addNameLabel() {
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .left
        nameLabel.textColor = .black
        nameLabel.font = .standart(ofSize: 18, weight: .bold)
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(18)
            make.top.equalTo(backgroundImageView.snp.bottom).offset(22)
        }
    }
    
    private func addCurrencyIconView() {
        currencyIconView.image = UIImage(named: "etheriumIcon")
        currencyIconView.contentMode = .scaleAspectFit
        currencyIconView.clipsToBounds = true
        addSubview(currencyIconView)
        
        currencyIconView.snp.makeConstraints { make in
            make.leading.equalTo(18)
            make.bottom.equalTo(-18)
        }
    }
    
    private func addDescriptionLabel() {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = .lightweightGray
        descriptionLabel.font = .standart(ofSize: 14, weight: .regular)
        addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(18)
            make.trailing.equalTo(-18)
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
        }
    }
    
    private func addPriceLabel() {
        priceLabel.textColor = .black
        priceLabel.font = .standart(ofSize: 16, weight: .light)
        addSubview(priceLabel)
        
        priceLabel.snp.makeConstraints { make in
            make.left.equalTo(currencyIconView.snp.right).offset(4)
            make.bottom.equalTo(currencyIconView.snp.bottom)
        }
    }
    
    private func addGrowthLabel() {
        growthLabel.textAlignment = .right
        growthLabel.font = .standart(ofSize: 16, weight: .medium)
        addSubview(growthLabel)
        
        growthLabel.snp.makeConstraints { make in
            make.trailing.equalTo(-18)
            make.bottom.equalTo(currencyIconView.snp.bottom)
        }
    }
    
    private func addVerificationIconView() {
        verificationIconView.image = UIImage(named: "verificationIcon")
        verificationIconView.contentMode = .scaleAspectFit
        verificationIconView.clipsToBounds = true
        addSubview(verificationIconView)
        
        verificationIconView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.top).offset(2)
            make.left.equalTo(nameLabel.snp.right).offset(8)
        }
    }
}
