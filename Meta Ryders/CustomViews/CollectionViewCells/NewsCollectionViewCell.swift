//
//  NewsCollectionViewCell.swift
//  Meta Ryders
//
//  Created by Vladislav on 26.02.2022.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    private let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let sourceLabel: UILabel = {
        let sourceLabel = UILabel()
        
        return sourceLabel
    }()
    
    private let timePostedLabel: UILabel = {
        let timePostedLabel = UILabel()
        
        return timePostedLabel
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        clipsToBounds = true
                
        addArticleImageView()
        addTitleLabel()
        addSourceLabel()
        addTimePostedLabel()
    }
    
    public func configureNewsCollectionViewCell(by item: News) {
        titleLabel.text = item.title
        articleImageView.image = UIImage(named: item.imageName)
        sourceLabel.text = item.sourceName
        timePostedLabel.text = item.timePosted
    }
    
    private func addTitleLabel() {
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .left
        titleLabel.textColor = .black
        titleLabel.font = .standart(ofSize: 16, weight: .semibold)
        addSubview(titleLabel)
        titleLabel.lineBreakMode = .byWordWrapping
    
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(articleImageView.snp.trailing).offset(16)
            make.top.equalTo(articleImageView.snp.top)
            make.trailing.equalToSuperview().offset(-20)
            
        }
    }
    
    private func addArticleImageView() {
        articleImageView.clipsToBounds = true
        articleImageView.layer.cornerRadius = 12
        addSubview(articleImageView)
        
        articleImageView.snp.makeConstraints { make in
            make.top.equalTo(2)
            make.leading.equalTo(22)
            make.bottom.equalTo(-2)
        }
    }
    
    private func addSourceLabel() {
        sourceLabel.numberOfLines = 1
        sourceLabel.textAlignment = .left
        sourceLabel.textColor = .lightweightGray
        sourceLabel.font = .standart(ofSize: 14, weight: .regular)
        addSubview(sourceLabel)
        
        sourceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalTo(-24)
            make.left.equalTo(titleLabel.snp.left)
        }
    }
    
    private func addTimePostedLabel() {
        timePostedLabel.numberOfLines = 1
        timePostedLabel.textAlignment = .right
        timePostedLabel.textColor = .lightweightGray
        
        timePostedLabel.font = .standart(ofSize: 14, weight: .regular)
        addSubview(timePostedLabel)
        
        timePostedLabel.snp.makeConstraints { make in
            make.centerY.equalTo(sourceLabel.snp.centerY)
            make.leading.equalTo(sourceLabel.snp.trailing)
            make.trailing.equalTo(-20)
        }
    }
}
