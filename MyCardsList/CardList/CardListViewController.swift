//
//  BffViewController.swift
//  MyCardsList
//
//  Created by 山岸善将 on 2021/07/16.
//

import UIKit
import UPCarouselFlowLayout

class CardListViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    
    var model: TitleListModel!
    
    var viewWidth: CGFloat!
    var viewHeight: CGFloat!
    var cellWidth: CGFloat!
    var cellHeight: CGFloat!
    var cellOffset: CGFloat!
    var navHeight: CGFloat!
    
    override func loadView() {
        super.loadView()
        self.title = model.sectionTitle
        
        switch model.section {
       
        case .familySection:
            if(UserDefaults.standard.array(forKey: "Family1") != nil) {
                model.familyName = UserDefaults.standard.array(forKey: "Family1") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "Family2") != nil) {
                model.familyPhone = UserDefaults.standard.array(forKey: "Family2") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "Family3") != nil) {
                model.familyPhotos = UserDefaults.standard.array(forKey: "Family3") as! [Data]
            }
        case .bfSection:
            if(UserDefaults.standard.array(forKey: "Bf1") != nil) {
                model.bfName = UserDefaults.standard.array(forKey: "Bf1") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "Bf2") != nil) {
                model.bfPhone = UserDefaults.standard.array(forKey: "Bf2") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "Bf3") != nil) {
                model.bfPhotos = UserDefaults.standard.array(forKey: "Bf3") as! [Data]
            }
        case .localSection:
            if(UserDefaults.standard.array(forKey: "Local1") != nil) {
                model.localName = UserDefaults.standard.array(forKey: "Local1") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "Local2") != nil) {
                model.localPhone = UserDefaults.standard.array(forKey: "Local2") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "Local3") != nil) {
                model.localPhotos = UserDefaults.standard.array(forKey: "Local3") as! [Data]
            }
            
        case .highSchoolSection:
            if(UserDefaults.standard.array(forKey: "HighSchool1") != nil) {
                model.highSchoolName = UserDefaults.standard.array(forKey: "HighSchool1") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "HighSchool2") != nil) {
                model.highSchoolPhone = UserDefaults.standard.array(forKey: "HighSchool2") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "HighSchool3") != nil) {
                model.highSchoolPhotos = UserDefaults.standard.array(forKey: "HighSchool3") as! [Data]
            }
        case .collegeSection:
            if(UserDefaults.standard.array(forKey: "College1") != nil) {
                model.collegeName = UserDefaults.standard.array(forKey: "College1") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "College2") != nil) {
                model.collegePhone = UserDefaults.standard.array(forKey: "College2") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "College3") != nil) {
                model.collegePhotos = UserDefaults.standard.array(forKey: "College3") as! [Data]
            }
        case .companySection:
            if(UserDefaults.standard.array(forKey: "Company1") != nil) {
                model.companyName = UserDefaults.standard.array(forKey: "Company1") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "Company2") != nil) {
                model.companyPhone = UserDefaults.standard.array(forKey: "Company2") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "Company3") != nil) {
                model.companyPhotos = UserDefaults.standard.array(forKey: "Company3") as! [Data]
            }
        case .otherSection:
            if(UserDefaults.standard.array(forKey: "Other1") != nil) {
                model.otherName = UserDefaults.standard.array(forKey: "Other1") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "Other2") != nil) {
                model.otherPhone = UserDefaults.standard.array(forKey: "Other2") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "Other3") != nil) {
                model.otherPhotos = UserDefaults.standard.array(forKey: "Other3") as! [Data]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewWidth = self.view.frame.width
        viewHeight = self.view.frame.height
        navHeight = self.navigationController?.navigationBar.frame.size.height
        
        let nib = UINib(nibName: "CollectionViewCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "Cell1")
        
        navigationItem.rightBarButtonItem = editButtonItem
        
        let layout = UPCarouselFlowLayout()
        layout.itemSize = CGSize (width: 300, height: 300)
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
    }
    @IBAction func settingButton(_ sender: Any) {
        let nextView2 = storyboard?.instantiateViewController(identifier: "next2") as! ChildSettingViewController
        nextView2.presentationController?.delegate = self
        nextView2.model = self.model
        present(nextView2, animated: true, completion: nil)
    }
}

extension CardListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let nameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell1", for: indexPath) as! CollectionViewCell
        let label = nameCell.contentView.viewWithTag(1) as! UILabel
        let label2 = nameCell.contentView.viewWithTag(2) as! UILabel
        let image3 = nameCell.contentView.viewWithTag(3) as! UIImageView
        
//        nameCell.backgroundColor = UIColor.white
//        nameCell.layer.cornerRadius = 12
//        nameCell.layer.shadowOpacity = 0.4
//        nameCell.layer.shadowRadius = 12
//        nameCell.layer.shadowColor = UIColor.black.cgColor
//        nameCell.layer.shadowOffset = CGSize(width: 8, height: 8)
//        nameCell.layer.masksToBounds = false
        
        switch model.section {
        case .familySection:
            label.text = model.familyName[indexPath.row]
            label2.text = model.familyPhone[indexPath.row]
            image3.image = UIImage(data: model.familyPhotos[indexPath.row])
        case .bfSection:
            label.text = model.bfName[indexPath.row]
            label2.text = model.bfPhone[indexPath.row]
            image3.image = UIImage(data: model.bfPhotos[indexPath.row])
        case .localSection:
            label.text = model.localName[indexPath.row]
            label2.text = model.localPhone[indexPath.row]
            image3.image = UIImage(data: model.localPhotos[indexPath.row])
        case .highSchoolSection:
            label.text = model.highSchoolName[indexPath.row]
            label2.text = model.highSchoolPhone[indexPath.row]
            image3.image = UIImage(data: model.highSchoolPhotos[indexPath.row])
        case .collegeSection:
            label.text = model.collegeName[indexPath.row]
            label2.text = model.collegePhone[indexPath.row]
            image3.image = UIImage(data: model.collegePhotos[indexPath.row])
        case .companySection:
            label.text = model.companyName[indexPath.row]
            label2.text = model.companyPhone[indexPath.row]
            image3.image = UIImage(data: model.companyPhotos[indexPath.row])
        case .otherSection:
            label.text = model.otherName[indexPath.row]
            label2.text = model.otherPhone[indexPath.row]
            image3.image = UIImage(data: model.otherPhotos[indexPath.row])
        }
        print(model.familyName)
        print(model.familyPhone)
        print(model.familyPhotos)
        print(model.localName)
        print(model.localPhone)
        print(model.localPhotos)
        
        nameCell.delegate = self
        
        return nameCell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch model.section {
        case .familySection:
            return model.familyName.count
        case .bfSection:
            return model.bfName.count
        case .localSection:
            return model.localName.count
        case .highSchoolSection:
            return model.highSchoolName.count
        case .collegeSection:
            return model.collegeName.count
        case .companySection:
            return model.companyName.count
        case .otherSection:
            return model.otherName.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        collectionView.layoutIfNeeded()
        cellWidth = viewWidth - 75
        cellHeight = viewHeight - 300
        cellOffset = viewWidth - cellWidth
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
//    セクションごとの余白
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        cellWidth = viewWidth - 75
//        cellWidth = viewWidth - 30
        cellOffset = viewWidth - cellWidth
        return UIEdgeInsets(top: -navHeight, left: cellOffset / 2, bottom: 0, right: cellOffset / 2)
    }

//    垂直方向におけるセル間のマージン
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return -50
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        addBarButtonItem.isEnabled = !editing
        if let indexPaths = collectionView?.indexPathsForVisibleItems {
            for indexPath in indexPaths {
                if let cell = collectionView?.cellForItem(at: indexPath) as? CollectionViewCell {
                    cell.isEdithing = editing
                }
            }
        }
    }
}
extension CardListViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        collectionView.reloadData()
    }
}
extension CardListViewController: CollectionViewCellDelegate {
    func delete(cell: CollectionViewCell) {
        if let indexPath = collectionView?.indexPath(for: cell) {
            switch model.section {
            case .familySection:
                model.familyPhotos.remove(at: indexPath.item)
                model.familyName.remove(at: indexPath.item)
                model.familyPhone.remove(at: indexPath.item)
            case .bfSection:
                model.bfPhotos.remove(at: indexPath.item)
                model.bfName.remove(at: indexPath.item)
                model.bfPhone.remove(at: indexPath.item)
            case .localSection:
                model.localPhotos.remove(at: indexPath.item)
                model.localName.remove(at: indexPath.item)
                model.localPhone.remove(at: indexPath.item)
            case .highSchoolSection:
                model.highSchoolPhotos.remove(at: indexPath.item)
                model.highSchoolName.remove(at: indexPath.item)
                model.highSchoolPhone.remove(at: indexPath.item)
            case .collegeSection:
                model.collegePhotos.remove(at: indexPath.item)
                model.collegeName.remove(at: indexPath.item)
                model.collegePhone.remove(at: indexPath.item)
            case .companySection:
                model.companyPhotos.remove(at: indexPath.item)
                model.companyName.remove(at: indexPath.item)
                model.companyPhone.remove(at: indexPath.item)
            case .otherSection:
                model.otherPhotos.remove(at: indexPath.item)
                model.otherName.remove(at: indexPath.item)
                model.otherPhone.remove(at: indexPath.item)
            }
            collectionView?.deleteItems(at: [indexPath])
        }
        switch model.section {
        case .familySection:
            UserDefaults.standard.set(model.familyName, forKey: "Family1")
            UserDefaults.standard.set(model.familyPhone, forKey: "Family2")
            UserDefaults.standard.set(model.familyPhotos, forKey: "Family3")
        case .bfSection:
            UserDefaults.standard.set(model.bfName, forKey: "Bf1")
            UserDefaults.standard.set(model.bfPhone, forKey: "Bf2")
            UserDefaults.standard.set(model.bfPhotos, forKey: "Bf3")
        case .localSection:
            UserDefaults.standard.set(model.localName, forKey: "Local1")
            UserDefaults.standard.set(model.localPhone, forKey: "Local2")
            UserDefaults.standard.set(model.localPhotos, forKey: "Local3")
        case .highSchoolSection:
            UserDefaults.standard.set(model.highSchoolName, forKey: "HighSchool1")
            UserDefaults.standard.set(model.highSchoolPhone, forKey: "HighSchool2")
            UserDefaults.standard.set(model.highSchoolPhotos, forKey: "HighSchool3")
        case .collegeSection:
            UserDefaults.standard.set(model.collegeName, forKey: "College1")
            UserDefaults.standard.set(model.collegePhone, forKey: "College2")
            UserDefaults.standard.set(model.collegePhotos, forKey: "College3")
        case .companySection:
            UserDefaults.standard.set(model.companyName, forKey: "Company1")
            UserDefaults.standard.set(model.companyPhone, forKey: "Company2")
            UserDefaults.standard.set(model.companyPhotos, forKey: "Company3")
        case .otherSection:
            UserDefaults.standard.set(model.otherName, forKey: "Other1")
            UserDefaults.standard.set(model.otherPhone, forKey: "Other2")
            UserDefaults.standard.set(model.otherPhotos, forKey: "Other3")
        }
        print(model.familyName)
        print(model.familyPhone)
        print(model.familyPhotos)
        print(model.localName)
        print(model.localPhone)
        print(model.localPhotos)
        collectionView.reloadData()
    }
}
