//
//  CardsViewController.swift
//  MyCardsList
//
//  Created by 山岸善将 on 2021/07/03.
//

import UIKit

var name: [String] = []
var phoneNumber: [String] = []
var photos: [Data] = []
var description1: [String] = []

class CardsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(UserDefaults.standard.array(forKey: "listPass") != nil) {
            name = UserDefaults.standard.array(forKey: "listPass") as! [String]
        }
        if(UserDefaults.standard.array(forKey: "listPass2") != nil) {
            phoneNumber = UserDefaults.standard.array(forKey: "listPass2") as! [String]
        }
        if(UserDefaults.standard.array(forKey: "listPass3") != nil) {
            photos = UserDefaults.standard.array(forKey: "listPass3") as! [Data]
        }
        if(UserDefaults.standard.array(forKey: "listPass4") != nil) {
            description1 = UserDefaults.standard.array(forKey: "listPass4") as! [String]
        }
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        collectionView.collectionViewLayout = layout
    }
    @IBAction func settingButton(_ sender: Any) {
        let nextView = storyboard?.instantiateViewController(identifier: "next") as! SettingViewController
        nextView.presentationController?.delegate = self
        present(nextView, animated: true, completion: nil)
    }
}

extension CardsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let nameCell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardsImage", for: indexPath)
        let label = nameCell.contentView.viewWithTag(1) as! UILabel
        let label2 = nameCell.contentView.viewWithTag(2) as! UILabel
        let image3 = nameCell.contentView.viewWithTag(3) as! UIImageView
        let textView4 = nameCell.contentView.viewWithTag(4) as! UILabel
        label.text = name[indexPath.row]
        label2.text = phoneNumber[indexPath.row]
        image3.image = UIImage(data: photos[indexPath.row])
        textView4.text = description1[indexPath.row]
        return nameCell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return name.count
    }
}

extension CardsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalSpace:CGFloat = 20
        let cellSize:CGFloat = self.view.bounds.width / 3 - horizontalSpace
        let heightSize:CGFloat = cellSize * 1.5
        return CGSize(width: cellSize, height: heightSize)
    }
}

extension CardsViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        collectionView.reloadData()
    }
}
