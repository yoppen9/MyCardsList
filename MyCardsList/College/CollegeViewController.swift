//
//  CollegeViewController.swift
//  MyCardsList
//
//  Created by 山岸善将 on 2021/07/18.
//

import UIKit

var CollegeName: [String] = []
var CollegePhone: [String] = []
var CollegeDescription: [String] = []
var CollegePhotos: [Data] = []

class CollegeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!

    override func viewDidLoad() {
        super.viewDidLoad()
        if(UserDefaults.standard.array(forKey: "College1") != nil) {
            CollegeName = UserDefaults.standard.array(forKey: "College1") as! [String]
        }
        if(UserDefaults.standard.array(forKey: "College2") != nil) {
            CollegePhone = UserDefaults.standard.array(forKey: "College2") as! [String]
        }
        if(UserDefaults.standard.array(forKey: "College3") != nil) {
            CollegePhotos = UserDefaults.standard.array(forKey: "College3") as! [Data]
        }
        if(UserDefaults.standard.array(forKey: "College4") != nil) {
            CollegeDescription = UserDefaults.standard.array(forKey: "College4") as! [String]
        }
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        collectionView.collectionViewLayout = layout
    }
    @IBAction func settingButton(_ sender: Any) {
        let nextView5 = storyboard?.instantiateViewController(identifier: "next5") as! CollegeSettingViewController
        nextView5.presentationController?.delegate = self
        present(nextView5, animated: true, completion: nil)
    }
}

extension CollegeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let nameCell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollegeCell", for: indexPath)
        let label = nameCell.contentView.viewWithTag(1) as! UILabel
        let label2 = nameCell.contentView.viewWithTag(2) as! UILabel
        let image3 = nameCell.contentView.viewWithTag(3) as! UIImageView
        let textView4 = nameCell.contentView.viewWithTag(4) as! UILabel
        label.text = CollegeName[indexPath.row]
        label2.text = CollegePhone[indexPath.row]
        image3.image = UIImage(data: CollegePhotos[indexPath.row])
        textView4.text = CollegeDescription[indexPath.row]
        return nameCell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CollegeName.count
    }
}

extension CollegeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalSpace: CGFloat = 20
        let cellSize: CGFloat = self.view.bounds.width / 3 - horizontalSpace
        let heightSize: CGFloat = cellSize * 1.5
        return CGSize(width: cellSize, height: heightSize)
    }
}

extension CollegeViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        collectionView.reloadData()
    }
}
