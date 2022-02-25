//
//  CategoriesHeaderView.swift
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
    
    //Might be better to use one method with enum instead of 2 methods
    func configureForItems() {
        headerLabel.text = "NFTs by Categories"
        seeAllButton.addTarget(self, action: #selector(seeAllTappedForCategory), for: .touchUpInside)
    }
    
    func configureForNotFallable() {
        headerLabel.text = "Not Fallable NFTs"
        seeAllButton.addTarget(self, action: #selector(seeAllTappedForNotFallable), for: .touchUpInside)
    }
    
    private func addLabel() {
        headerLabel.font = .rounded(ofSize: 18, weight: .semibold)
        headerLabel.textAlignment = .left
        backgroundColor = .mediumWeightGray
        addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { make in
            make.leading.equalTo(20)
        }
    }
    
    @objc private func seeAllTappedForCategory() {
        print("See all - tapped in NFTs by Categories")
    }
    
    @objc private func seeAllTappedForNotFallable() {
        print("See all - tapped in Not Fallable NFTs")
    }
    
    private func addSeeAllButton() {
        addSubview(seeAllButton)
        seeAllButton.setTitle("See all", for: .normal)
        seeAllButton.titleLabel?.font = .rounded(ofSize: 18, weight: .semibold)
        seeAllButton.setTitleColor(.purpleHeaderButton, for: .normal)
        
        seeAllButton.snp.makeConstraints { make in
            make.trailing.equalTo(-20)
            make.centerY.equalTo(headerLabel.snp.centerY)
        }
    }
}
