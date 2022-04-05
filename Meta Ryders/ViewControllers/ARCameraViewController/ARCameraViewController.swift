//
//  CameraPreviewViewController.swift
//  Nft
//
//  Created by 1 on 14.02.2022.
//

import UIKit
import ARKit
import SnapKit

class ARCameraViewController: UIViewController {
    
    //MARK: MOCKUP DATA - REMOVE LATER
    private var array = [Item(name: "Bella Doll", imageName: "BellaDoll", description: "These ancient beings have been around since the dawn of time...", price: 9861.37, growth: 10), Item(name: "Abstract Pink", imageName: "AbstractPainting", description: "A CNS or UNS blockhain domain.", price: 0.906, growth: 6.2), Item(name: "Monkey", imageName: "AbstractPainting2", description: "The only thing is out for Harambe - is that T-pose", price: 1.314, growth: -5), Item(name: "Wave", imageName: "BellaDoll2", description: "Cool abstract painting", price: 2.212, growth: 35)]
    
   private var cameraCollectionView: UICollectionView!
   private var sceneView = ARSCNView()
   private let config = ARWorldTrackingConfiguration()
   private var backButton = UIButton()
   private var discoverButton = UIButton()
   private var headerLabel = UILabel()
   private var collectionViewHeight = UIScreen.main.bounds.height*0.3
    
    private var screenSize: CGRect = {
        return UIScreen.main.bounds
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designConfigure()
    }
    
    private func designConfigure() {
        sceneViewConfig()
        collectionViewConfigure()
        discoverButtonConfigure()
        backButtonConfigure()
        headerLabelConfigure()
    }
    
    private func sceneViewConfig() {
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        sceneView.session.run(config)
        view.addSubview(sceneView)
        sceneView.backgroundColor = .darkGray
        sceneView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func collectionViewConfigure() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        cameraCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.addSubview(cameraCollectionView!)
        cameraCollectionView?.backgroundColor = .clear
        cameraCollectionView?.showsHorizontalScrollIndicator = false
        
        cameraCollectionView?.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-screenSize.height*0.055)
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(collectionViewHeight)
        }
        
        cameraCollectionView?.delegate = self
        cameraCollectionView?.dataSource = self
        cameraCollectionView?.clipsToBounds = false
    }
    
    private func backButtonConfigure() {
        
        view.addSubview(backButton)
        
        backButton.setImage(UIImage(named: "back_camera"), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        
        backButton.snp.makeConstraints { make in
            make.width.equalTo(screenSize.width*0.16)
            make.height.equalTo(backButton.snp.width).multipliedBy(0.5)
            make.centerY.equalTo(discoverButton)
            make.leading.equalTo(screenSize.width*0.06)
        }
    }
    
    @objc private func backButtonAction(sender: UIButton!) {
        print("Back button works!")
    }
    
    private func discoverButtonConfigure() {
        
        view.addSubview(discoverButton)
        
        discoverButton.setImage(UIImage(named: "discover_camera"), for: .normal)
        discoverButton.imageView?.contentMode = .scaleAspectFit
        discoverButton.addTarget(self, action: #selector(discoverButtonAction), for: .touchUpInside)
        
        discoverButton.snp.makeConstraints { make in
            make.width.equalTo(discoverButton.snp.height).multipliedBy(1)
            make.height.equalTo(screenSize.height*0.08)
            make.top.equalTo(screenSize.height*0.06)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func discoverButtonAction(sender: UIButton!) {
        print("Discover button works!")
    }
    
    private func headerLabelConfigure() {
        view.addSubview(headerLabel)
        headerLabel.text = "Click to deploy"
        headerLabel.textColor = .white
        headerLabel.font = .rounded(ofSize: 20, weight: .semibold)
        headerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalTo(cameraCollectionView.snp.top).offset(-10)
        }
    }
}

extension ARCameraViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension ARCameraViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cameraCollectionView?.register(CameraItemCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        let cell = cameraCollectionView?.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CameraItemCollectionViewCell
        cell.mainImageView.image = UIImage.init(named: array[indexPath.row].imageName)
        cell.nameLabel.text = array[indexPath.row].name
        cell.priceLabel.text = "\(array[indexPath.row].price)"
        cell.descriptionLabel.text = array[indexPath.row].description
        cell.orderLabel.text = "\(array[indexPath.row].growth)"
        cell.buttonClosure = {
            print(self.array[indexPath.row].name)
        }
        return cell
    }
}

extension ARCameraViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionViewHeight*0.67, height: collectionViewHeight-1)
    }
}
