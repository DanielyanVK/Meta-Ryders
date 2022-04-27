//
//  UserTableViewCell.swift
//  Meta Ryders
//
//  Created by Vladislav on 27.04.2022.
//

import UIKit
import SnapKit

class UserTableViewCell: UITableViewCell {
    let profileImageView = UIImageView()
    let userNameLabel = UILabel()
    let arrowIconView = UIImageView()

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        selectionStyle = .none
        addProfileImageView()
        addUserNameLabel()
        addArrowIconView()
    }

    private func addProfileImageView() {
        addSubview(profileImageView)
        profileImageView.image = UIImage(named: "BellaDoll")
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 40
        profileImageView.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.width.equalTo(80)
            make.leading.equalTo(10)
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
        }
    }
    
    private func addUserNameLabel() {
        addSubview(userNameLabel)
        // we will set max lenght in extension
        userNameLabel.text = "Veguyasu"
        userNameLabel.numberOfLines = 1
        userNameLabel.font = .rounded(ofSize: 22, weight: .semibold)
        userNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.leading.equalTo(110)
            make.trailing.equalTo(-20)
        }
    }
    
    private func addArrowIconView() {
        addSubview(arrowIconView)
        arrowIconView.image = UIImage(systemName: "chevron.right")
        arrowIconView.tintColor = .lightweightGray
        arrowIconView.snp.makeConstraints { make in
            make.trailing.equalTo(-6)
            make.centerY.equalToSuperview()
        }
        
    }
}
