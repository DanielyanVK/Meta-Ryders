//
//  HorizontalCollectionViewCell.swift
//  Meta Ryders
//
//  Created by Vladislav on 12.02.2022.
//

import UIKit
import SnapKit

class HorizontalCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HorizontalCollectionViewCell"
    
    //MARK: Update fonts in form of extension after asking Danil how to do so
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 13
        
        return imageView
    }()
    
    private let currencyIconView: UIImageView = {
        let ethImageView = UIImageView()
        ethImageView.image = UIImage(named: "etheriumIcon")
        ethImageView.contentMode = .scaleAspectFit
        ethImageView.clipsToBounds = true
        
        return ethImageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Mockup name"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        
        //  label.font = UIFont(name: "SFProDisplay-Bold", size: 18)
        label.font = .standart(ofSize: 18, weight: .bold)
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Mockup description"
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = UIColor(red: 138/255, green: 142/255, blue: 133/255, alpha: 1)
        
        //  descriptionLabel.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        descriptionLabel.font = .standart(ofSize: 14, weight: .regular)
        
        return descriptionLabel
    }()
    
    private let priceLabel: UILabel = {
        let ethLabel = UILabel()
        ethLabel.text = "($7 674)"
        ethLabel.textColor = .black
        
        //   ethLabel.font = UIFont(name: "SFProDisplay-Light", size: 16)
        ethLabel.font = .standart(ofSize: 16, weight: .light)
        
        return ethLabel
    }()
    
    
    private let growthLabel: UILabel = {
        let growthLabel = UILabel()
        growthLabel.text = "(+136,54%)"
        growthLabel.textColor = UIColor(red: 25/255, green: 151/255, blue: 106/255, alpha: 1)
        growthLabel.textAlignment = .right
        
        //   growthLabel.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        growthLabel.font = .standart(ofSize: 16, weight: .medium)
        
        return growthLabel
    }()
    
    private let verificationIconView: UIImageView = {
        let verificationImageView = UIImageView()
        verificationImageView.image = UIImage(named: "verificationIcon")
        verificationImageView.contentMode = .scaleAspectFit
        verificationImageView.clipsToBounds = true
        return verificationImageView
    }()
    
    private let shadowView: UIView = {
        let shadowView = UIView()
        
        shadowView.layer.cornerRadius = 13
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.22
        shadowView.layer.shadowRadius = 12
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 28)
        
        shadowView.layer.shouldRasterize = true
        shadowView.layer.rasterizationScale = UIScreen.main.scale
        
        return shadowView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 14
        backgroundColor = .white
        clipsToBounds = true
        
        //    addSubview(backgroundImageView)
        addSubview(nameLabel)
        addSubview(currencyIconView)
        addSubview(descriptionLabel)
        addSubview(priceLabel)
        addSubview(growthLabel)
        addSubview(verificationIconView)
        
        addSubview(shadowView)
        shadowView.addSubview(backgroundImageView)
        
        setupConstrainsts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK: Cell configuration
    public func configureCell(by item: Item) {
        
        nameLabel.text = item.name
        backgroundImageView.image = UIImage(named: item.imageName)
        descriptionLabel.text = item.description
        priceLabel.text = "\(item.price.description) ETH"
        
        // Later we will have to update this so we display + or - symbols and change color from green to red depending on if the value is negative or positive
        growthLabel.text = "+\(item.growth.description)%"
        
    }
    
    //MARK: Constraints
    private func setupConstrainsts() {
        backgroundImageView.snp.makeConstraints { make in
            //            make.top.equalTo(20)
            //            make.leading.equalTo(18)
            //            make.trailing.equalTo(-18)
            make.edges.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(18)
            make.top.equalTo(backgroundImageView.snp.bottom).offset(22)
        }
        
        verificationIconView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.top).offset(3)
            make.left.equalTo(nameLabel.snp.right).offset(8)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(18)
            make.trailing.equalTo(-18)
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
        }
        
        currencyIconView.snp.makeConstraints { make in
            make.leading.equalTo(22)
            make.bottom.equalTo(-18)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.left.equalTo(currencyIconView.snp.right).offset(6)
            make.bottom.equalTo(currencyIconView.snp.bottom)
        }
        
        growthLabel.snp.makeConstraints { make in
            make.trailing.equalTo(-9)
            make.bottom.equalTo(currencyIconView.snp.bottom)
        }
        
        shadowView.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.leading.equalTo(18)
            make.trailing.equalTo(-18)
        }
    }
}
