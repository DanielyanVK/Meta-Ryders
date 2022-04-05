//
//  NftCellCameraCollectionViewCell.swift
//  Nft
//
//  Created by 1 on 16.02.2022.
//

import UIKit
import SnapKit

class CameraItemCollectionViewCell: UICollectionViewCell {
    
    private var mainImageView = UIImageView()
    private var nameLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var currencyImageView = UIImageView()
    private var priceLabel = UILabel()
    private var orderLabel = UILabel()
    private var backgroundViewCell = UIView()
    private var actionButton = UIButton()
    private var buttonClosure = {}
    
    private var cellSize: CGSize {
        return self.frame.size
    }
    
    private var cellBorders: CGFloat {
        return cellSize.width * 0.06
    }
    
    private var labelHeight: CGFloat {
        return cellSize.height * 0.08
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        designConfigure()
        bringSubviewToFront(actionButton)
    }
    
    private func designConfigure() {
        clipsToBounds = false
        addSubview(backgroundViewCell)
        backgroundViewCell.addSubview(mainImageView)
        backgroundViewCell.addSubview(nameLabel)
        backgroundViewCell.addSubview(descriptionLabel)
        backgroundViewCell.addSubview(currencyImageView)
        backgroundViewCell.addSubview(priceLabel)
        backgroundViewCell.addSubview(orderLabel)
        addSubview(actionButton)
        
        backgroundViewConfigure()
        mainImageViewConfigure()
        nameLabelConfigure()
        descriptionLabelConfigure()
        currencyImageViewConfigure()
        priceLabelConfigure()
        orderLabelConfigure()
        actionButtonConfigure()
    }
    
    private func backgroundViewConfigure() {
        
        backgroundViewCell.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.2)
        backgroundViewCell.layer.borderColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.5).cgColor
        backgroundViewCell.layer.borderWidth = 1
        backgroundViewCell.layer.cornerRadius = cellSize.width*0.2
        
        addSubview(backgroundViewCell)
        
        backgroundViewCell.snp.makeConstraints { make in
            make.bottom.top.leading.trailing.equalToSuperview()
        }
    }
    
    private func mainImageViewConfigure() {
        mainImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(cellBorders)
            make.trailing.equalToSuperview().offset(-cellBorders)
            make.height.equalTo(mainImageView.snp.width).multipliedBy(1 / 1)
            mainImageView.contentMode = .scaleAspectFit
            mainImageView.layer.cornerRadius = cellSize.width*0.15
            mainImageView.layer.masksToBounds = true
        }
    }
    
    private func nameLabelConfigure() {
        
        nameLabel.textColor = .white
        nameLabel.font = .rounded(ofSize: 13, weight: .semibold)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(cellSize.height*0.05)
            make.leading.equalToSuperview().offset(cellBorders)
            make.trailing.equalToSuperview().offset(-cellBorders)
        }
    }
    
    private func descriptionLabelConfigure() {
        
        descriptionLabel.textColor =  UIColor(red: 0.922, green: 0.922, blue: 0.961, alpha: 0.6)
        descriptionLabel.font = .rounded(ofSize: 11, weight: .regular)
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(cellBorders)
            make.trailing.equalToSuperview().offset(-cellBorders)
            make.top.equalTo(nameLabel.snp.bottom)
            make.height.equalTo(labelHeight)
        }
    }
    
    private func currencyImageViewConfigure() {
        
        currencyImageView.contentMode = .scaleAspectFit
        currencyImageView.image = UIImage(named: "ethereum_logo")
        
        currencyImageView.snp.makeConstraints { make in
            make.height.width.equalTo(cellSize.height*0.06)
            make.leading.equalToSuperview().offset(cellBorders)
            make.centerY.equalTo(priceLabel)
        }
    }
    
    private func priceLabelConfigure() {
        
        priceLabel.textColor = .white
        priceLabel.font = .rounded(ofSize: 13, weight: .regular)
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(cellSize.height*0.03)
            make.leading.equalTo(currencyImageView.snp.trailing)
            make.height.equalTo(labelHeight)
        }
    }
    
    private func orderLabelConfigure() {
        
        orderLabel.textAlignment = .right
        orderLabel.textColor = UIColor(red: 0.922, green: 0.922, blue: 0.961, alpha: 0.6)
        orderLabel.font = .rounded(ofSize: 13, weight: .regular)
        
        orderLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(cellSize.height*0.03)
            make.trailing.equalToSuperview().offset(-cellBorders)
            make.height.height.equalTo(labelHeight)
            make.leading.equalTo(priceLabel.snp.trailing)
            make.bottom.lessThanOrEqualToSuperview().offset(-8)
            make.width.lessThanOrEqualTo(self.frame.width*0.4)
            make.width.greaterThanOrEqualTo(self.frame.height*0.2)
        }
    }
    
    private func actionButtonConfigure() {
        actionButton.setImage(UIImage(named: "try_camera"), for: .normal)
        actionButton.imageView?.contentMode = .scaleAspectFit
        actionButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        actionButton.snp.makeConstraints { make in
            make.height.width.equalTo(cellSize.width*0.25)
            make.top.equalTo(backgroundViewCell).offset(-cellSize.width*0.05)
            make.trailing.equalTo(backgroundViewCell).offset(cellSize.width*0.05)
        }
    }
    
    @objc private func buttonAction(sender: UIButton!) {
        buttonClosure()
    }
}
