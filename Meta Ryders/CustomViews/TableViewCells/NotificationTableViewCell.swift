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

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        selectionStyle = .none
        backgroundColor = .mediumWeightGray
        addContainerView()
        addNotificationImageView()
        addNotificationLabel()
        addDescriptionLabel()
    }
    public func configure(by notification: Notification) {
        notificationImageView.image = UIImage(named: notification.imageName)
        notificationLabel.text = notification.title
        descriptionLabel.text = notification.description
    }
    public func animate() {
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.contentView.layoutIfNeeded()
        }
    }
    private func addContainerView() {
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.equalTo(2)
            make.trailing.equalTo(-2)
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
            make.leading.equalTo(2)
            make.width.equalTo(62)
            make.height.equalTo(62)
        }
    }
    
    private func addNotificationLabel() {
        addSubview(notificationLabel)
        notificationLabel.numberOfLines = 1
        notificationLabel.font = .rounded(ofSize: 16, weight: .semibold)
        notificationLabel.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.leading.equalTo(notificationImageView.snp.trailing)
            make.trailing.equalTo(-2)
        }
    }
    private func addDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .rounded(ofSize: 16, weight: .regular)
        descriptionLabel.textAlignment = .left
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(30)
            make.bottom.equalTo(containerView.snp.bottom)
            make.leading.equalTo(notificationImageView.snp.trailing)
            make.trailing.equalTo(-2)
        }
    }
}
