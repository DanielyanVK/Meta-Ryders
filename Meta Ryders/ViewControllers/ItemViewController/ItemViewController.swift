//
//  ItemViewController.swift
//  Meta Ryders
//
//  Created by Danil Kovalev on 20.02.2022.
//

import UIKit
import Hero

class ItemViewController: UIViewController {
    
    private enum Sections: CaseIterable {
        case priceAndImage
        case ownersAndFavorites
        case description
        case purchaseAndOffer
        case sale
        case firstHeader
        
    }
    private let sections: [Sections] = [.priceAndImage, .ownersAndFavorites, .description, .purchaseAndOffer, .sale, .firstHeader]

    private var mainTableView: UITableView?

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
        mainTableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: DescriptionTableViewCell.identifier)
        mainTableView.register(PurchaseAndOfferTableViewCell.self, forCellReuseIdentifier: PurchaseAndOfferTableViewCell.identifier)
        mainTableView.register(SaleTableViewCell.self, forCellReuseIdentifier: SaleTableViewCell.identifier)
        mainTableView.register(HeaderTableViewCell.self, forCellReuseIdentifier: HeaderTableViewCell.identifier)
        
        mainTableView.backgroundColor = .black
        mainTableView.separatorColor = .clear
        mainTableView.showsHorizontalScrollIndicator = false
        mainTableView.showsVerticalScrollIndicator = false
        
        mainTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview()
        }
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
            
        case .description:
            let cell = mainTableView?.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.identifier, for: indexPath) as! DescriptionTableViewCell
            
            cell.configureDescriptionTableViewCell(by: item!)
            return cell
            
        case .purchaseAndOffer:
            let cell = mainTableView?.dequeueReusableCell(withIdentifier: PurchaseAndOfferTableViewCell.identifier, for: indexPath) as! PurchaseAndOfferTableViewCell

            return cell
            
        case .sale:
            let cell = mainTableView?.dequeueReusableCell(withIdentifier: SaleTableViewCell.identifier, for: indexPath) as! SaleTableViewCell
            
            return cell
            
        case .firstHeader:
            let cell = mainTableView?.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier, for: indexPath) as! HeaderTableViewCell
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = sections[indexPath.section]
        
        switch section  {
        case .priceAndImage:
            return 492
        case .ownersAndFavorites:
            return 30
        case .description:
            return 196
        case .purchaseAndOffer:
            return 76
        case .sale:
            return 216
        case .firstHeader:
            return 32
        }
    }
}
