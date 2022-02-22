//
//  ItemViewController.swift
//  Meta Ryders
//
//  Created by Danil Kovalev on 20.02.2022.
//

import UIKit
import Hero

class ItemViewController: UIViewController {

    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        
        return imageView
    }()
    
    private var item: Item?
    private var heroId: String?
    
    convenience init(item: Item?, heroId: String? = nil) {
        self.init()
        
        self.item = item
        self.heroId = heroId
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heroImageView.hero.id = heroId
        heroImageView.image = UIImage(named: item?.imageName ?? "")
        heroImageView.clipsToBounds = true
        addHeroImageView()
        view.backgroundColor = .white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        dismiss(animated: true, completion: nil)
    }

    func addHeroImageView() {
        heroImageView.clipsToBounds = true
        heroImageView.layer.cornerRadius = 13
        view.addSubview(heroImageView)
        
        heroImageView.snp.makeConstraints { make in
            make.top.equalTo(60)
            make.height.equalTo(350)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
    }

}
