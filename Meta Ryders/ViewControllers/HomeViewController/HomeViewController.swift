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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: MOCKUP DATA - REMOVE LATER
        items.append(item1)
        items.append(item2)
        
        
        setupMainTableView()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: Main Table View Setup
    func setupMainTableView() {
        mainTableView = UITableView(frame: view.bounds)
        
        guard let mainTableView = mainTableView else {
            return
        }
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        mainTableView.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        
        view.addSubview(mainTableView)
        setupMainTableViewConstraints()
    }
    
    // MARK: Constraints
    private func setupMainTableViewConstraints() {
        mainTableView?.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
// MARK: TableView Extensions
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView?.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
            cell.configureTableViewCell(with: items)
    //   mainTableView?.reloadData()
        print(1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 390.0
    }
    
}
