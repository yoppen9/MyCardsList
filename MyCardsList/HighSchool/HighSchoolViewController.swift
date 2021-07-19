//
//  HighSchoolViewController.swift
//  MyCardsList
//
//  Created by 山岸善将 on 2021/07/17.
//

import UIKit

var HighSchoolName: [String] = []
var HighSchoolPhone: [String] = []
var HighSchoolDescription: [String] = []
var HighSchoolPhotos: [Data] = []

class HighSchoolViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(UserDefaults.standard.array(forKey: "HighSchool1") != nil) {
            HighSchoolName = UserDefaults.standard.array(forKey: "HighSchool1") as! [String]
        }
        if(UserDefaults.standard.array(forKey: "HighSchool2") != nil) {
            HighSchoolPhone = UserDefaults.standard.array(forKey: "HighSchool2") as! [String]
        }
        if(UserDefaults.standard.array(forKey: "HighSchool3") != nil) {
            HighSchoolPhotos = UserDefaults.standard.array(forKey: "HighSchool3") as! [Data]
        }
        if(UserDefaults.standard.array(forKey: "HighSchool4") != nil) {
            HighSchoolDescription = UserDefaults.standard.array(forKey: "HighSchool4") as! [String]
        }
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        collectionView.collectionViewLayout = layout
    }
    @IBAction func settingButton(_ sender: Any) {
        let nextView4 = storyboard?.instantiateViewController(identifier: "next4") as! HighSchoolSettingViewController
        nextView4.presentationController?.delegate = self
        present(nextView4, animated: true, completion: nil)
    }
}

extension HighSchoolViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let nameCell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HighSchoolCell", for: indexPath)
        let label = nameCell.contentView.viewWithTag(1) as! UILabel
        let label2 = nameCell.contentView.viewWithTag(2) as! UILabel
        let image3 = nameCell.contentView.viewWithTag(3) as! UIImageView
        let textView4 = nameCell.contentView.viewWithTag(4) as! UILabel
        label.text = HighSchoolName[indexPath.row]
        label2.text = HighSchoolPhone[indexPath.row]
        image3.image = UIImage(data: HighSchoolPhotos[indexPath.row])
        textView4.text = HighSchoolDescription[indexPath.row]
        return nameCell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HighSchoolName.count
    }
}

extension HighSchoolViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalSpace: CGFloat = 20
        let cellSize: CGFloat = self.view.bounds.width / 3 - horizontalSpace
        let heightSize: CGFloat = cellSize * 1.5
        return CGSize(width: cellSize, height: heightSize)
    }
}

extension HighSchoolViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        collectionView.reloadData()
    }
}
