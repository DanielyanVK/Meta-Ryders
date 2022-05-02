//
//  SettingsViewController.swift
//  Meta Ryders
//
//  Created by Vladislav on 26.04.2022.
//

import UIKit
import SnapKit
import Combine

class SettingsViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let categories: [CellContentCategory] = CellContentCategory.allCases
    private let returnButton = UIButton(frame: .zero)
    private let networkingService = NetworkingService()
    private var subscriptions: Set<AnyCancellable> = []
    private var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mediumWeightGray
        getUser()
        addTableView()
        addReturnButton()
    }
    private func getUser() {
        networkingService.getUser()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("User Fetched Succesfully")
                case .failure(let error):
                    print("Error occured while fetching user: \(error)")
                }
            } receiveValue: { [weak self] (user) in
                self?.user = user
                self?.tableView.reloadData()
            }.store(in: &subscriptions)

    }
    
    private func addTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .mediumWeightGray
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
        
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
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categories[indexPath.section]
        
        switch category {
        case .user:
            let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as! UserTableViewCell
            cell.configure(by: user!)
            return cell
            
        case .support,.main:
            let contentCase = category.cases[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            cell.tintColor = .purpleHeaderButton
            var configuration = cell.defaultContentConfiguration()
            configuration.image = contentCase.icon
            configuration.text = contentCase.title
            cell.contentConfiguration = configuration
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let category = categories[indexPath.section]
        let contentCase = category.cases[indexPath.row]
        
        switch contentCase {
        case .support:
            print("Ask a Question pressed")
        case .rateApp:
            print("Rate app pressed")
        case .shareApp:
            print("Share app pressed")
        case.privacyPolicy:
            print("Privacy Policy pressed")
        case.termsOfUse:
            print("Terms of Use pressed")
        case .userProfile:
            let vc = UserViewController(user: user!)
            vc.modalPresentationStyle = .custom
            self.present(vc, animated: true, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].title
    }
}

extension SettingsViewController {
    enum CellContentCategory: CaseIterable {
        case user
        case main
        case support
        
        var title: String? {
            switch self {
            case .user:
                return ""
            // leaving this field empty like most app's do
            case .main:
                return ""
            case .support:
                return "Help developer"
            }
        }
        
        var cases: [CellContentCase] {
            switch self {
            case .user:
                return [.userProfile]
            case .main:
                return [.support, .privacyPolicy, .termsOfUse]
                    
            case .support:
                return [.rateApp, .shareApp]
            }
        }
    }
    
    enum CellContentCase: CaseIterable {
        case support
        case privacyPolicy
        case termsOfUse
        case rateApp
        case shareApp
        case userProfile
        
        var title: String {
            switch self {
            case .support:
                return "Ask a Question"
            case .privacyPolicy:
                return "Privacy Policy"
            case .termsOfUse:
                return "Terms of Use"
            case .rateApp:
                return "Rate App"
            case .shareApp:
                return "Share with Friends"
            case .userProfile:
                return ""
            }
        }
        
        var icon: UIImage {
            let iconName: String
            switch self {
            case .support:
                iconName = "person.fill.questionmark"
            case .privacyPolicy:
                iconName = "newspaper.fill"
            case .termsOfUse:
                iconName = "text.book.closed.fill"
            case .rateApp:
                iconName = "star.leadinghalf.fill"
            case .shareApp:
                iconName = "square.and.arrow.up.fill"
            case .userProfile:
                iconName = "person.fill"
            }
            
            return UIImage(systemName: iconName)!
        }
    }
}
