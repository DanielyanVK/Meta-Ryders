//
//  ItemViewController.swift
//  Meta Ryders
//
//  Created by Danil Kovalev on 20.02.2022.
//

import UIKit
import Hero
import Charts
import Combine

class ItemViewController: UIViewController {    
    private enum Sections: CaseIterable {
        case priceAndImage
        case ownersAndFavorites
        case description
        case purchaseAndOffer
        case sale
        case firstHeader
        case timeForChart
        case chart
        case secondHeader
        case similarItemsCollection
    }
    private var subscriptions: Set<AnyCancellable> = []
    private let sections: [Sections] = [.priceAndImage, .ownersAndFavorites, .description, .purchaseAndOffer, .sale, .firstHeader, .timeForChart, .chart, .secondHeader, .similarItemsCollection]
    private let timeForChartDataSource = CategoriesCollectionViewDataSource(displayMode: .dark)
    private let compactCollectionDataSource = CompactItemCollectionViewDataSource()
    private var categories: [Category] = ["Day", "Week", "Month", "Year"].map { Category(name: $0) }
    private var chartValues: [ChartDataEntry] = [
        ChartDataEntry(x: 0.0, y: 10.0),
        ChartDataEntry(x: 1.0, y: 8.0),
        ChartDataEntry(x: 2.0, y: 5.0),
        ChartDataEntry(x: 3.0, y: 4.0),
        ChartDataEntry(x: 4.0, y: 7.0),
        ChartDataEntry(x: 5.0, y: 9.0),
        ChartDataEntry(x: 6.0, y: 12.0),
        ChartDataEntry(x: 7.0, y: 14.0)
    ]
    
    private var mainTableView: UITableView?
    private let returnButton = UIButton(frame: .zero)
    private var item: Item?
    private var items: [Item]?
    private var heroId: String?
    var datasHome: [String] = []
    
    convenience init(item: Item, heroId: String? = nil, items: [Item]) {
        self.init()
        self.item = item
        self.heroId = heroId
        self.items = items
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   view.sendSubviewToBack
        view.backgroundColor = .black
        view.addGestureRecognizer(createSwipeGestureRecognizer(for: .right))
        timeForChartDataSource.update(with: categories)
        compactCollectionDataSource.update(with: items!)
        //MARK: Combine
        compactCollectionDataSource.itemSubject.sink { item in
            let vc = ItemViewController(item: item, items: self.items!)
            vc.modalPresentationStyle = .custom
            self.present(vc, animated: true, completion: nil)
        }.store(in: &subscriptions)
        
        addMainTableView()
        addReturnButton()
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
        mainTableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        mainTableView.register(ChartTableViewCell.self, forCellReuseIdentifier: ChartTableViewCell.identifier)
        
        mainTableView.backgroundColor = .black
        mainTableView.separatorColor = .clear
        mainTableView.showsHorizontalScrollIndicator = false
        mainTableView.showsVerticalScrollIndicator = false
        
        mainTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
   
    private func addReturnButton() {
        view.addSubview(returnButton)
        view.insertSubview(returnButton, aboveSubview: mainTableView!)
        returnButton.setImage(UIImage(named: "backButton"), for: .normal)
        returnButton.addTarget(self, action: #selector(returnButtonTapped), for: .touchUpInside)
        returnButton.layer.shadowColor = UIColor(rgb:0x524fff).cgColor
        returnButton.layer.shadowOpacity = 0.6
        returnButton.layer.shadowRadius = 14
        returnButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        returnButton.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.top.equalTo(40)
        }
    }
    @objc private func returnButtonTapped() {
        dismiss(animated: true, completion: nil)
        // option if we want to return to homeVC immediatly after browsing similar items on itemVC. Not sure how u want it. We can maybe to regular dismiss with swipe and do full dismiss to homeVC with return button. Up to you, commenting this out for now
      //  self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
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
        return sections.count
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
            cell.configureHeaderTableViewCell(with: .priceHistory)
            return cell
            
        case .timeForChart:
            let cell = mainTableView?.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
            cell.configureTableViewCell(with: timeForChartDataSource, layout: timeForChartDataSource.collectionViewLayout, for: .darkBackground)
            return cell
            
        case .chart:
            let cell = mainTableView?.dequeueReusableCell(withIdentifier: ChartTableViewCell.identifier, for: indexPath) as! ChartTableViewCell
            cell.updateChart(with: chartValues)
            return cell
            
        case .secondHeader:
            let cell = mainTableView?.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier, for: indexPath) as! HeaderTableViewCell
            cell.configureHeaderTableViewCell(with: .similarItems)
            return cell
            
        case .similarItemsCollection:
            let cell = mainTableView?.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
            cell.configureTableViewCell(with: compactCollectionDataSource, layout: compactCollectionDataSource.collectionViewLayout, for: .darkBackground)
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
            return 170
        case .purchaseAndOffer:
            return 76
        case .sale:
            return 216
        case .firstHeader:
            return 32
        case .timeForChart:
            return 42
        case .chart:
            return 298
        case .secondHeader:
            return 32
        case .similarItemsCollection:
            return 118
        }
    }
}
