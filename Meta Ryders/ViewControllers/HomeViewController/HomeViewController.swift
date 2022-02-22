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
    
    private lazy var navigationBar = UINavigationBar(frame: .zero)
    
    //MARK: MOCKUP DATA - REMOVE LATER
    let item1 = Item(name: "Bella Doll", imageName: "BellaDoll", description: "These ancient beings have been around since the dawn of time...", price: 9861.37, growth: 136.54)
    let item2 = Item(name: "Abstract Pink", imageName: "AbstractPainting", description: "A CNS or UNS blockhain domain.", price: 0.906, growth: 6.2)
    
    
    private let categoryCollectionViewDataSource = CategoriesCollectionViewDataSource()
    private let itemsCollectionViewDataSource = ItemsCollectionViewDataSource()
    private var categories: [Category] = ["Trending", "Art", "Collectibles", "Music"].map { Category(name: $0) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: MOCKUP DATA - REMOVE LATER
        categoryCollectionViewDataSource.update(with: categories)
        itemsCollectionViewDataSource.items.append(item1)
        itemsCollectionViewDataSource.items.append(item2)
        
        // MARK: Hero animation setup
        hero.isEnabled = true
        itemsCollectionViewDataSource.itemSelected = { item in
            let vc = ItemViewController(item: item, heroId: item.imageName)
            vc.hero.isEnabled = true
            vc.modalPresentationStyle = .custom
            self.present(vc, animated: true, completion: nil)
        }
        
        // MARK: Datasources
        dataSources.append(categoryCollectionViewDataSource)
        dataSources.append(itemsCollectionViewDataSource)
        
        addMainTableView()
        addNavigationBar()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
       
        
        view.backgroundColor = .mediumWeightGray
    }
    
    // MARK: Main Table View Setup
    private func addMainTableView() {
        mainTableView = UITableView(frame: view.bounds, style: .plain)
        
        guard let mainTableView = mainTableView else {
            return
        }
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        mainTableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        
        mainTableView.backgroundColor = .mediumWeightGray
        mainTableView.separatorColor = .clear
        
        view.addSubview(mainTableView)
        
        mainTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func addNavigationBar() {
     //   navigationBar.backgroundColor = .blue
        view.addSubview(navigationBar)

        let titleItem = UINavigationItem(title: "Meta-Ryders")


        navigationBar.setItems([titleItem], animated: false)
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()

        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(60)
            make.leading.trailing.equalToSuperview()
        }
    }
}
// MARK: TableView Extensions
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSources.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = mainTableView?.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
        cell.configureTableViewCell(with: dataSources[indexPath.section], layout: dataSources[indexPath.section].collectionViewLayout)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dataSource = dataSources[indexPath.section]
        if dataSource is CategoriesCollectionViewDataSource {
            return 42
        } else if dataSource is ItemsCollectionViewDataSource {
            return 390
        } else {
            return 0
        }
    }
    
    
    //MARK: Adding space between sections in TableView. Not sure if done correctly. Might want to look at it and change further on
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let dataSource = dataSources[section]
        if dataSource is CategoriesCollectionViewDataSource {
            return 36
        } else if dataSource is ItemsCollectionViewDataSource {
            return CGFloat.leastNormalMagnitude
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           
        let dataSource = dataSources[section]
        
        if dataSource is CategoriesCollectionViewDataSource {
           return CategoriesHeaderView()
        } else if dataSource is ItemsCollectionViewDataSource {
            return nil
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let dataSource = dataSources[section]
        if dataSource is CategoriesCollectionViewDataSource {
            return 18
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
}

