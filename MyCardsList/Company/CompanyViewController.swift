//
//  CompanyViewController.swift
//  MyCardsList
//
//  Created by 山岸善将 on 2021/07/18.
//

import UIKit

var CompanyName: [String] = []
var CompanyPhone: [String] = []
var CompanyDescription: [String] = []
var CompanyPhotos: [Data] = []

class CompanyViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(UserDefaults.standard.array(forKey: "Company1") != nil) {
            CompanyName = UserDefaults.standard.array(forKey: "Company1") as! [String]
        }
        if(UserDefaults.standard.array(forKey: "Company2") != nil) {
            CompanyPhone = UserDefaults.standard.array(forKey: "Company2") as! [String]
        }
        if(UserDefaults.standard.array(forKey: "Company3") != nil) {
            CompanyPhotos = UserDefaults.standard.array(forKey: "Company3") as! [Data]
        }
        if(UserDefaults.standard.array(forKey: "Company4") != nil) {
            CompanyDescription = UserDefaults.standard.array(forKey: "Company4") as! [String]
        }
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        collectionView.collectionViewLayout = layout
    }
    @IBAction func settingButton(_ sender: Any) {
        let nextView6 = storyboard?.instantiateViewController(identifier: "next6") as! CompanySettingViewController
        nextView6.presentationController?.delegate = self
        present(nextView6, animated: true, completion: nil)
    }
}

extension CompanyViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let nameCell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompanyCell", for: indexPath)
        let label = nameCell.contentView.viewWithTag(1) as! UILabel
        let label2 = nameCell.contentView.viewWithTag(2) as! UILabel
        let image3 = nameCell.contentView.viewWithTag(3) as! UIImageView
        let textView4 = nameCell.contentView.viewWithTag(4) as! UILabel
        label.text = CompanyName[indexPath.row]
        label2.text = CompanyPhone[indexPath.row]
        image3.image = UIImage(data: CompanyPhotos[indexPath.row])
        textView4.text = CompanyDescription[indexPath.row]
        return nameCell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CompanyName.count
    }
}

extension CompanyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalSpace: CGFloat = 20
        let cellSize: CGFloat = self.view.bounds.width / 3 - horizontalSpace
        let heightSize: CGFloat = cellSize * 1.5
        return CGSize(width: cellSize, height: heightSize)
    }
}

extension CompanyViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        collectionView.reloadData()
    }
}
