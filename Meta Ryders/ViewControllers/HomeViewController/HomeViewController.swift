//
//  HomeViewController.swift
//  Meta Ryders
//
//  Created by Vladislav on 12.02.2022.
//

import UIKit
import SnapKit
import Combine

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
    // For subscription in order to live they need to be stored somewhere. In our case it is set of subscriptions
    // Мы сохраняем не информацию, которую отдает publisher а сам факт подписки на него
    private var subscriptions: Set<AnyCancellable> = []
        
    private let sections: [Sections] = [.categories, .items, .notFallable, .news]
    //MARK: MOCKUP DATA - REMOVE LATER
    private var items: [Item] = [
        Item(name: "Bella Doll", imageName: "BellaDoll", description: "These ancient beings have been around since the dawn of time...", price: 98.37, growth: 10, modelName: "converse_obj.obj"),
        Item(name: "Abstract Pink", imageName: "AbstractPainting", description: "A CNS or UNS blockhain domain.", price: 0.906, growth: 6.2, modelName: "Squid_Games_Leader_mask.obj")
    ]
    private var fallableItems: [Item] = [
        Item(name: "Monkey", imageName: "AbstractPainting2", description: "The only thing is out for Harambe - is that T-pose", price: 1.314, growth: -5, modelName: "converse_obj.obj"),
        Item(name: "Wave", imageName: "BellaDoll2", description: "Cool abstract painting", price: 2.212, growth: 35, modelName: "Squid_Games_Leader_mask.obj")
    ]
    private var news: [News] = [
        News(title: "Coinbase is Partnering with MasterCard to Allow Card Pay", imageName: "news1", article: "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure? On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee.", timePosted: "1 hour ago", sourceName: "bloomberg.com"),
        News(title: "Cardano (ADA) Sureges 31% After New Metaverse Launch", imageName: "news2", article: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc feugiat lobortis leo nec cursus. Etiam pretium non massa in volutpat. Pellentesque nec rutrum ante. Etiam porttitor, elit quis malesuada faucibus, neque nisi tristique nisl, non sodales tortor odio in dolor. Praesent mi risus, tincidunt sed elit ut, pretium iaculis nisi. Fusce nunc eros, accumsan at placerat fringilla, auctor non felis. Sed pharetra ultricies libero at commodo. Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed ultricies augue eget mi finibus vehiculdAliquam pharetra volutpat est eget pellentesque. Praesent ut ligula varius nisi pretium pretium vel in est. In blandit ante at nisi porta condimentum. Aliquam erat volutpat. Aenean vitae tincidunt urna. Aenean et venenatis lectus. Quisque mollis, odio id commodo mollis, est eros rhoncus tellus, tempus hendrerit leo lorem ac dui. Nunc odio eros, consectetur at iaculis id, maximus finibus orci. Morbi placerat nec sem vitae pulvinar. Proin vel volutpat tellus. Quisque condimentum dignissim augue, ut efficitur nunc dictum.", timePosted: "20 min ago", sourceName: "newyorktimes.com"),
        News(title: "Apple is Prepared to Dominate the Metaverse in 2024", imageName: "news3", article: "It is a period of civil war. Rebel spaceships, striking from a hidden base, have won their first victory against the evil Galactic Empire. During the battle, Rebel spies managed to steal secret plans to the Empire’s ultimate weapon, the DEATH STAR, an armoured space station with enough power to destroy an entire planet.", timePosted: "35 min ago", sourceName: "dailybugle.com")
    ]
    private let categoryCollectionViewDataSource = CategoriesCollectionViewDataSource(displayMode: .light)
    private let itemsCollectionViewDataSource = ItemsCollectionViewDataSource()
    private let notFallableCollectionViewDataSource = ItemsCollectionViewDataSource()
    private let newsCollectionViewDataSource = NewsCollectionViewDataSource()
   
    // didn't let me use update method in .sink when it was like that
   // private var categories: [Category] = ["Trending", "Art", "Collectibles", "Music"].map { Category(name: $0) }
    @Published var categories: [Category] = [Category(name: "Trending"), Category(name: "Art"), Category(name: "Collectibles"), Category(name: "Music")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: MOCKUP DATA - REMOVE LATER
       // categoryCollectionViewDataSource.update(with: categories)
        itemsCollectionViewDataSource.items = items
        notFallableCollectionViewDataSource.items = fallableItems
        newsCollectionViewDataSource.news = news
        // MARK: Hero animation setup
        hero.isEnabled = true
        // MARK: Combine
        // Here we subscribe to itemSubject publisher and recieve item that it sends to us
        // After that we save the fact of subscription with .store
        itemsCollectionViewDataSource.itemSubject.sink { item in
            let vc = ItemViewController(item: item, heroId: item.imageName, items: self.items)
            vc.hero.isEnabled = true
            vc.modalPresentationStyle = .custom
            self.present(vc, animated: true, completion: nil)
        }.store(in: &subscriptions)
        notFallableCollectionViewDataSource.itemSubject = itemsCollectionViewDataSource.itemSubject
        //same for news
        newsCollectionViewDataSource.newsSubject.sink { selectedNews in
            let vc = NewsViewController(news: selectedNews)
            vc.modalPresentationStyle = .pageSheet
            self.present(vc, animated: true, completion: nil)
        }.store(in: &subscriptions)
        
        $categories.receive(on: RunLoop.main)
            .sink { output in
                self.categoryCollectionViewDataSource.update(with: output)
                // can't come up with a way to reload just collection view instead of whole table view
                self.mainTableView?.reloadData()
            }.store(in: &subscriptions)
        
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
    
    //MARK: Navigation Bar Configuration
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
