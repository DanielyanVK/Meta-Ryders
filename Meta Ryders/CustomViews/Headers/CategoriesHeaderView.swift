//
//  CategoriesHeaderVieww.swift
//  Meta Ryders
//
//  Created by Vladislav on 22.02.2022.
//

import UIKit

class CategoriesHeaderView: UIView {
    
    private let headerLabel: UILabel = {
        let headerLabel = UILabel()
    
        return headerLabel
    }()
    
    private let seeAllButton = UIButton(frame: .zero)

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        addLabel()
        addSeeAllButton()
        backgroundColor = .mediumWeightGray
    }
    
    private func addLabel() {
        headerLabel.font = .rounded(ofSize: 18, weight: .semibold)
        headerLabel.text = "NFTs by Categories"
        headerLabel.textAlignment = .left
        backgroundColor = .mediumWeightGray
        addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { make in
            make.leading.equalTo(20)
        }
    }
    
    @objc private func seeAllButtonTapped(_ sender: UIButton) {
        print("See all - tapped")
    }
    
    private func addSeeAllButton() {
        addSubview(seeAllButton)
        seeAllButton.addTarget(self, action: #selector(seeAllButtonTapped(_:)), for: .touchUpInside)
        seeAllButton.setTitle("See all", for: .normal)
        seeAllButton.titleLabel?.font = .rounded(ofSize: 18, weight: .semibold)
        seeAllButton.setTitleColor(.purpleHeaderButton, for: .normal)
        
        seeAllButton.snp.makeConstraints { make in
            make.trailing.equalTo(-20)
            make.centerY.equalTo(headerLabel.snp.centerY)
        }
    }
}
