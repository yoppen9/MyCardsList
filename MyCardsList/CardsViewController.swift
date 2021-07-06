//
//  CardsViewController.swift
//  MyCardsList
//
//  Created by 山岸善将 on 2021/07/03.
//

import UIKit

class CardsViewController: UIViewController {
    
    @IBOutlet weak var cardsName: UILabel!
    @IBOutlet weak var cardsImage: UIImageView!
    @IBOutlet weak var cardsFace: UIImageView!
    @IBOutlet weak var cardsDescription: UILabel!
    @IBOutlet weak var cardsTel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func settingButton(_ sender: Any) {
        performSegue(withIdentifier: "settingSegue", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "settingSegue" {
            let next = segue.destination as? SettingViewController
            next?.resultHandler = { text in
                self.cardsName.text = text
            }
            next?.resultHandler2 = { text in
                self.cardsDescription.text = text
            }
            next?.resultHandler3 = { text in
                
                self.cardsTel.text = text
            }
        }
    }
}
