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
    // We can remove the array and implement dataSources individually in tableView through "if" statement. Done it like that because I've seen it on the internet and wanted to try out
    private var dataSources: [HorizontalCollectionViewDataSource] = []
    
    //MARK: MOCKUP DATA - REMOVE LATER
    private var items: [Item] = []
    let item1 = Item(name: "Bella Doll", imageName: "BellaDoll", description: "These ancient beings have been around since the dawn of time...", price: 9861.37, growth: 136.54)
    let item2 = Item(name: "Abstract Pink", imageName: "AbstractPainting", description: "A CNS or UNS blockhain domain.", price: 0.906, growth: 6.2)
    
    
    private let categoryCollectionViewDataSource = CategoriesCollectionViewDataSource()
    private let itemsCollectionViewDataSource = ItemsCollectionViewDataSource()
    private var categories: [Category] = ["1", "12", "123", "1234", "12345", "123456x§  "].map { Category(name: $0) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: MOCKUP DATA - REMOVE LATER
        
        categoryCollectionViewDataSource.update(with: categories)
        
        itemsCollectionViewDataSource.items.append(item1)
        itemsCollectionViewDataSource.items.append(item2)
        
        hero.isEnabled = true
        itemsCollectionViewDataSource.itemSelected = { item in
            let vc = ItemViewController(item: item, heroId: item.imageName)
            vc.hero.isEnabled = true
            
            vc.modalPresentationStyle = .custom
            self.present(vc, animated: true, completion: nil)
            
        }
        
        dataSources.append(itemsCollectionViewDataSource)
        dataSources.append(categoryCollectionViewDataSource)
        
        
        setupMainTableView()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: Main Table View Setup
    
    private func setupMainTableView() {
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
            make.edges.equalToSuperview()
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
            return CGFloat.leastNormalMagnitude
        } else if dataSource is ItemsCollectionViewDataSource {
            return 36/2
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        nil
    }
}
