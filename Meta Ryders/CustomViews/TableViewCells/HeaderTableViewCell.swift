//
//  HeaderTableViewCell.swift
//  Meta Ryders
//
//  Created by Vladislav on 07.03.2022.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    private let iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.image = UIImage()
        return iconView
    }()
    
    private let headerLabel: UILabel = {
        let headerLabel = UILabel()
        return headerLabel
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        backgroundColor = .black
        selectionStyle = .none
        addIconView()
        addHeaderLabel()
    }
    
    public func configureHeaderTableViewCell(with variation: HeaderVariations) {
        switch variation {
        case .priceHistory:
            headerLabel.text = "Price history"
            iconView.image = UIImage(named: "priceHistoryIcon")
        case .similarItems:
            headerLabel.text = "Similar items"
            iconView.image = UIImage(named: "similarItemsIcon")
        }
    }
    
    private func addIconView() {
        addSubview(iconView)
        
        iconView.snp.makeConstraints { make in
            make.leading.equalTo(36)
            make.top.equalTo(2)
            make.bottom.equalTo(-16)
        }
    }
    
    private func addHeaderLabel() {
        addSubview(headerLabel)
        headerLabel.numberOfLines = 1
        headerLabel.textAlignment = .left
        headerLabel.textColor = .white
        headerLabel.font = .rounded(ofSize: 18, weight: .bold)
        
        headerLabel.snp.makeConstraints { make in
            make.left.equalTo(iconView.snp.right).offset(10)
            make.top.equalTo(iconView.snp.top).offset(-4)
        }
    }
    
    enum HeaderVariations {
        case priceHistory
        case similarItems
    }
}
