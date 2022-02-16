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
    
    //MARK: MOCKUP DATA - REMOVE LATER
    private var items: [Item] = []
    let item1 = Item(name: "Bella Doll", imageName: "BellaDoll", description: "These ancient beings have been around since the dawn of time...", price: 9861.37, growth: 136.54)
    let item2 = Item(name: "Abstract Pink", imageName: "AbstractPainting", description: "A CNS or UNS blockhain domain.", price: 0.906, growth: 6.2)
    
    private var categories: [Category] = []
    let category1 = Category(name: "Trending")
    let category2 = Category(name: "Art")
    let category3 = Category(name: "Collectibles")
    let category4 = Category(name: "Music")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //MARK: MOCKUP DATA - REMOVE LATER
        items.append(item1)
        items.append(item2)
        categories.append(category1)
        categories.append(category2)
        categories.append(category3)
        categories.append(category4)

        
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
        
        mainTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        
        mainTableView.backgroundColor = .mediumWeightGray
        
        view.addSubview(mainTableView)
        
        mainTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
// MARK: TableView Extensions
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = mainTableView?.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
            cell.configureTableViewCell(with: categories)
            
            return cell
        }
        
        let cell = mainTableView?.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
        cell.configureTableViewCell(with: items)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 40
        }
        
        return 390
    }
    
    
    //MARK: Adding space between sections in TableView. Not sure if done correctly. Might want to look at it and change further on
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat.leastNormalMagnitude
        } else {
            return 36/2
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        nil
    }
}
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        nil
//    }
//
//   func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        CGFloat.leastNormalMagnitude
//    }
