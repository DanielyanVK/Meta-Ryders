//
//  ItemViewController.swift
//  Meta Ryders
//
//  Created by Danil Kovalev on 20.02.2022.
//

import UIKit
import Hero

class ItemViewController: UIViewController {
    
    private enum Sections: String, CaseIterable {
        case priceAndImage
        case ownersAndFavorites
    }
    private let sections: [Sections] = [Sections.priceAndImage, .ownersAndFavorites]

    private var mainTableView: UITableView?
    
    private let descriptionFrameImageView: UIImageView = {
        let descriptionFrameImageView = UIImageView()
        descriptionFrameImageView.image = UIImage()
        
        return descriptionFrameImageView
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
        view.backgroundColor = .black
        view.addGestureRecognizer(createSwipeGestureRecognizer(for: .right))
        
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
        mainTableView.register(OwnersAndFavoritesTableViewCell.self, forCellReuseIdentifier: OwnersAndFavoritesTableViewCell.identifier)
        
        mainTableView.backgroundColor = .cyan
        mainTableView.separatorColor = .clear
        
        view.addSubview(mainTableView)
        
        mainTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview()
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
        return Sections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = sections[indexPath.section]
        
        switch section {
            
        case .priceAndImage:
            let cell = mainTableView?.dequeueReusableCell(withIdentifier: PriceAndImageTableViewCell.identifier, for: indexPath) as! PriceAndImageTableViewCell
            
            cell.configurePriceAndImageCell(by: item!, hero: heroId ?? "")
            return cell
            
        case .ownersAndFavorites:
            let cell = mainTableView?.dequeueReusableCell(withIdentifier: OwnersAndFavoritesTableViewCell.identifier, for: indexPath) as! OwnersAndFavoritesTableViewCell
            
            cell.configureOwnersAndFavorites(by: item!)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = sections[indexPath.section]
        
        switch section  {
            
        case .priceAndImage:
            return 492
        
        case .ownersAndFavorites:
            return 44
        }
    }
}
