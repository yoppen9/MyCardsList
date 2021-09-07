//
//  BfSettingViewController.swift
//  MyCardsList
//
//  Created by 山岸善将 on 2021/07/16.
//

import UIKit

class ChildSettingViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var NewBfName: UITextField!
    @IBOutlet weak var NewBfImage: UIImageView!
    @IBOutlet weak var NewBfTel: UITextField!

    var selectedImageData: Data?
    var model: TitleListModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.NewBfName.delegate = self
//        self.NewBfDescription.delegate = self
        self.NewBfTel.delegate = self
        self.NewBfTel.keyboardType = UIKeyboardType.numberPad
//        NewBfDescription.layer.borderColor = UIColor.lightGray.cgColor
//        NewBfDescription.layer.borderWidth = 1.0
//        NewBfDescription.layer.cornerRadius = 8
//        NewBfDescription.layer.masksToBounds = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow2), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.NewBfTel.isFirstResponder) {
            self.NewBfTel.resignFirstResponder()
        }
//        if (self.NewBfDescription.isFirstResponder) {
//            self.NewBfDescription.resignFirstResponder()
//        }
    }
    @IBAction func NewBfButton(_ sender: Any) {
        guard let text = NewBfName.text, !text.isEmpty,
              let text1 = NewBfTel.text, !text1.isEmpty,
//              let text2 = NewBfDescription.text, !text2.isEmpty,
              let text3 = selectedImageData, !text3.isEmpty else { return }
        switch self.model.section {
        case .familySection:
            FamilyName.append(NewBfName.text!)
            FamilyPhone.append(NewBfTel.text!)
            FamilyPhotos.append(selectedImageData!)
//            FamilyDescription.append(NewBfDescription.text!)
            UserDefaults.standard.set(FamilyName, forKey: "Family1")
            UserDefaults.standard.set(FamilyPhone, forKey: "Family2")
            UserDefaults.standard.set(FamilyPhotos, forKey: "Family3")
            UserDefaults.standard.set(FamilyDescription, forKey: "Family4")
        case .bfSection:
            BfName.append(NewBfName.text!)
            BfPhone.append(NewBfTel.text!)
            BfPhotos.append(selectedImageData!)
//            BfDescription.append(NewBfDescription.text!)
            UserDefaults.standard.set(BfName, forKey: "Bf1")
            UserDefaults.standard.set(BfPhone, forKey: "Bf2")
            UserDefaults.standard.set(BfPhotos, forKey: "Bf3")
            UserDefaults.standard.set(BfDescription, forKey: "Bf4")
        case .localSection:
            LocalName.append(NewBfName.text!)
            LocalPhone.append(NewBfTel.text!)
            LocalPhotos.append(selectedImageData!)
//            LocalDescription.append(NewBfDescription.text!)
            UserDefaults.standard.set(LocalName, forKey: "Local1")
            UserDefaults.standard.set(LocalPhone, forKey: "Local2")
            UserDefaults.standard.set(LocalPhotos, forKey: "Local3")
            UserDefaults.standard.set(LocalDescription, forKey: "Local4")
        case .highSchoolSection:
            HighSchoolName.append(NewBfName.text!)
            HighSchoolPhone.append(NewBfTel.text!)
            HighSchoolPhotos.append(selectedImageData!)
//            HighSchoolDescription.append(NewBfDescription.text!)
            UserDefaults.standard.set(HighSchoolName, forKey: "HighSchool1")
            UserDefaults.standard.set(HighSchoolPhone, forKey: "HighSchool2")
            UserDefaults.standard.set(HighSchoolPhotos, forKey: "HighSchool3")
            UserDefaults.standard.set(HighSchoolDescription, forKey: "HighSchool4")
        case .collegeSection:
            CollegeName.append(NewBfName.text!)
            CollegePhone.append(NewBfTel.text!)
            CollegePhotos.append(selectedImageData!)
//            CollegeDescription.append(NewBfDescription.text!)
            UserDefaults.standard.set(CollegeName, forKey: "College1")
            UserDefaults.standard.set(CollegePhone, forKey: "College2")
            UserDefaults.standard.set(CollegePhotos, forKey: "College3")
            UserDefaults.standard.set(CollegeDescription, forKey: "College4")
        case .companySection:
            CompanyName.append(NewBfName.text!)
            CompanyPhone.append(NewBfTel.text!)
            CompanyPhotos.append(selectedImageData!)
//            CompanyDescription.append(NewBfDescription.text!)
            UserDefaults.standard.set(CompanyName, forKey: "Company1")
            UserDefaults.standard.set(CompanyPhone, forKey: "Company2")
            UserDefaults.standard.set(CompanyPhotos, forKey: "Company3")
            UserDefaults.standard.set(CompanyDescription, forKey: "Company4")
        case .otherSection:
            OtherName.append(NewBfName.text!)
            OtherPhone.append(NewBfTel.text!)
            OtherPhotos.append(selectedImageData!)
//            OtherDescription.append(NewBfDescription.text!)
            UserDefaults.standard.set(OtherName, forKey: "Other1")
            UserDefaults.standard.set(OtherPhone, forKey: "Other2")
            UserDefaults.standard.set(OtherPhotos, forKey: "Other3")
            UserDefaults.standard.set(OtherDescription, forKey: "Other4")
        }
        print(BfName)
        print(BfPhone)
        print(BfPhotos)
        print(BfDescription)
        self.dismiss(animated: true, completion: {
            self.NewBfName.text! = ""
            self.NewBfTel.text! = ""
//            self.NewBfDescription.text! = ""
        })
    }
    @objc func keyboardWillShow(notificaation: NSNotification) {
        if !NewBfTel.isFirstResponder {
            return
        }
        if self.view.frame.origin.y == 0 {
            if ((notificaation.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
                self.view.frame.origin.y = -110
            }
        }
    }
//    @objc func keyboardWillShow2(notificaation: NSNotification) {
//        if !NewBfDescription.isFirstResponder {
//            return
//        }
//        if self.view.frame.origin.y == 0 {
//            if ((notificaation.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
//                self.view.frame.origin.y = -90
//            }
//        }
//    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

extension ChildSettingViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        NewBfImage.image = selectedImage
        selectedImageData = selectedImage.pngData()
        dismiss(animated: true, completion: nil)
    }
    @IBAction func BfImageButton(_ sender: Any) {
        let alertController = UIAlertController(title: "確認", message: "選択してください", preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "カメラ", style: .default, handler: { (action) in
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .camera
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "フォトライブラリー", style: .default, handler: { (action) in
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .photoLibrary
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension ChildSettingViewController {
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        guard let presentationController = presentationController else {
            return
        }
        presentationController.delegate?.presentationControllerDidDismiss?(presentationController)
    }
}

extension ChildSettingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ NewBfName: UITextField) -> Bool {
        NewBfName.resignFirstResponder()
        return true
    }
    func textFieldShouldReturn2(_ NewBfTel: UITextField) -> Bool {
        NewBfTel.resignFirstResponder()
        return true
    }
}

extension ChildSettingViewController: UITextViewDelegate {
    func textFieldShouldReturn3(_ NewBfDescription: UITextView) -> Bool {
        NewBfDescription.resignFirstResponder()
        return true
    }
}
