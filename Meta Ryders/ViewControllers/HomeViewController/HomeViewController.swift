//
//  HomeViewController.swift
//  Meta Ryders
//
//  Created by Vladislav on 12.02.2022.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    private var mainTableView: UITableView?
    private var dataSources: [HorizontalCollectionViewDataSource] = []
    private var tabBarView: UIView {
        let tabBarView = TabBarView()
        return tabBarView
    }
    private enum Sections {
        case categories
        case items
        case notFallable
        case news
    }
    private let sections: [Sections] = [.categories, .items, .notFallable, .news]
    
    //MARK: MOCKUP DATA - REMOVE LATER
    let item1 = Item(name: "Bella Doll", imageName: "BellaDoll", description: "These ancient beings have been around since the dawn of time...", price: 98.37, growth: 10)
    let item2 = Item(name: "Abstract Pink", imageName: "AbstractPainting", description: "A CNS or UNS blockhain domain.", price: 0.906, growth: 6.2)
    let fallableItem1 = Item(name: "Monkey", imageName: "AbstractPainting2", description: "The only thing is out for Harambe - is that T-pose", price: 1.314, growth: -5)
    let fallableItem2 = Item(name: "Wave", imageName: "BellaDoll2", description: "Cool abstract painting", price: 2.212, growth: 35)
    let news1 = News(title: "Coinbase is Partnering with MasterCard to Allow Card Pay...", imageName: "news1", article: "test", timePosted: "1 hour ago", sourceName: "bloomberg.com")
    let news2 = News(title: "Cardano (ADA) Sureges 31% After New Metaverse Launch", imageName: "news2", article: "test", timePosted: "20 min ago", sourceName: "newyorktimes.com")
    let news3 = News(title: "Apple is Prepared to Dominate the Metaverse in 2024", imageName: "news3", article: "test", timePosted: "35 min ago", sourceName: "dailybugle.com")

    private let categoryCollectionViewDataSource = CategoriesCollectionViewDataSource(displayMode: .light)
    private let itemsCollectionViewDataSource = ItemsCollectionViewDataSource()
    private let notFallableCollectionViewDataSource = ItemsCollectionViewDataSource()
    private let newsCollectionViewDataSource = NewsCollectionViewDataSource()
    
    private var items: [Item] = []
    private var categories: [Category] = ["Trending", "Art", "Collectibles", "Music"].map { Category(name: $0) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: MOCKUP DATA - REMOVE LATER
        categoryCollectionViewDataSource.update(with: categories)
        itemsCollectionViewDataSource.items.append(item1)
        itemsCollectionViewDataSource.items.append(item2)
        items.append(item1)
        items.append(item2)
        notFallableCollectionViewDataSource.items.append(fallableItem1)
        notFallableCollectionViewDataSource.items.append(fallableItem2)
        newsCollectionViewDataSource.news.append(news1)
        newsCollectionViewDataSource.news.append(news2)
        newsCollectionViewDataSource.news.append(news3)
        
        // MARK: Hero animation setup
        hero.isEnabled = true
        itemsCollectionViewDataSource.itemSelected = { item in
            let vc = ItemViewController(item: item, heroId: item.imageName, items: self.items)
            vc.hero.isEnabled = true
            vc.modalPresentationStyle = .custom
            self.present(vc, animated: true, completion: nil)
        }
        // I think that this could be implemented in a more apppealing way
        notFallableCollectionViewDataSource.itemSelected = itemsCollectionViewDataSource.itemSelected
        // MARK: Datasources
        dataSources.append(categoryCollectionViewDataSource)
        dataSources.append(itemsCollectionViewDataSource)
        dataSources.append(notFallableCollectionViewDataSource)
        dataSources.append(newsCollectionViewDataSource)
        
        addMainTableView()
        configureNavBar()
        view.addSubview(tabBarView)
        view.backgroundColor = .mediumWeightGray
    }
    
    // MARK: Main Table View Setup
    private func addMainTableView() {
        mainTableView = UITableView(frame: view.bounds, style: .plain)
        guard let mainTableView = mainTableView else {
            return
        }
        view.addSubview(mainTableView)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        mainTableView.backgroundColor = .mediumWeightGray
        mainTableView.separatorColor = .clear
        mainTableView.showsHorizontalScrollIndicator = false
        mainTableView.showsVerticalScrollIndicator = false
        
        mainTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    //MARK: Navigation Ban Configuration
    private func configureNavBar() {
        navigationController?.navigationBar.barTintColor = .mediumWeightGray
        navigationController?.navigationBar.tintColor = .lightweightGray
        
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.text = "Meta-Ryders"
        titleLabel.font = .rounded(ofSize: 24, weight: .semibold)

        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)

        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(named: "notificationsIcon"),
                            style: .plain,
                            target: self,
                            action: #selector(notificationsButtonTapped(_:))),

            UIBarButtonItem(image: UIImage(named: "walletIcon"),
                            style: .plain,
                            target: self,
                            action: #selector(walletButtonTapped(_:)))
        ]
        }
    //MARK: Navigation Bar Buttons Actions
    @objc private func walletButtonTapped(_ sender: UIButton) {
        print("Wallet - tapped")
    }
    
    @objc private func notificationsButtonTapped(_ sender: UIButton) {
        print("Notifications - tapped")
    }
    
}

// MARK: TableView Extensions
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // this one looks too clean to refactor atm. If you want I can bind it to enum as well
        let cell = mainTableView?.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
        cell.configureTableViewCell(with: dataSources[indexPath.section], layout: dataSources[indexPath.section].collectionViewLayout, for: .lightBackground)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = sections[indexPath.section]
        switch section {
        case .categories:
            return 42
        case .items:
            return 390
        case .notFallable:
            return 390
        case .news:
            return 260
        }
    }
    
    //MARK: Header/Footer configurtion
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section]
        switch section {
        case .categories:
            return 46
        case .items:
            return 0
        case .notFallable:
            return 46
        case .news:
            return 46
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = sections[section]
        let headerView = TableViewHeader()
        switch section {
        case .categories:
            headerView.configureHeader(for: .categories)
            return headerView
        case .items:
            return nil
        case .notFallable:
            headerView.configureHeader(for: .notFallable)
            return headerView
        case .news:
            headerView.configureHeader(for: .news)
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let dataSource = dataSources[section]
        if dataSource is CategoriesCollectionViewDataSource {
            return 18
        } else if dataSource is ItemsCollectionViewDataSource {
            return 36
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
}
