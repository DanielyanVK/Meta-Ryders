//
//  NewsTableViewCell.swift
//  Meta Ryders
//
//  Created by Vladislav on 28.03.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    private let articleLabel = UILabel()
    private let articleImageView = UIImageView()
    private let titleLabel = UILabel()
    private let sourceLabel = UILabel()
    private let timePostedLabel = UILabel()

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        selectionStyle = .none
        backgroundColor = .mediumWeightGray
        addTitleLabel()
        addSourceLabel()
        addArticleImageView()
        addArticleLabel()
        addTimePostedLabel()
    }
    
    public func configure(by news: News) {
        articleLabel.text = news.article
        articleImageView.image = UIImage(named: news.imageName)
        titleLabel.text = news.title
        sourceLabel.text = news.sourceName
        timePostedLabel.text = "• \(news.timePosted)"
    }
    
    private func addArticleLabel() {
        addSubview(articleLabel)
        articleLabel.numberOfLines = 0
        articleLabel.textAlignment = .left
        articleLabel.textColor = .black
        articleLabel.font = .rounded(ofSize: 18, weight: .regular)
        articleLabel.snp.makeConstraints { make in
            make.top.equalTo(articleImageView.snp.bottom).offset(30)
            make.bottom.equalToSuperview()
            make.leading.equalTo(12)
            make.trailing.equalTo(-12)
        }
    }
    
    private func addArticleImageView() {
        addSubview(articleImageView)
        articleImageView.clipsToBounds = true
        articleImageView.contentMode = .scaleAspectFill
        articleImageView.snp.makeConstraints { make in
            make.top.equalTo(sourceLabel.snp.bottom).offset(30)
            make.leading.equalTo(12)
            make.trailing.equalTo(-12)
        }
    }
    
    private func addTitleLabel() {
        addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        titleLabel.textColor = .black
        titleLabel.font = .rounded(ofSize: 22, weight: .semibold)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(4)
            make.leading.equalTo(12)
            make.trailing.equalTo(-12)
        }
    }
    
    private func addSourceLabel() {
        addSubview(sourceLabel)
        sourceLabel.textAlignment = .left
        sourceLabel.textColor = .heavyWeightGray
        sourceLabel.font = .rounded(ofSize: 18, weight: .regular)
        sourceLabel.snp.makeConstraints { make in
            make.leading.equalTo(12)
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
        }
    }
    
    private func addTimePostedLabel() {
        addSubview(timePostedLabel)
        timePostedLabel.textAlignment = .left
        timePostedLabel.textColor = .heavyWeightGray
        timePostedLabel.font = .rounded(ofSize: 18, weight: .regular)
        timePostedLabel.snp.makeConstraints { make in
            make.left.equalTo(sourceLabel.snp.right).offset(6)
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
        }
    }
}
