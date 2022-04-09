//
//  NotificationTableViewCell.swift
//  Meta Ryders
//
//  Created by Vladislav on 09.04.2022.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    private let notificationImageView = UIImageView()
    private let notificationLabel = UILabel()
    private let descriptionLabel = UILabel()

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        selectionStyle = .none
        backgroundColor = .mediumWeightGray
        addNotificationImageView()
        addNotificationLabel()
        addDescriptionLabel()
    }
    public func configure(by notification: Notification) {
        notificationImageView.image = UIImage(named: notification.imageName)
        notificationLabel.text = notification.title
        descriptionLabel.text = notification.description
    }
    
    private func addNotificationImageView() {
        addSubview(notificationImageView)
        notificationImageView.clipsToBounds = true
        notificationImageView.layer.cornerRadius = 12
        notificationImageView.contentMode = .scaleAspectFill
        
        notificationImageView.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.leading.equalTo(2)
            make.width.equalTo(96)
            make.height.equalTo(96)
        }
    }
    
    private func addNotificationLabel() {
        addSubview(notificationLabel)
        notificationLabel.numberOfLines = 1
        notificationLabel.font = .rounded(ofSize: 16, weight: .semibold)
        notificationLabel.lineBreakMode = .byWordWrapping
        notificationLabel.snp.makeConstraints { make in
            make.top.equalTo(2)
            make.leading.equalTo(notificationImageView.snp.trailing)
            make.trailing.equalTo(-2)
            make.bottom.equalTo(-90)
        }
    }
    private func addDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .rounded(ofSize: 16, weight: .regular)
        descriptionLabel.textAlignment = .left
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(notificationLabel.snp.bottom)
            make.bottom.equalTo(notificationImageView.snp.bottom)
            make.leading.equalTo(notificationImageView.snp.trailing)
            make.trailing.equalTo(-2)
        }
    }
}
