//
//  TitleCollectionViewController.swift
//  MyCardsList
//
//  Created by 山岸善将 on 2021/09/10.
//

import UIKit
import GoogleMobileAds

class TitleCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, GADBannerViewDelegate {
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    private let model: TitleListModel = TitleListModel()
    let titleListImage = ["family","bf","local","highSchool","college","company",""]
    let titleListName = ["家族","親友","地元友達","高校友達","大学友達","会社","その他"]
    
    var listModel: TitleCollectionViewCell!
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
//        addBannerViewToView(bannerView)
//        bannerView.adUnitID = "ca-app-pub-1642371430465959/4309452198"
//        bannerView.rootViewController = self
//        bannerView.load(GADRequest())
//        bannerView.delegate = self
        
        listCollectionView.dataSource = self
        listCollectionView.delegate = self
        
        let nib = UINib(nibName: "TitleCollectionViewCell", bundle: .main)
        listCollectionView.register(nib, forCellWithReuseIdentifier: "listCell")
    }
//    func addBannerViewToView(_ bannerView: GADBannerView) {
//        bannerView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(bannerView)
//        view.addConstraints(
//            [NSLayoutConstraint(item: bannerView,
//                                attribute: .bottom,
//                                relatedBy: .equal,
//                                toItem: bottomLayoutGuide,
//                                attribute: .top,
//                                multiplier: 1,
//                                constant: 0),
//             NSLayoutConstraint(item: bannerView,
//                                attribute: .centerX,
//                                relatedBy: .equal,
//                                toItem: view,
//                                attribute: .centerX,
//                                multiplier: 1,
//                                constant: 0)
//            ])
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCardsList" {
            let nextVC = segue.destination as! CardListViewController
            nextVC.model = model
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.cardsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let listCell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath)
        
        let listName = listCell.contentView.viewWithTag(11) as! UILabel
        listName.text = titleListName[indexPath.row]
        
        let imageView = listCell.contentView.viewWithTag(22) as! UIImageView
        let cellImage = UIImage(named: titleListImage[indexPath.row])
        imageView.image = cellImage
        
        listCell.backgroundColor = .white
        listCell.layer.cornerRadius = 12
        listCell.layer.shadowOpacity = 0.4
        listCell.layer.shadowRadius = 12
        listCell.layer.shadowColor = UIColor.black.cgColor
        listCell.layer.shadowOffset = CGSize(width: 7, height: 7)
        listCell.layer.masksToBounds = false
        
        return listCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalSpace : CGFloat = 20
        let cellSize : CGFloat = self.view.bounds.width / 2 - horizontalSpace
        return CGSize(width: cellSize, height: cellSize)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 10, bottom: 30, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        switch model.cardsList[indexPath.row] {
        case "家族":
            model.sectionTitle = "家族"
            model.section = .familySection
            self.performSegue(withIdentifier: "showCardsList", sender: nil)
        case "親友":
            model.sectionTitle = "親友"
            model.section = .bfSection
            self.performSegue(withIdentifier: "showCardsList", sender: nil)
        case "地元友達":
            model.sectionTitle = "地元友達"
            model.section = .localSection
            self.performSegue(withIdentifier: "showCardsList", sender: nil)
        case "高校友達":
            model.sectionTitle = "高校友達"
            model.section = .highSchoolSection
            self.performSegue(withIdentifier: "showCardsList", sender: nil)
        case "大学友達":
            model.sectionTitle = "大学"
            model.section = .collegeSection
            self.performSegue(withIdentifier: "showCardsList", sender: nil)
        case "会社":
            model.sectionTitle = "会社"
            model.section = .companySection
            self.performSegue(withIdentifier: "showCardsList", sender: nil)
        case "その他":
            model.sectionTitle = "その他"
            model.section = .otherSection
            self.performSegue(withIdentifier: "showCardsList", sender: nil)
        default:
            return
        }
    }
}

