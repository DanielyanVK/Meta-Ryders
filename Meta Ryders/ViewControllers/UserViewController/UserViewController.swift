//
//  UserViewController.swift
//  Meta Ryders
//
//  Created by Vladislav on 28.04.2022.
//

import UIKit
import SnapKit

class UserViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var user: User?
    private let categories: [CellCategory] = CellCategory.allCases
    private let returnButton = UIButton(frame: .zero)
    
    convenience init(user: User) {
        self.init()
        self.user = user
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mediumWeightGray
        addTableView()
        addReturnButton()
    }

    private func addTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .mediumWeightGray
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.register(UserMenuTableViewCell.self, forCellReuseIdentifier: UserMenuTableViewCell.identifier)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(60)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func addReturnButton() {
        view.addSubview(returnButton)
        view.insertSubview(returnButton, aboveSubview: tableView)
        returnButton.setImage(UIImage(named: "backButton"), for: .normal)
        returnButton.addTarget(self, action: #selector(returnButtonTapped), for: .touchUpInside)
        returnButton.layer.shadowColor = UIColor.lightweightGray.cgColor
        returnButton.layer.shadowOpacity = 0.6
        returnButton.layer.shadowRadius = 14
        returnButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        returnButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    @objc private func returnButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categories[indexPath.section]
        
        switch category {
        case .user:
            let cell = tableView.dequeueReusableCell(withIdentifier: UserMenuTableViewCell.identifier, for: indexPath) as! UserMenuTableViewCell
            cell.configure(by: user!)
            return cell
            
        case .main:
            let contentCase = category.cases[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            cell.tintColor = .purpleHeaderButton
            var configuration = cell.defaultContentConfiguration()
            configuration.image = contentCase.icon
            configuration.text = contentCase.title
            cell.contentConfiguration = configuration
            return cell
        
        case .logout:
            let contentCase = category.cases[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            cell.tintColor = .red
            var configuration = cell.defaultContentConfiguration()
            configuration.image = contentCase.icon
            configuration.text = contentCase.title
            configuration.textProperties.color = .red
            cell.contentConfiguration = configuration
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let category = categories[indexPath.section]
        let contentCase = category.cases[indexPath.row]
        
        switch contentCase {
        case .personalDetails:
            print("Personal Details Pressed")
        case .passwordAndSecurity:
            print("Password and Security Pressed")
        case .clearCache:
            print("Clear Cache pressed")
        case.logout:
            print("Logout pressed")
        case .userProfile:
            print("User profile pressed")
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 160
        } else {
            return 49
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = categories[section]
        return category.cases.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
}

extension UserViewController {
    enum CellCategory: CaseIterable {
        case user
        case main
        case logout
        
        var cases: [CellContent] {
            switch self {
            case .user:
                return [.userProfile]
            case .main:
                return [.personalDetails, .passwordAndSecurity, .clearCache]
                    
            case .logout:
                return [.logout]
            }
        }
    }
    
    enum CellContent: CaseIterable {
        case personalDetails
        case passwordAndSecurity
        case clearCache
        case logout
        case userProfile
        
        var title: String {
            switch self {
            case .personalDetails:
                return "Personal Details"
            case .passwordAndSecurity:
                return "Password and Security"
            case .clearCache:
                return "Clear Cache"
            case .userProfile:
                return ""
            case .logout:
                return "Logout"
            }
        }
        
        var icon: UIImage {
            let iconName: String
            switch self {
            case .personalDetails:
                iconName = "person.fill"
            case .passwordAndSecurity:
                iconName = "key.fill"
            case .clearCache:
                iconName = "trash.fill"
            case .logout:
                iconName = "rectangle.portrait.and.arrow.right"
            case .userProfile:
                iconName = "person.fill"
            }
            
            return UIImage(systemName: iconName)!
        }
    }
}
