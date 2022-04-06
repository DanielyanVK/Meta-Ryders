//
//  PriceAndImageTableViewCell.swift
//  Meta Ryders
//
//  Created by Vladislav on 05.03.2022.
//

import UIKit
import SceneKit

class PriceAndImageTableViewCell: UITableViewCell {
    
    private let sceneView = SCNView(frame: .zero)
    let heroImageView = UIImageView()
    private let currencyIconView = UIImageView()
    private let priceLabel = UILabel()
    private let degreesLabel = UILabel()
    private let roundedArrowImageView = UIImageView()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        backgroundColor = .black
        selectionStyle = .none
        sendSubviewToBack(contentView)
        // we will figure out how to show regular image view when 3d model is nil
   //     addHeroImageView()
        addSceneView()
        addPriceLabel()
        addCurrencyIconView()
        addRoundedArrowImageView()
        addDegreesLabel()
    }
    
    public func configurePriceAndImageCell(by item: Item) {
        heroImageView.image = UIImage(named: item.imageName)
        priceLabel.text = "ETH \(item.price.description)"
        // scene configuration
        // 1: Load .obj file
        let scene = SCNScene(named: item.modelName)
     //   let scene = SCNScene(named: "Squid_Games_Leader_mask.obj")
        // 2: Add camera node
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        // 3: Place camera
        cameraNode.position = SCNVector3(x: 0, y: 12, z: 45)
        // 4: Set camera on scene
        scene?.rootNode.addChildNode(cameraNode)
        // 5: Adding light to scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 40)
        scene?.rootNode.addChildNode(lightNode)
        // 6: Creating and adding ambien light to scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor.darkGray
        scene?.rootNode.addChildNode(ambientLightNode)
        sceneView.scene = scene
    }
    
    private func addSceneView() {
        addSubview(sceneView)
        // Allow user to manipulate camera
        sceneView.allowsCameraControl = true
        // Show FPS logs and timming
        // sceneView.showsStatistics = true
        // Set background color
        sceneView.backgroundColor = UIColor.black
        // Set scene settings
        sceneView.snp.makeConstraints { make in
            make.top.equalTo(40)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(350)
        }
    }
    
    private func addRoundedArrowImageView() {
        addSubview(roundedArrowImageView)
        roundedArrowImageView.image = UIImage(named: "roundedArrow")
        roundedArrowImageView.clipsToBounds = true
        roundedArrowImageView.snp.makeConstraints { make in
            make.top.equalTo(64)
            make.centerX.equalToSuperview()
        }
    }
    
    private func addDegreesLabel() {
        addSubview(degreesLabel)
        degreesLabel.textColor = .white
        degreesLabel.text = "360"
        degreesLabel.numberOfLines = 1
        degreesLabel.textAlignment = .center
        // setting font without extension because we are using this font once throughout all project
        degreesLabel.font = UIFont(name: "Orbitron-Bold", size: 18)
        degreesLabel.snp.makeConstraints { make in
            make.top.equalTo(40)
            make.centerX.equalToSuperview().offset(2)
        }
        
    }
    
    private func addHeroImageView() {
        addSubview(heroImageView)
        heroImageView.clipsToBounds = true
        heroImageView.layer.cornerRadius = 13
        heroImageView.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.height.equalTo(350)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
    }
    
    private func addCurrencyIconView() {
        addSubview(currencyIconView)
        currencyIconView.image = UIImage(named: "ethBigIcon")
        currencyIconView.clipsToBounds = true
        currencyIconView.snp.makeConstraints { make in
            make.right.equalTo(priceLabel.snp.left).offset(-6)
            make.top.equalTo(sceneView.snp.bottom).offset(38)
        }
    }
    
    private func addPriceLabel() {
        addSubview(priceLabel)
        priceLabel.textColor = .white
        priceLabel.numberOfLines = 2
        priceLabel.textAlignment = .left
        // setting font without extension because we are using this font once throughout all project
        priceLabel.font = UIFont(name: "Orbitron-Bold", size: 18)
        
        priceLabel.snp.makeConstraints { make in
            make.trailing.equalTo(-32)
            make.top.equalTo(sceneView.snp.bottom).offset(28)
            make.width.lessThanOrEqualTo(70)
        }
    }
}
