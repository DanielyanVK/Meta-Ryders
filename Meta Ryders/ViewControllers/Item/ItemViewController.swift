//
//  ItemViewController.swift
//  Meta Ryders
//
//  Created by Danil Kovalev on 20.02.2022.
//

import UIKit
import Hero

class ItemViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    private var item: Item?
    private var heroId: String?
    
    convenience init(item: Item?, heroId: String? = nil) {
        self.init()
        
        self.item = item
        self.heroId = heroId
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.hero.id = heroId
        imageView.image = UIImage(named: item?.imageName ?? "")
        imageView.clipsToBounds = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        dismiss(animated: true, completion: nil)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
