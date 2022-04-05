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
    private var items: [Item] = []
    private var fallableItems: [Item] = []
    // not putting it in the networking service atm because we might wanna have access to customize categories not from server but in app later on
    @Published var categories: [Category] = [Category(name: "Trending"), Category(name: "Art"), Category(name: "Collectibles"), Category(name: "Music")]
    private let networkingService = NetworkingService()
    private let categoryCollectionViewDataSource = CategoriesCollectionViewDataSource(displayMode: .light)
    private let itemsCollectionViewDataSource = ItemsCollectionViewDataSource()
    private let notFallableCollectionViewDataSource = ItemsCollectionViewDataSource()
    private let newsCollectionViewDataSource = NewsCollectionViewDataSource()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        getNews()
        getItems()
        recieveCategories()
        addDataSources()
        configureCollectionViewsItemSubjects()
        addMainTableView()
        configureNavBar()
        setupHeroAnimations()
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
    
    // MARK: Datasources
    private func addDataSources() {
        dataSources.append(categoryCollectionViewDataSource)
        dataSources.append(itemsCollectionViewDataSource)
        dataSources.append(notFallableCollectionViewDataSource)
        dataSources.append(newsCollectionViewDataSource)
    }
    //MARK: Combine
    private func recieveCategories() {
        $categories.receive(on: RunLoop.main)
            .sink { output in
                self.categoryCollectionViewDataSource.update(with: output)
                let index = IndexPath(row: 0, section: 0)
                self.mainTableView?.reloadRows(at: [index], with: .none)
            }.store(in: &subscriptions)
    }
    
    private func getNews() {
        networkingService.fetchNews()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("News fetched succesfully")
                case .failure(let error):
                    print("Error occured while fetching news: \(error)")
                }
            } receiveValue: { [weak self] (news) in
                self?.newsCollectionViewDataSource.news = news
                self?.mainTableView?.reloadData()
            }.store(in: &subscriptions)
    }
    
    private func getItems() {
        networkingService.fetchItems()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Items Fetched Succesfully")
            case .failure(let error):
                print("Error occured while fetching items: \(error)")
                }
            } receiveValue: { [weak self] (items) in
                self?.itemsCollectionViewDataSource.items = items
                self?.items = items
                self?.mainTableView?.reloadData()
            }.store(in: &subscriptions)
        // later on we will just filter out results from method above instead of doing this
        networkingService.fetchFallableItems()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Fallable items Fetched Succesfully")
            case .failure(let error):
                print("Error occured while fetching items: \(error)")
                }
            } receiveValue: { [weak self] (items) in
                self?.notFallableCollectionViewDataSource.items = items
                self?.mainTableView?.reloadData()
            }.store(in: &subscriptions)
    }
    
    private func configureCollectionViewsItemSubjects() {
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
    }
    
    // MARK: Hero animation setup
    // Hero has stopped working a while ago, need to figure out why
    private func setupHeroAnimations() {
        hero.isEnabled = true
    }
    
    //MARK: Navigation Bar Configuration
    private func configureNavBar() {
        navigationController?.navigationBar.barTintColor = .mediumWeightGray
        navigationController?.navigationBar.tintColor = .lightweightGray
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.text = "Meta-Ryders"
        titleLabel.font = .rounded(ofSize: 24, weight: .semibold)

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
        categories.insert(Category(name: "Combine, Baby!"), at: 0)
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
