//
//  UserMenuTableViewCell.swift
//  Meta Ryders
//
//  Created by Vladislav on 28.04.2022.
//

import UIKit
import SnapKit

class UserMenuTableViewCell: UITableViewCell {
    private let profileImageView = UIImageView()
    private let usernameLabel = UILabel()
    private let blockhainAdressLabel = UILabel()

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        selectionStyle = .none
        backgroundColor = .mediumWeightGray
        addProfileImageView()
        addUsernameLabel()
        addBlockchainAdressLabel()
    }
    public func configure(by user: User) {
        profileImageView.image = UIImage(named: user.profilePictureName)
        usernameLabel.text = user.username
        blockhainAdressLabel.text = user.blockhainAdress
    }

    private func addProfileImageView() {
        addSubview(profileImageView)
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
    }
    private func addUsernameLabel() {
        addSubview(usernameLabel)
        usernameLabel.numberOfLines = 1
        usernameLabel.textAlignment = .center
        usernameLabel.font = .rounded(ofSize: 28, weight: .semibold)
        usernameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImageView.snp.bottom)
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
        }
    }
    private func addBlockchainAdressLabel() {
        addSubview(blockhainAdressLabel)
        blockhainAdressLabel.numberOfLines = 1
        blockhainAdressLabel.textAlignment = .center
        blockhainAdressLabel.font = .rounded(ofSize: 14, weight: .semibold)
        blockhainAdressLabel.textColor = .heavyWeightGray
        blockhainAdressLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(usernameLabel.snp.bottom).offset(8)
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
            make.bottom.equalTo(-2)
        }
    }
}
