//
//  DescriptionTableViewCell.swift
//  Meta Ryders
//
//  Created by Vladislav on 07.03.2022.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    private let descriptionFrameImageView: UIImageView = {
        let descriptionFrameImageView = UIImageView()
        descriptionFrameImageView.image = UIImage()
        
        return descriptionFrameImageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        
        return descriptionLabel
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        backgroundColor = .black
        selectionStyle = .none
        
        addDescriptionFrameImageView()
        addNameLabel()
        addDescriptionLabel()
    }
    public func configureDescriptionTableViewCell(by item: Item) {
        nameLabel.text = item.name
        descriptionLabel.text = item.description
    }
    
    private func addDescriptionFrameImageView() {
        addSubview(descriptionFrameImageView)
        
        descriptionFrameImageView.image = UIImage(named: "descriptionFrame1")
        descriptionFrameImageView.clipsToBounds = true
        
        descriptionFrameImageView.snp.makeConstraints { make in
            make.top.equalTo(6)
            make.bottom.equalTo(-34)
            make.leading.equalTo(32)
            make.trailing.equalTo(-32)
        }
    }
    
    private func addNameLabel() {
        addSubview(nameLabel)

        nameLabel.numberOfLines = 1
        nameLabel.textAlignment = .left
        nameLabel.textColor = .white
        nameLabel.font = .rounded(ofSize: 18, weight: .bold)
       
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(30)
            make.leading.equalTo(52)
            make.trailing.equalTo(-52)
        }
    }
    
    private func addDescriptionLabel() {
        addSubview(descriptionLabel)

        descriptionLabel.numberOfLines = 5
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = .white
        descriptionLabel.font = .rounded(ofSize: 14, weight: .regular)
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.leading.equalTo(52)
            make.trailing.equalTo(-52)
        }
    }
}
