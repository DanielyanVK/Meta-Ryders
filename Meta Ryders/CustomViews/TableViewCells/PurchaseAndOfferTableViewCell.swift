//
//  PurchaseAndOfferTableViewCell.swift
//  Meta Ryders
//
//  Created by Vladislav on 07.03.2022.
//

import UIKit

class PurchaseAndOfferTableViewCell: UITableViewCell {
    private let makeOfferButton = UIButton(frame: .zero)
    private let purchaseButton = UIButton(frame: .zero)

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        backgroundColor = .black
        selectionStyle = .none
        sendSubviewToBack(contentView)
        addPurchaseButton()
        addMakeOfferButton()
    }

    private func addMakeOfferButton() {
        addSubview(makeOfferButton)
        makeOfferButton.setImage(UIImage(named: "makeOfferButton-cropped"), for: .normal)
        makeOfferButton.addTarget(self, action: #selector(makeOfferButtonTapped), for: .touchUpInside)
        makeOfferButton.snp.makeConstraints { make in
            make.leading.equalTo(32)
            make.trailing.equalTo(-200)
            make.top.equalToSuperview()
            make.bottom.equalTo(-20)
        }
    }
    
    private func addPurchaseButton() {
        addSubview(purchaseButton)
        purchaseButton.setImage(UIImage(named: "purchaseButton-cropped"), for: .normal)
        purchaseButton.addTarget(self, action: #selector(purchaseButtonTapped), for: .touchUpInside)
        purchaseButton.snp.makeConstraints { make in
            
            make.leading.equalTo(200)
            make.trailing.equalTo(-32)
            make.top.equalToSuperview()
            make.bottom.equalTo(-20)
        }
    }
    
    @objc private func makeOfferButtonTapped() {
        print("Make Offer Button - Tapped")
    }
    
    @objc private func purchaseButtonTapped() {
        print("Purchase Button - Tapped")
    }
}
