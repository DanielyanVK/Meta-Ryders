//
//  CategoriesHeaderVieww.swift
//  Meta Ryders
//
//  Created by Vladislav on 22.02.2022.
//

import UIKit

class CategoriesHeaderView: UITableViewHeaderFooterView {
    
    private let headerLabel: UILabel = {
        let headerLabel = UILabel()
    
        return headerLabel
    }()
    
    private let shadowView: UIView = {
        let shadowView = UIView()
        
        return shadowView
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        addLabel()
        backgroundColor = .mediumWeightGray
    }
    
    private func addLabel() {
        
        headerLabel.font = .standart(ofSize: 18, weight: .bold)
        headerLabel.text = "Testing"
        headerLabel.textAlignment = .left
        contentView.backgroundColor = .mediumWeightGray
        addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { make in
            make.leading.equalTo(20)
        }
    }
    
    private func addShadowView() {
        backgroundColor = .mediumWeightGray
        addSubview(shadowView)
        
        shadowView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
