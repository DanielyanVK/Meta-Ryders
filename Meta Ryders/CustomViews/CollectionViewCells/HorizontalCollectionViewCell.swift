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
        
        label.font = UIFont(name: "SFProDisplay-Bold", size: 18)
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Mockup description"
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = UIColor(red: 138/255, green: 142/255, blue: 133/255, alpha: 1)
        
        descriptionLabel.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        
        return descriptionLabel
    }()
    
    private let priceLabel: UILabel = {
        let ethLabel = UILabel()
        ethLabel.text = "($7 674)"
        ethLabel.textColor = .black
        
        ethLabel.font = UIFont(name: "SFProDisplay-Light", size: 16)
        
        return ethLabel
    }()
    
    private let growthLabel: UILabel = {
        let growthLabel = UILabel()
        growthLabel.text = "(+136,54%)"
        growthLabel.textColor = UIColor(red: 25/255, green: 151/255, blue: 106/255, alpha: 1)
        growthLabel.textAlignment = .right
        
        growthLabel.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        
        return growthLabel
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 36
        clipsToBounds = true
     
        addSubview(backgroundImageView)
        addSubview(nameLabel)
        addSubview(currencyIconView)
        addSubview(descriptionLabel)
        addSubview(priceLabel)
        addSubview(growthLabel)
        
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
        growthLabel.text = "\(item.growth.description)%"
        
    }
    
    //MARK: Constraints
    private func setupConstrainsts() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
