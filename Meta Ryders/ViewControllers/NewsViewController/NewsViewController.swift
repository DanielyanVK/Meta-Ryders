//
//  NewsViewController.swift
//  Meta Ryders
//
//  Created by Vladislav on 28.03.2022.
//

import UIKit

class NewsViewController: UIViewController {
    private var news: News?
    private var tableView: UITableView?
    
    convenience init(news: News) {
        self.init()
        self.news = news
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .mediumWeightGray
        addTableView()
    }
    private func addTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        guard let tableView = tableView else {
            return
        }
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        
        tableView.backgroundColor = .mediumWeightGray
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
    
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        cell.configure(by: news!)
        return cell
    }
}
