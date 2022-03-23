//
//  BffViewController.swift
//  MyCardsList
//
//  Created by 山岸善将 on 2021/07/16.
//

import UIKit

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
                model.FamilyName = UserDefaults.standard.array(forKey: "Family1") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "Family2") != nil) {
                model.FamilyPhone = UserDefaults.standard.array(forKey: "Family2") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "Family3") != nil) {
                model.FamilyPhotos = UserDefaults.standard.array(forKey: "Family3") as! [Data]
            }
        case .bfSection:
            if(UserDefaults.standard.array(forKey: "Bf1") != nil) {
                model.BfName = UserDefaults.standard.array(forKey: "Bf1") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "Bf2") != nil) {
                model.BfPhone = UserDefaults.standard.array(forKey: "Bf2") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "Bf3") != nil) {
                model.BfPhotos = UserDefaults.standard.array(forKey: "Bf3") as! [Data]
            }
        case .localSection:
            if(UserDefaults.standard.array(forKey: "Local1") != nil) {
                model.LocalName = UserDefaults.standard.array(forKey: "Local1") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "Local2") != nil) {
                model.LocalPhone = UserDefaults.standard.array(forKey: "Local2") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "Local3") != nil) {
                model.LocalPhotos = UserDefaults.standard.array(forKey: "Local3") as! [Data]
            }
            
        case .highSchoolSection:
            if(UserDefaults.standard.array(forKey: "HighSchool1") != nil) {
                model.HighSchoolName = UserDefaults.standard.array(forKey: "HighSchool1") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "HighSchool2") != nil) {
                model.HighSchoolPhone = UserDefaults.standard.array(forKey: "HighSchool2") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "HighSchool3") != nil) {
                model.HighSchoolPhotos = UserDefaults.standard.array(forKey: "HighSchool3") as! [Data]
            }
        case .collegeSection:
            if(UserDefaults.standard.array(forKey: "College1") != nil) {
                model.CollegeName = UserDefaults.standard.array(forKey: "College1") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "College2") != nil) {
                model.CollegePhone = UserDefaults.standard.array(forKey: "College2") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "College3") != nil) {
                model.CollegePhotos = UserDefaults.standard.array(forKey: "College3") as! [Data]
            }
        case .companySection:
            if(UserDefaults.standard.array(forKey: "Company1") != nil) {
                model.CompanyName = UserDefaults.standard.array(forKey: "Company1") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "Company2") != nil) {
                model.CompanyPhone = UserDefaults.standard.array(forKey: "Company2") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "Company3") != nil) {
                model.CompanyPhotos = UserDefaults.standard.array(forKey: "Company3") as! [Data]
            }
        case .otherSection:
            if(UserDefaults.standard.array(forKey: "Other1") != nil) {
                model.OtherName = UserDefaults.standard.array(forKey: "Other1") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "Other2") != nil) {
                model.OtherPhone = UserDefaults.standard.array(forKey: "Other2") as! [String]
            }
            if(UserDefaults.standard.array(forKey: "Other3") != nil) {
                model.OtherPhotos = UserDefaults.standard.array(forKey: "Other3") as! [Data]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewWidth = self.view.frame.width
        viewHeight = self.view.frame.height
        navHeight = self.navigationController?.navigationBar.frame.size.height
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: "CollectionViewCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "Cell1")
        
        navigationItem.rightBarButtonItem = editButtonItem
//        editButton = editButtonItem
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
        
        nameCell.backgroundColor = UIColor.white
        nameCell.layer.cornerRadius = 12
        nameCell.layer.shadowOpacity = 0.4
        nameCell.layer.shadowRadius = 12
        nameCell.layer.shadowColor = UIColor.black.cgColor
        nameCell.layer.shadowOffset = CGSize(width: 8, height: 8)
        nameCell.layer.masksToBounds = false
        
        switch model.section {
        case .familySection:
            label.text = model.FamilyName[indexPath.row]
            label2.text = model.FamilyPhone[indexPath.row]
            image3.image = UIImage(data: model.FamilyPhotos[indexPath.row])
//            guard let uiImage = UIImage(data: model.FamilyPhotos[indexPath.row]), let cgImage = uiImage.cgImage else { return UICollectionViewCell() }
//            image3.image = UIImage(cgImage: cgImage, scale: 0, orientation: uiImage.imageOrientation)
        case .bfSection:
            label.text = model.BfName[indexPath.row]
            label2.text = model.BfPhone[indexPath.row]
            image3.image = UIImage(data: model.BfPhotos[indexPath.row])
        case .localSection:
            label.text = model.LocalName[indexPath.row]
            label2.text = model.LocalPhone[indexPath.row]
            image3.image = UIImage(data: model.LocalPhotos[indexPath.row])
        case .highSchoolSection:
            label.text = model.HighSchoolName[indexPath.row]
            label2.text = model.HighSchoolPhone[indexPath.row]
            image3.image = UIImage(data: model.HighSchoolPhotos[indexPath.row])
        case .collegeSection:
            label.text = model.CollegeName[indexPath.row]
            label2.text = model.CollegePhone[indexPath.row]
            image3.image = UIImage(data: model.CollegePhotos[indexPath.row])
        case .companySection:
            label.text = model.CompanyName[indexPath.row]
            label2.text = model.CompanyPhone[indexPath.row]
            image3.image = UIImage(data: model.CompanyPhotos[indexPath.row])
        case .otherSection:
            label.text = model.OtherName[indexPath.row]
            label2.text = model.OtherPhone[indexPath.row]
            image3.image = UIImage(data: model.OtherPhotos[indexPath.row])
        }
        print(model.FamilyName)
        print(model.FamilyPhone)
        print(model.FamilyPhotos)
        print(model.LocalName)
        print(model.LocalPhone)
        print(model.LocalPhotos)
        
        nameCell.delegate = self
        
        return nameCell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch model.section {
        case .familySection:
            return model.FamilyName.count
        case .bfSection:
            return model.BfName.count
        case .localSection:
            return model.LocalName.count
        case .highSchoolSection:
            return model.HighSchoolName.count
        case .collegeSection:
            return model.CollegeName.count
        case .companySection:
            return model.CompanyName.count
        case .otherSection:
            return model.OtherName.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellWidth = viewWidth - 75
        cellHeight = viewHeight - 300
        cellOffset = viewWidth - cellWidth
        return CGSize(width: cellWidth, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        cellWidth = viewWidth - 75
        cellOffset = viewWidth - cellWidth
        return UIEdgeInsets(top: -navHeight, left: cellOffset / 2, bottom: 0, right: cellOffset / 2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
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
                model.FamilyPhotos.remove(at: indexPath.item)
                model.FamilyName.remove(at: indexPath.item)
                model.FamilyPhone.remove(at: indexPath.item)
            case .bfSection:
                model.BfPhotos.remove(at: indexPath.item)
                model.BfName.remove(at: indexPath.item)
                model.BfPhone.remove(at: indexPath.item)
            case .localSection:
                model.LocalPhotos.remove(at: indexPath.item)
                model.LocalName.remove(at: indexPath.item)
                model.LocalPhone.remove(at: indexPath.item)
            case .highSchoolSection:
                model.HighSchoolPhotos.remove(at: indexPath.item)
                model.HighSchoolName.remove(at: indexPath.item)
                model.HighSchoolPhone.remove(at: indexPath.item)
            case .collegeSection:
                model.CollegePhotos.remove(at: indexPath.item)
                model.CollegeName.remove(at: indexPath.item)
                model.CollegePhone.remove(at: indexPath.item)
            case .companySection:
                model.CompanyPhotos.remove(at: indexPath.item)
                model.CompanyName.remove(at: indexPath.item)
                model.CompanyPhone.remove(at: indexPath.item)
            case .otherSection:
                model.OtherPhotos.remove(at: indexPath.item)
                model.OtherName.remove(at: indexPath.item)
                model.OtherPhone.remove(at: indexPath.item)
            }
            collectionView?.deleteItems(at: [indexPath])
        }
        switch model.section {
        case .familySection:
            UserDefaults.standard.set(model.FamilyName, forKey: "Family1")
            UserDefaults.standard.set(model.FamilyPhone, forKey: "Family2")
            UserDefaults.standard.set(model.FamilyPhotos, forKey: "Family3")
        case .bfSection:
            UserDefaults.standard.set(model.BfName, forKey: "Bf1")
            UserDefaults.standard.set(model.BfPhone, forKey: "Bf2")
            UserDefaults.standard.set(model.BfPhotos, forKey: "Bf3")
        case .localSection:
            UserDefaults.standard.set(model.LocalName, forKey: "Local1")
            UserDefaults.standard.set(model.LocalPhone, forKey: "Local2")
            UserDefaults.standard.set(model.LocalPhotos, forKey: "Local3")
        case .highSchoolSection:
            UserDefaults.standard.set(model.HighSchoolName, forKey: "HighSchool1")
            UserDefaults.standard.set(model.HighSchoolPhone, forKey: "HighSchool2")
            UserDefaults.standard.set(model.HighSchoolPhotos, forKey: "HighSchool3")
        case .collegeSection:
            UserDefaults.standard.set(model.CollegeName, forKey: "College1")
            UserDefaults.standard.set(model.CollegePhone, forKey: "College2")
            UserDefaults.standard.set(model.CollegePhotos, forKey: "College3")
        case .companySection:
            UserDefaults.standard.set(model.CompanyName, forKey: "Company1")
            UserDefaults.standard.set(model.CompanyPhone, forKey: "Company2")
            UserDefaults.standard.set(model.CompanyPhotos, forKey: "Company3")
        case .otherSection:
            UserDefaults.standard.set(model.OtherName, forKey: "Other1")
            UserDefaults.standard.set(model.OtherPhone, forKey: "Other2")
            UserDefaults.standard.set(model.OtherPhotos, forKey: "Other3")
        }
        print(model.FamilyName)
        print(model.FamilyPhone)
        print(model.FamilyPhotos)
        print(model.LocalName)
        print(model.LocalPhone)
        print(model.LocalPhotos)
        collectionView.reloadData()
    }
}
