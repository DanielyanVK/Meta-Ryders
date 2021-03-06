//
//  NewsCollectionViewCell.swift
//  Meta Ryders
//
//  Created by Vladislav on 26.02.2022.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    private let articleImageView = UIImageView()
    private let titleLabel = UILabel()
    private let sourceLabel = UILabel()
    private let timePostedLabel = UILabel()
    
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
            make.left.equalTo(articleImageView.snp.right).offset(16)
            make.top.equalTo(articleImageView.snp.top)
            make.trailing.equalToSuperview()
        }
    }
    
    private func addArticleImageView() {
        articleImageView.clipsToBounds = true
        articleImageView.layer.cornerRadius = 12
        articleImageView.contentMode = .scaleAspectFill
        addSubview(articleImageView)
        
        articleImageView.snp.makeConstraints { make in
            make.top.equalTo(2)
            make.leading.equalTo(2)
            make.width.equalTo(96)
            make.height.equalTo(96)
        }
    }
    
    private func addSourceLabel() {
        sourceLabel.numberOfLines = 1
        sourceLabel.textAlignment = .left
        sourceLabel.textColor = .lightweightGray
        sourceLabel.font = .standart(ofSize: 14, weight: .regular)
        addSubview(sourceLabel)
        
        sourceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(-18)
            make.left.equalTo(titleLabel.snp.left)
        }
    }
    
    private func addTimePostedLabel() {
        timePostedLabel.numberOfLines = 1
        timePostedLabel.textAlignment = .left
        timePostedLabel.textColor = .lightweightGray
        timePostedLabel.font = .standart(ofSize: 14, weight: .regular)
        addSubview(timePostedLabel)
        
        timePostedLabel.snp.makeConstraints { make in
            make.bottom.equalTo(sourceLabel.snp.bottom)
            make.trailing.equalTo(-20)
        }
    }
}
