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
    private let containerView = UIView()
    let expandIcon = UIImageView()
    

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        selectionStyle = .none
        backgroundColor = .mediumWeightGray
        addContainerView()
        addNotificationImageView()
        addNotificationLabel()
        addDescriptionLabel()
        addExpandIcon()
    }
    
    public func configure(by notification: Notification) {
        notificationImageView.image = UIImage(named: notification.imageName)
        notificationLabel.text = notification.title
        descriptionLabel.text = notification.description
    }
   
    private func addContainerView() {
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(10)
            make.bottom.equalToSuperview()
        }
    }
    
    private func addNotificationImageView() {
        addSubview(notificationImageView)
        notificationImageView.clipsToBounds = true
        notificationImageView.layer.cornerRadius = 12
        notificationImageView.contentMode = .scaleAspectFill
        notificationImageView.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.leading.equalTo(16)
            make.width.equalTo(62)
            make.height.equalTo(62)
        }
    }
    
    private func addNotificationLabel() {
        addSubview(notificationLabel)
        notificationLabel.numberOfLines = 1
        notificationLabel.font = .rounded(ofSize: 16, weight: .semibold)
        notificationLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top)
            make.leading.equalTo(notificationImageView.snp.trailing).offset(6)
            make.height.equalTo(64)
            make.trailing.equalTo(-16)
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
            make.bottom.equalToSuperview()
            make.leading.equalTo(notificationImageView.snp.trailing).offset(6)
            make.trailing.equalTo(-16)
        }
    }
    private func addExpandIcon() {
        addSubview(expandIcon)
        expandIcon.image = UIImage(named: "expand")
        expandIcon.clipsToBounds = true
        expandIcon.snp.makeConstraints { make in
            make.trailing.equalTo(-10)
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.top.equalTo(30)
        }
    }
}
