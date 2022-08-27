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
            if(UserDefaults.standard.array(forKey: "FamilyName") != nil) {
                model.familyName = UserDefaults.standard.array(forKey: "FamilyName") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "FamilyBirthday") != nil) {
                model.familyBirthday = UserDefaults.standard.array(forKey: "FamilyBirthday") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "FamilyPhotos") != nil) {
                model.familyPhotos = UserDefaults.standard.array(forKey: "FamilyPhotos") as! [Data]
            }
        case .bestFriendSection:
            if(UserDefaults.standard.array(forKey: "BestFriendName") != nil) {
                model.bestFriendName = UserDefaults.standard.array(forKey: "BestFriendName") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "BestFriendBirthday") != nil) {
                model.bestFriendBirthday = UserDefaults.standard.array(forKey: "BestFriendBirthday") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "BestFriendPhotos") != nil) {
                model.bestFriendPhotos = UserDefaults.standard.array(forKey: "BestFriendPhotos") as! [Data]
            }
        case .localFriendsSection:
            if(UserDefaults.standard.array(forKey: "LocalFriendsName") != nil) {
                model.localFriendsName = UserDefaults.standard.array(forKey: "LocalFriendsName") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "LocalFriendsBirthday") != nil) {
                model.localFriendsBirthday = UserDefaults.standard.array(forKey: "LocalFriendsBirthday") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "LocalFriendsPhotos") != nil) {
                model.localFriendsPhotos = UserDefaults.standard.array(forKey: "LocalFriendsPhotos") as! [Data]
            }
            
        case .highSchoolFriendsSection:
            if(UserDefaults.standard.array(forKey: "HighSchoolFriendsName") != nil) {
                model.highSchoolFriendsName = UserDefaults.standard.array(forKey: "HighSchoolFriendsName") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "HighSchoolFriendsBirthday") != nil) {
                model.highSchoolFriendsBirthday = UserDefaults.standard.array(forKey: "HighSchoolFriendsBirthday") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "HighSchoolFriendsPhotos") != nil) {
                model.highSchoolFriendsPhotos = UserDefaults.standard.array(forKey: "HighSchoolFriendsPhotos") as! [Data]
            }
        case .collegeFriendsSection:
            if(UserDefaults.standard.array(forKey: "CollegeFriendsName") != nil) {
                model.collegeFriendsName = UserDefaults.standard.array(forKey: "CollegeFriendsName") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "CollegeFriendsBirthday") != nil) {
                model.collegeFriendsBirthday = UserDefaults.standard.array(forKey: "CollegeFriendsBirthday") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "CollegeFriendsPhotos") != nil) {
                model.collegeFriendsPhotos = UserDefaults.standard.array(forKey: "CollegeFriendsPhotos") as! [Data]
            }
        case .companyPeopleSection:
            if(UserDefaults.standard.array(forKey: "CompanyPeopleName") != nil) {
                model.companyPeopleName = UserDefaults.standard.array(forKey: "CompanyPeopleName") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "CompanyPeopleBirthday") != nil) {
                model.companyPeopleBirthday = UserDefaults.standard.array(forKey: "CompanyPeopleBirthday") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "CompanyPeoplePhotos") != nil) {
                model.companyPeoplePhotos = UserDefaults.standard.array(forKey: "CompanyPeoplePhotos") as! [Data]
            }
        case .otherPeopleSection:
            if(UserDefaults.standard.array(forKey: "OtherPeopleName") != nil) {
                model.otherPeopleName = UserDefaults.standard.array(forKey: "OtherPeopleName") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "OtherPeopleBirthday") != nil) {
                model.otherPeopleBirthday = UserDefaults.standard.array(forKey: "OtherPeopleBirthday") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "OtherPeoplePhotos") != nil) {
                model.otherPeoplePhotos = UserDefaults.standard.array(forKey: "OtherPeoplePhotos") as! [Data]
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
            label2.text = model.familyBirthday[indexPath.row]
            image3.image = UIImage(data: model.familyPhotos[indexPath.row])
        case .bestFriendSection:
            label.text = model.bestFriendName[indexPath.row]
            label2.text = model.bestFriendBirthday[indexPath.row]
            image3.image = UIImage(data: model.bestFriendPhotos[indexPath.row])
        case .localFriendsSection:
            label.text = model.localFriendsName[indexPath.row]
            label2.text = model.localFriendsBirthday[indexPath.row]
            image3.image = UIImage(data: model.localFriendsPhotos[indexPath.row])
        case .highSchoolFriendsSection:
            label.text = model.highSchoolFriendsName[indexPath.row]
            label2.text = model.highSchoolFriendsBirthday[indexPath.row]
            image3.image = UIImage(data: model.highSchoolFriendsPhotos[indexPath.row])
        case .collegeFriendsSection:
            label.text = model.collegeFriendsName[indexPath.row]
            label2.text = model.collegeFriendsBirthday[indexPath.row]
            image3.image = UIImage(data: model.collegeFriendsPhotos[indexPath.row])
        case .companyPeopleSection:
            label.text = model.companyPeopleName[indexPath.row]
            label2.text = model.companyPeopleBirthday[indexPath.row]
            image3.image = UIImage(data: model.companyPeoplePhotos[indexPath.row])
        case .otherPeopleSection:
            label.text = model.otherPeopleName[indexPath.row]
            label2.text = model.otherPeopleBirthday[indexPath.row]
            image3.image = UIImage(data: model.otherPeoplePhotos[indexPath.row])
        }
        print(model.familyName)
        print(model.familyBirthday)
        print(model.familyPhotos)
        print(model.localFriendsName)
        print(model.localFriendsBirthday)
        print(model.localFriendsPhotos)
        
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
        case .bestFriendSection:
            return model.bestFriendName.count
        case .localFriendsSection:
            return model.localFriendsName.count
        case .highSchoolFriendsSection:
            return model.highSchoolFriendsName.count
        case .collegeFriendsSection:
            return model.collegeFriendsName.count
        case .companyPeopleSection:
            return model.companyPeopleName.count
        case .otherPeopleSection:
            return model.otherPeopleName.count
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
                model.familyBirthday.remove(at: indexPath.item)
            case .bestFriendSection:
                model.bestFriendPhotos.remove(at: indexPath.item)
                model.bestFriendName.remove(at: indexPath.item)
                model.bestFriendBirthday.remove(at: indexPath.item)
            case .localFriendsSection:
                model.localFriendsPhotos.remove(at: indexPath.item)
                model.localFriendsName.remove(at: indexPath.item)
                model.localFriendsBirthday.remove(at: indexPath.item)
            case .highSchoolFriendsSection:
                model.highSchoolFriendsPhotos.remove(at: indexPath.item)
                model.highSchoolFriendsName.remove(at: indexPath.item)
                model.highSchoolFriendsBirthday.remove(at: indexPath.item)
            case .collegeFriendsSection:
                model.collegeFriendsPhotos.remove(at: indexPath.item)
                model.collegeFriendsName.remove(at: indexPath.item)
                model.collegeFriendsBirthday.remove(at: indexPath.item)
            case .companyPeopleSection:
                model.companyPeoplePhotos.remove(at: indexPath.item)
                model.companyPeopleName.remove(at: indexPath.item)
                model.companyPeopleBirthday.remove(at: indexPath.item)
            case .otherPeopleSection:
                model.otherPeoplePhotos.remove(at: indexPath.item)
                model.otherPeopleName.remove(at: indexPath.item)
                model.otherPeopleBirthday.remove(at: indexPath.item)
            }
            collectionView?.deleteItems(at: [indexPath])
        }
        switch model.section {
        case .familySection:
            UserDefaults.standard.set(model.familyName, forKey: "FamilyName")
            UserDefaults.standard.set(model.familyBirthday, forKey: "FamilyBirthday")
            UserDefaults.standard.set(model.familyPhotos, forKey: "FamilyPhotos")
        case .bestFriendSection:
            UserDefaults.standard.set(model.bestFriendName, forKey: "BestFriendName")
            UserDefaults.standard.set(model.bestFriendBirthday, forKey: "BestFriendBirthday")
            UserDefaults.standard.set(model.bestFriendPhotos, forKey: "BestFriendPhotos")
        case .localFriendsSection:
            UserDefaults.standard.set(model.localFriendsName, forKey: "LocalFriendsName")
            UserDefaults.standard.set(model.localFriendsBirthday, forKey: "LocalFriendsBirthday")
            UserDefaults.standard.set(model.localFriendsPhotos, forKey: "LocalFriendsPhotos")
        case .highSchoolFriendsSection:
            UserDefaults.standard.set(model.highSchoolFriendsName, forKey: "HighSchoolFriendsName")
            UserDefaults.standard.set(model.highSchoolFriendsBirthday, forKey: "HighSchoolFriendsBirthday")
            UserDefaults.standard.set(model.highSchoolFriendsPhotos, forKey: "HighSchoolFriendsPhotos")
        case .collegeFriendsSection:
            UserDefaults.standard.set(model.collegeFriendsName, forKey: "CollegeFriendsName")
            UserDefaults.standard.set(model.collegeFriendsBirthday, forKey: "CollegeFriendsBirthday")
            UserDefaults.standard.set(model.collegeFriendsPhotos, forKey: "CollegeFriendsPhotos")
        case .companyPeopleSection:
            UserDefaults.standard.set(model.companyPeopleName, forKey: "CompanyPeopleName")
            UserDefaults.standard.set(model.companyPeopleBirthday, forKey: "CompanyPeopleBirthday")
            UserDefaults.standard.set(model.companyPeoplePhotos, forKey: "CompanyPeoplePhotos")
        case .otherPeopleSection:
            UserDefaults.standard.set(model.otherPeopleName, forKey: "OtherPeopleName")
            UserDefaults.standard.set(model.otherPeopleBirthday, forKey: "OtherPeopleBirthday")
            UserDefaults.standard.set(model.otherPeoplePhotos, forKey: "OtherPeoplePhotos")
        }
        print(model.familyName)
        print(model.familyBirthday)
        print(model.familyPhotos)
        print(model.localFriendsName)
        print(model.localFriendsBirthday)
        print(model.localFriendsPhotos)
        collectionView.reloadData()
    }
}
