//
//  ItemViewController.swift
//  Meta Ryders
//
//  Created by Danil Kovalev on 20.02.2022.
//

import UIKit
import Hero

class ItemViewController: UIViewController {
    
    enum Sections: CaseIterable {
        // добавляем секции через запятую
        case PriceAndImage
        static func numberOfSections() -> Int {
            return self.allCases.count
        }
        static func getSection(_ section: Int) -> Sections {
            return self.allCases[section]
        }
    }
    
    private var mainTableView: UITableView?
    
    private let descriptionFrameImageView: UIImageView = {
        let descriptionFrameImageView = UIImageView()
        descriptionFrameImageView.image = UIImage()
        
        return descriptionFrameImageView
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
    
    convenience init(item: Item, heroId: String? = nil) {
        self.init()
        
        self.item = item
        self.heroId = heroId
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Temporary black because there are no assets in figma for designed background
        view.backgroundColor = .black
        view.addGestureRecognizer(createSwipeGestureRecognizer(for: .right))
        
//        addFollowersIconView()
//        addFollowersCountLabel()
//        addTotalItemsIconView()
//        addTotalItemsCountLabel()
//        addFavoritesIconView()
//        addFavoritesCountLabel()
//        addDescriptionFrameImageView()
          addMainTableView()
    }

// MARK: View Controller's elements configuration
    private func addMainTableView() {
        mainTableView = UITableView(frame: view.bounds, style: .plain)
        guard let mainTableView = mainTableView else {
            return
        }
        view.addSubview(mainTableView)
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        mainTableView.register(PriceAndImageTableViewCell.self, forCellReuseIdentifier: PriceAndImageTableViewCell.identifier)
        
        mainTableView.backgroundColor = .cyan
        mainTableView.separatorColor = .clear
        
        view.addSubview(mainTableView)
        
        mainTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    
    private func addFollowersIconView() {
        view.addSubview(followersIconView)
        
        followersIconView.image = UIImage(named: "followersIcon")
        followersIconView.clipsToBounds = true
        
        followersIconView.snp.makeConstraints { make in
   //         make.top.equalTo(priceLabel.snp.bottom).offset(72)
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
 //           make.top.equalTo(priceLabel.snp.bottom).offset(70)
        }
    }
    
    private func addTotalItemsIconView() {
        view.addSubview(totalItemsIconView)
        
        totalItemsIconView.image = UIImage(named: "totalItemsIcon")
        totalItemsIconView.clipsToBounds = true
        
        totalItemsIconView.snp.makeConstraints { make in
  //          make.top.equalTo(priceLabel.snp.bottom).offset(72)
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
//            make.top.equalTo(priceLabel.snp.bottom).offset(70)
        }
    }
    
    private func addFavoritesIconView() {
        view.addSubview(favoritesIconView)
        
        favoritesIconView.image = UIImage(named: "heartIcon")
        favoritesIconView.clipsToBounds = true
        
        favoritesIconView.snp.makeConstraints { make in
  //          make.top.equalTo(priceLabel.snp.bottom).offset(72)
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
 //           make.top.equalTo(priceLabel.snp.bottom).offset(70)
        }
    }
    
    private func addDescriptionFrameImageView() {
        view.addSubview(descriptionFrameImageView)
        
        descriptionFrameImageView.image = UIImage(named: "")
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
}

extension ItemViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Sections.getSection(indexPath.section) {
        case .PriceAndImage:
            
        let cell = mainTableView?.dequeueReusableCell(withIdentifier: PriceAndImageTableViewCell.identifier, for: indexPath) as! PriceAndImageTableViewCell
        
            cell.configurePriceAndImageCell(by: item!, hero: heroId ?? "")
        
        return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch Sections.getSection(indexPath.section) {
        case .PriceAndImage:
            return 492
        }
    }
}
