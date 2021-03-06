//
//  TabBarView.swift
//  Meta Ryders
//
//  Created by Vladislav on 02.03.2022.
//

import UIKit

class TabBarView: UIView {
    enum Buttons {
        case camera
        case settings
    }
    private let homeButton = UIButton(frame: .zero)
    private let graphsButton = UIButton(frame: .zero)
    private let cameraButton = UIButton(frame: .zero)
    private let settingsButton = UIButton(frame: .zero)
    private let itemListButton = UIButton(frame: .zero)
    private let frameImageView = UIImageView()
    // for now I'm making few empty closures to set up navigation. Later on we can find cleaner way around, maybe coordinator pattern?
    var cameraPresentClosure = {}
    var settingsPresentClosure = {}
    var homeButtonClosure = {}
  
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
    
        backgroundColor = .tabBarColor
        setupTabBar()
        addFrameImageView()
        addCameraButton()
        addHomeButton()
        addGraphsButton()
        addItemListButton()
        addSettingsButton()
    }
   
    private func setupTabBar() {
        layer.cornerRadius = 26
        
        snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalTo(12)
            make.trailing.equalTo(-12)
            make.height.equalTo(90)
        }
    }
    
    private func addFrameImageView() {
        addSubview(frameImageView)
        frameImageView.image = UIImage(named: "cameraButtonFrame")
        frameImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-20)
        }
    }

    private func addHomeButton() {
        addSubview(homeButton)
        homeButton.setImage(UIImage(named: "homeButton")?.tint(with: .heavyWeightGray), for: .normal)
        homeButton.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
        
        homeButton.snp.makeConstraints { make in
            make.leading.equalTo(32)
            make.centerY.equalToSuperview()
        }
    }
    
    private func addGraphsButton() {
        addSubview(graphsButton)
        graphsButton.setImage(UIImage(named: "graphsButton"), for: .normal)
        graphsButton.addTarget(self, action: #selector(graphsButtonTapped), for: .touchUpInside)
        
        graphsButton.snp.makeConstraints { make in
            make.right.equalTo(frameImageView.snp.left).offset(-14)
            make.centerY.equalToSuperview()
        }
    }
    
    private func addCameraButton() {
        addSubview(cameraButton)
        cameraButton.setImage(UIImage(named: "noFrameCamera"), for: .normal)
        cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
        
        cameraButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(frameImageView.snp.centerY).offset(-4)
        }
    }
    
    private func addSettingsButton() {
        addSubview(settingsButton)
        settingsButton.setImage(UIImage(named: "settingsButton"), for: .normal)
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        
        settingsButton.snp.makeConstraints { make in
            make.trailing.equalTo(-32)
            make.centerY.equalToSuperview()
        }
    }
    
    private func addItemListButton() {
        addSubview(itemListButton)
        itemListButton.setImage(UIImage(named: "itemListButton"), for: .normal)
        itemListButton.addTarget(self, action: #selector(itemListButtonTapped), for: .touchUpInside)
        
        itemListButton.snp.makeConstraints { make in
            make.left.equalTo(frameImageView.snp.right).offset(14)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc private func homeButtonTapped() {
        homeButtonClosure()
    }
    
    @objc private func graphsButtonTapped() {
        print("Graphs Button - Tapped")
    }
    
    @objc private func cameraButtonTapped() {
       cameraPresentClosure()
    }
    
    @objc private func settingsButtonTapped() {
        settingsPresentClosure()
    }
    
    @objc private func itemListButtonTapped() {
        print("Item List Button - Tapped")
    }
}

extension UIImage {
    func tint(with color: UIColor) -> UIImage {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        image.draw(in: CGRect(origin: .zero, size: size))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
