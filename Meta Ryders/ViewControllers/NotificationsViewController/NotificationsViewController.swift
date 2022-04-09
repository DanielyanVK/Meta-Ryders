//
//  NotificationsViewController.swift
//  Meta Ryders
//
//  Created by Vladislav on 09.04.2022.
//

import UIKit
import Combine

class NotificationsViewController: UIViewController {
    private var tableView: UITableView?
    private var notifications: [Notification] = []
    private let networkingService = NetworkingService()
    private var subscriptions: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNotifications()
        addTableView()
    }
    
    private func getNotifications() {
        networkingService.fetchNotifications()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Notifications fetched succesfully")
                case .failure(let error):
                    print("Error occured while fetching notifications: \(error)")
                }
            } receiveValue: { [weak self] (notifications) in
                self?.notifications = notifications
                self?.tableView?.reloadData()
            }.store(in: &subscriptions)
    }
    
    private func addTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        guard let tableView = tableView else {
            return
        }
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NotificationTableViewCell.self, forCellReuseIdentifier: NotificationTableViewCell.identifier)
        tableView.backgroundColor = .mediumWeightGray
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
    }
}
extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.identifier, for: indexPath) as! NotificationTableViewCell
        let notification = notifications[indexPath.item]
        cell.configure(by: notification)
        return cell
    }
    // will get rid of these throughout whole project once I figure out how
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
