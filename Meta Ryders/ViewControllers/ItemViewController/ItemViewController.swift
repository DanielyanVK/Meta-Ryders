//
//  ItemViewController.swift
//  Meta Ryders
//
//  Created by Danil Kovalev on 20.02.2022.
//

import UIKit
import Hero

class ItemViewController: UIViewController {

    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        
        return imageView
    }()
    
    private let descriptionFrameImageView: UIImageView = {
        let descriptionFrameImageView = UIImageView()
        descriptionFrameImageView.image = UIImage()
        
        return descriptionFrameImageView
    }()
    
    private let currencyIconView: UIImageView = {
        let currencyIconView = UIImageView()
        currencyIconView.image = UIImage()
        
        return currencyIconView
    }()
    
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
    
    private let priceLabel: UILabel = {
        let priceLabel = UILabel()
        
        return priceLabel
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
    
    private var item: Item?
    private var heroId: String?
    
    
    
    convenience init(item: Item?, heroId: String? = nil) {
        self.init()
        
        self.item = item
        self.heroId = heroId
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Temporary black because there are no assets in figma for designed background
        view.backgroundColor = .black
        view.addGestureRecognizer(createSwipeGestureRecognizer(for: .right))
        
        addHeroImageView()
        addCurrencyIconView()
        addPriceLabel()
        addFollowersIconView()
        addFollowersCountLabel()
        addTotalItemsIconView()
        addTotalItemsCountLabel()
        addFavoritesIconView()
        addFavoritesCountLabel()
        addDescriptionFrameImageView()
    }
    
    //MARK: Gesture recognition
    //Added customizable swipe recognition. It was impossible to scroll on this view controller with "touches began" function dismissing it. Added dismiss function to right swipe for now. later on we can fully customize it
    private func createSwipeGestureRecognizer(for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        // Initialize Swipe Gesture Recognizer
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        // Configure Swipe Gesture Recognizer
        swipeGestureRecognizer.direction = direction
        return swipeGestureRecognizer
        
    }
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .right:
              dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
// MARK: View Controller's elements configuration
    private func addHeroImageView() {
        view.addSubview(heroImageView)

        heroImageView.clipsToBounds = true
        heroImageView.layer.cornerRadius = 13
        heroImageView.hero.id = heroId
        heroImageView.image = UIImage(named: item?.imageName ?? "")
        
        heroImageView.snp.makeConstraints { make in
            make.top.equalTo(60)
            make.height.equalTo(350)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
    }

    private func addCurrencyIconView() {
        view.addSubview(currencyIconView)
        
        currencyIconView.image = UIImage(named: "ethBigIcon")
        currencyIconView.clipsToBounds = true
        // в макете эта иконка стоит не ниже heroImage, а справа в нижнем его углу, но иконка сливается на светлых изображениях
        currencyIconView.snp.makeConstraints { make in
            make.trailing.equalTo(-106)
            make.top.equalTo(heroImageView.snp.bottom).offset(40)
        }
    }

    private func addPriceLabel() {
        view.addSubview(priceLabel)
        
        priceLabel.text = "ETH \(item?.price.description ?? "")"
        priceLabel.textColor = .white
        priceLabel.numberOfLines = 2
        priceLabel.textAlignment = .left
        // setting font without extension because we are using this font once throughout all project
        priceLabel.font = UIFont(name: "Orbitron-Bold", size: 18)
        
        priceLabel.snp.makeConstraints { make in
            make.left.equalTo(currencyIconView.snp.right).offset(6)
            make.trailing.equalTo(-36)
            make.top.equalTo(heroImageView.snp.bottom).offset(30)
        }
    }
    
    private func addFollowersIconView() {
        view.addSubview(followersIconView)
        
        followersIconView.image = UIImage(named: "followersIcon")
        followersIconView.clipsToBounds = true
        
        followersIconView.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(72)
            make.leading.equalTo(44)
        }
    }

    private func addFollowersCountLabel() {
        view.addSubview(followersCountLabel)
        
        followersCountLabel.textColor = .white
        followersCountLabel.textAlignment = .left
        followersCountLabel.font = .standart(ofSize: 12, weight: .regular)
        // temporal data till we get real one
        followersCountLabel.text = "8.7K owners"
        
        followersCountLabel.snp.makeConstraints { make in
            make.left.equalTo(followersIconView.snp.right).offset(6)
            make.top.equalTo(priceLabel.snp.bottom).offset(70)
        }
    }
    
    private func addTotalItemsIconView() {
        view.addSubview(totalItemsIconView)
        
        totalItemsIconView.image = UIImage(named: "totalItemsIcon")
        totalItemsIconView.clipsToBounds = true
        
        totalItemsIconView.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(72)
            make.left.equalTo(followersCountLabel.snp.right).offset(30)
        }
    }
    
    private func addTotalItemsCountLabel() {
        view.addSubview(totalItemsCountLabel)
        
        totalItemsCountLabel.textColor = .white
        totalItemsCountLabel.textAlignment = .left
        totalItemsCountLabel.font = .standart(ofSize: 12, weight: .regular)
        // temporal data till we get real one
        totalItemsCountLabel.text = "20.0K total"
        
        totalItemsCountLabel.snp.makeConstraints { make in
            make.left.equalTo(totalItemsIconView.snp.right).offset(6)
            make.top.equalTo(priceLabel.snp.bottom).offset(70)
        }
    }
    
    private func addFavoritesIconView() {
        view.addSubview(favoritesIconView)
        
        favoritesIconView.image = UIImage(named: "heartIcon")
        favoritesIconView.clipsToBounds = true
        
        favoritesIconView.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(72)
            make.left.equalTo(totalItemsCountLabel.snp.right).offset(30)
        }
    }
    
    private func addFavoritesCountLabel() {
        view.addSubview(favoritesCountLabel)
        
        favoritesCountLabel.textColor = .white
        favoritesCountLabel.textAlignment = .left
        favoritesCountLabel.font = .standart(ofSize: 12, weight: .regular)
        // temporal data till we get real one
        favoritesCountLabel.text = "2.3K favorites"
        
        favoritesCountLabel.snp.makeConstraints { make in
            make.left.equalTo(favoritesIconView.snp.right).offset(6)
            make.top.equalTo(priceLabel.snp.bottom).offset(70)
        }
    }
    
    private func addDescriptionFrameImageView() {
        view.addSubview(descriptionFrameImageView)
        
        descriptionFrameImageView.image = UIImage(named: "")
    }
}
