//
//  SaleTableViewCell.swift
//  Meta Ryders
//
//  Created by Vladislav on 07.03.2022.
//

import UIKit

class SaleTableViewCell: UITableViewCell {
    private let saleFrameImageView: UIImageView = {
        let saleFrameImageView = UIImageView()
        saleFrameImageView.image = UIImage()
        return saleFrameImageView
    }()
    private let saleLabel: UILabel = {
        let saleLabel = UILabel()
        return saleLabel
    }()
    private let timerLabel: UILabel = {
        let timerLabel = UILabel()
        return timerLabel
    }()
    private let reminderButton = UIButton(frame: .zero)
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        sendSubviewToBack(contentView)
        backgroundColor = .black
        selectionStyle = .none
        addSaleFrameImageView()
        addSaleLabel()
        addTimerLabel()
        addReminderButton()
    }
    
    private func addSaleFrameImageView() {
        addSubview(saleFrameImageView)
        saleFrameImageView.image = UIImage(named: "saleFrame")
        saleFrameImageView.clipsToBounds = true
        
        saleFrameImageView.snp.makeConstraints { make in
            make.top.equalTo(2)
            make.bottom.equalTo(-36)
            make.leading.equalTo(32)
            make.trailing.equalTo(-32)
        }
    }
    
    private func addSaleLabel() {
        addSubview(saleLabel)
        saleLabel.numberOfLines = 1
        saleLabel.textAlignment = .left
        saleLabel.textColor = .white
        saleLabel.font = .rounded(ofSize: 18, weight: .bold)
        saleLabel.text = "Sale ends"
       
        saleLabel.snp.makeConstraints { make in
            make.top.equalTo(26)
            make.leading.equalTo(52)
            make.trailing.equalTo(-52)
        }
    }
    
    private func addTimerLabel() {
        addSubview(timerLabel)
        timerLabel.textAlignment = .left
        timerLabel.textColor = .white
        timerLabel.font = .rounded(ofSize: 14, weight: .regular)
        timerLabel.text = "We will implement countdown here"
        
        timerLabel.snp.makeConstraints { make in
            make.top.equalTo(saleLabel.snp.bottom).offset(18)
            make.leading.equalTo(52)
            make.trailing.equalTo(-52)
        }
    }
    
    private func addReminderButton() {
        addSubview(reminderButton)
        reminderButton.setImage(UIImage(named: "reminderButton"), for: .normal)
        reminderButton.addTarget(self, action: #selector(reminderButtonTapped), for: .touchUpInside)
        reminderButton.layer.shadowColor = UIColor(rgb:0x524fff).cgColor
        reminderButton.layer.shadowOpacity = 0.5
        reminderButton.layer.shadowRadius = 18
        reminderButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        reminderButton.snp.makeConstraints { make in
            
            make.leading.equalTo(52)
            make.trailing.equalTo(-52)
            make.bottom.equalTo(-58)
        }
    }
    
    @objc private func reminderButtonTapped() {
        print("Reminder Button - Tapped")
    }
}
