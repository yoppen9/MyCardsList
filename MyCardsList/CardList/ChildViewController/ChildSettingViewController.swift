//
//  BfSettingViewController.swift
//  MyCardsList
//
//  Created by 山岸善将 on 2021/07/16.
//

import UIKit
import CropViewController

class ChildSettingViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var newName: UITextField!
    @IBOutlet weak var newBirthday: UITextField!
    @IBOutlet weak var newImage: UIImageView!
    
    var selectedImageData: Data?
    var model: TitleListModel!
    var image:UIImage?
    let datePicler = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newName.delegate = self
        self.newBirthday.delegate = self
        self.newBirthday.placeholder = "誕生日"
        createDatePicker()
        
        newImage.layer.cornerRadius = newImage.frame.size.width / 2
        newImage.contentMode = .scaleAspectFill
        newImage.image = UIImage(named: "E1")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow2), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        newBirthday.inputAccessoryView = toolbar
        newBirthday.inputView = datePicler
        datePicler.preferredDatePickerStyle = .wheels
        datePicler.datePickerMode = .date
    }
    @objc func donePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.dateFormat = "yyyy年MM月dd日"
        newBirthday.text = formatter.string(from: datePicler.date)
        self.view.endEditing(true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.newBirthday.isFirstResponder) {
            self.newBirthday.resignFirstResponder()
        }
    }
    @IBAction func NewBestFriendButton(_ sender: Any) {
        guard let text = newName.text, !text.isEmpty,
              let text1 = newBirthday.text, !text1.isEmpty,
              let text3 = selectedImageData, !text3.isEmpty else { return }
        switch self.model.section {
        case .familySection:
            model.familyName.append(newName.text!)
            model.familyBirthday.append(newBirthday.text!)
            model.familyPhotos.append(selectedImageData!)
            UserDefaults.standard.set(model.familyName, forKey: "FamilyName")
            UserDefaults.standard.set(model.familyBirthday, forKey: "FamilyBirthday")
            UserDefaults.standard.set(model.familyPhotos, forKey: "FamilyPhotos")
        case .bestFriendSection:
            model.bestFriendName.append(newName.text!)
            model.bestFriendBirthday.append(newBirthday.text!)
            model.bestFriendPhotos.append(selectedImageData!)
            UserDefaults.standard.set(model.bestFriendName, forKey: "BestFriendName")
            UserDefaults.standard.set(model.bestFriendBirthday, forKey: "BestFriendBirthday")
            UserDefaults.standard.set(model.bestFriendPhotos, forKey: "BestFriendPhotos")
        case .localFriendsSection:
            model.localFriendsName.append(newName.text!)
            model.localFriendsBirthday.append(newBirthday.text!)
            model.localFriendsPhotos.append(selectedImageData!)
            UserDefaults.standard.set(model.localFriendsName, forKey: "LocalFriendsName")
            UserDefaults.standard.set(model.localFriendsBirthday, forKey: "LocalFriendsBirthday")
            UserDefaults.standard.set(model.localFriendsPhotos, forKey: "LocalFriendsPhotos")
        case .highSchoolFriendsSection:
            model.highSchoolFriendsName.append(newName.text!)
            model.highSchoolFriendsBirthday.append(newBirthday.text!)
            model.highSchoolFriendsPhotos.append(selectedImageData!)
            UserDefaults.standard.set(model.highSchoolFriendsName, forKey: "HighSchoolFriendsName")
            UserDefaults.standard.set(model.highSchoolFriendsBirthday, forKey: "HighSchoolFriendsBirthday")
            UserDefaults.standard.set(model.highSchoolFriendsPhotos, forKey: "HighSchoolFriendsPhotos")
        case .collegeFriendsSection:
            model.collegeFriendsName.append(newName.text!)
            model.collegeFriendsBirthday.append(newBirthday.text!)
            model.collegeFriendsPhotos.append(selectedImageData!)
            UserDefaults.standard.set(model.collegeFriendsName, forKey: "CollegeFriendsName")
            UserDefaults.standard.set(model.collegeFriendsBirthday, forKey: "CollegeFriendsBirthday")
            UserDefaults.standard.set(model.collegeFriendsPhotos, forKey: "CollegeFriendsPhotos")
        case .companyPeopleSection:
            model.companyPeopleName.append(newName.text!)
            model.companyPeopleBirthday.append(newBirthday.text!)
            model.companyPeoplePhotos.append(selectedImageData!)
            UserDefaults.standard.set(model.companyPeopleName, forKey: "CompanyPeopleName")
            UserDefaults.standard.set(model.companyPeopleBirthday, forKey: "CompanyPeopleBirthday")
            UserDefaults.standard.set(model.companyPeoplePhotos, forKey: "CompanyPeoplePhotos")
        case .otherPeopleSection:
            model.otherPeopleName.append(newName.text!)
            model.otherPeopleBirthday.append(newBirthday.text!)
            model.otherPeoplePhotos.append(selectedImageData!)
            UserDefaults.standard.set(model.otherPeopleName, forKey: "OtherPeopleName")
            UserDefaults.standard.set(model.otherPeopleBirthday, forKey: "OtherPeopleBirthday")
            UserDefaults.standard.set(model.otherPeoplePhotos, forKey: "OtherPeoplePhotos")
        }
        self.dismiss(animated: true, completion: {
            self.newName.text! = ""
            self.newBirthday.text! = ""
        })
    }
    @objc func keyboardWillShow(notificaation: NSNotification) {
        if !newBirthday.isFirstResponder {
            return
        }
        if self.view.frame.origin.y == 0 {
            if ((notificaation.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
                self.view.frame.origin.y = -80
            }
        }
    }
    @objc func keyboardWillShow2(notificaation: NSNotification) {
        if !newName.isFirstResponder {
            return
        }
        if self.view.frame.origin.y == 0 {
            if ((notificaation.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
                self.view.frame.origin.y = -60
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        let cropViewController = CropViewController(croppingStyle: .circular, image: image)
        cropViewController.delegate = self
        cropViewController.children.first?.modalTransitionStyle = .coverVertical
        present(cropViewController, animated: true, completion: nil)
    }
    
    @IBAction func tapAddIImage(_ sender: Any) {
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
    
extension ChildSettingViewController: CropViewControllerDelegate {
    func cropViewController(_ cropViewController: CropViewController, didCropToCircularImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        updateImageViewWithImage(image, fromCropViewController: cropViewController)
    }
    
    func updateImageViewWithImage(_ image: UIImage, fromCropViewController cropViewController: CropViewController) {
        
        let resizedImage = image.resizeImage(withPercentage: 0.7)
        newImage.image = resizedImage
        selectedImageData = resizedImage?.jpegData(compressionQuality: 0.2)
        cropViewController.dismiss(animated: true, completion: nil)
        
    }
}

extension ChildSettingViewController {
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        guard let presentationController = presentationController else { return }
        presentationController.delegate?.presentationControllerDidDismiss?(presentationController)
    }
}
extension ChildSettingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ NewBestFriendName: UITextField) -> Bool {
        NewBestFriendName.resignFirstResponder()
        return true
    }
    func textFieldShouldReturn2(_ NewBestFriendBirthday: UITextField) -> Bool {
        NewBestFriendBirthday.resignFirstResponder()
        return true
    }
}
extension UIImage {
    func resizeImage(withPercentage percentage: CGFloat) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}
