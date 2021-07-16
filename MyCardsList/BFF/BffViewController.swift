//
//  BffViewController.swift
//  MyCardsList
//
//  Created by 山岸善将 on 2021/07/16.
//

import UIKit

var BfName: [String] = []
var BfPhone: [String] = []
var BfDescription: [String] = []
var BfPhotos: [Data] = []

class BffViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(UserDefaults.standard.array(forKey: "Bf1") != nil) {
            BfName = UserDefaults.standard.array(forKey: "Bf1") as! [String]
        }
        if(UserDefaults.standard.array(forKey: "Bf2") != nil) {
            BfPhone = UserDefaults.standard.array(forKey: "Bf2") as! [String]
        }
        if(UserDefaults.standard.array(forKey: "Bf3") != nil) {
            BfPhotos = UserDefaults.standard.array(forKey: "Bf3") as! [Data]
        }
        if(UserDefaults.standard.array(forKey: "Bf4") != nil) {
            BfDescription = UserDefaults.standard.array(forKey: "Bf4") as! [String]
        }
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        collectionView.collectionViewLayout = layout
    }
    @IBAction func settingButton(_ sender: Any) {
        let nextView2 = storyboard?.instantiateViewController(identifier: "next2") as! BfSettingViewController
        nextView2.presentationController?.delegate = self
        present(nextView2, animated: true, completion: nil)
    }
}

extension BffViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let nameCell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BfCell", for: indexPath)
            let label = nameCell.contentView.viewWithTag(1) as! UILabel
            let label2 = nameCell.contentView.viewWithTag(2) as! UILabel
            let image3 = nameCell.contentView.viewWithTag(3) as! UIImageView
            let textView4 = nameCell.contentView.viewWithTag(4) as! UILabel
            label.text = BfName[indexPath.row]
            label2.text = BfPhone[indexPath.row]
            image3.image = UIImage(data: BfPhotos[indexPath.row])
            textView4.text = BfDescription[indexPath.row]
            return nameCell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return BfName.count
    }
}

extension BffViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalSpace: CGFloat = 20
        let cellSize: CGFloat = self.view.bounds.width / 3 - horizontalSpace
        let heightSize: CGFloat = cellSize * 1.5
        return CGSize(width: cellSize, height: heightSize)
    }
}

extension BffViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        collectionView.reloadData()
    }
}
