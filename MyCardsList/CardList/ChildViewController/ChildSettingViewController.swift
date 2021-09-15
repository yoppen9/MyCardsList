//
//  BfSettingViewController.swift
//  MyCardsList
//
//  Created by 山岸善将 on 2021/07/16.
//

import UIKit
import CropViewController

class ChildSettingViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var NewBfName: UITextField!
    @IBOutlet weak var NewBfImage: UIImageView!
    @IBOutlet weak var NewBfTel: UITextField!

    var selectedImageData: Data?
    var model: TitleListModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.NewBfName.delegate = self
        self.NewBfTel.delegate = self
        self.NewBfTel.keyboardType = UIKeyboardType.numberPad
        
        NewBfImage.layer.cornerRadius = NewBfImage.frame.size.width * 0.1
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow2), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.NewBfTel.isFirstResponder) {
            self.NewBfTel.resignFirstResponder()
        }
    }
    @IBAction func NewBfButton(_ sender: Any) {
        guard let text = NewBfName.text, !text.isEmpty,
              let text1 = NewBfTel.text, !text1.isEmpty,
              let text3 = selectedImageData, !text3.isEmpty else { return }
        switch self.model.section {
        case .familySection:
            model.FamilyName.append(NewBfName.text!)
            model.FamilyPhone.append(NewBfTel.text!)
            model.FamilyPhotos.append(selectedImageData!)
            UserDefaults.standard.set(model.FamilyName, forKey: "Family1")
            UserDefaults.standard.set(model.FamilyPhone, forKey: "Family2")
            UserDefaults.standard.set(model.FamilyPhotos, forKey: "Family3")
        case .bfSection:
            model.BfName.append(NewBfName.text!)
            model.BfPhone.append(NewBfTel.text!)
            model.BfPhotos.append(selectedImageData!)
            UserDefaults.standard.set(model.BfName, forKey: "Bf1")
            UserDefaults.standard.set(model.BfPhone, forKey: "Bf2")
            UserDefaults.standard.set(model.BfPhotos, forKey: "Bf3")
        case .localSection:
            model.LocalName.append(NewBfName.text!)
            model.LocalPhone.append(NewBfTel.text!)
            model.LocalPhotos.append(selectedImageData!)
            UserDefaults.standard.set(model.LocalName, forKey: "Local1")
            UserDefaults.standard.set(model.LocalPhone, forKey: "Local2")
            UserDefaults.standard.set(model.LocalPhotos, forKey: "Local3")
        case .highSchoolSection:
            model.HighSchoolName.append(NewBfName.text!)
            model.HighSchoolPhone.append(NewBfTel.text!)
            model.HighSchoolPhotos.append(selectedImageData!)
            UserDefaults.standard.set(model.HighSchoolName, forKey: "HighSchool1")
            UserDefaults.standard.set(model.HighSchoolPhone, forKey: "HighSchool2")
            UserDefaults.standard.set(model.HighSchoolPhotos, forKey: "HighSchool3")
        case .collegeSection:
            model.CollegeName.append(NewBfName.text!)
            model.CollegePhone.append(NewBfTel.text!)
            model.CollegePhotos.append(selectedImageData!)
            UserDefaults.standard.set(model.CollegeName, forKey: "College1")
            UserDefaults.standard.set(model.CollegePhone, forKey: "College2")
            UserDefaults.standard.set(model.CollegePhotos, forKey: "College3")
        case .companySection:
            model.CompanyName.append(NewBfName.text!)
            model.CompanyPhone.append(NewBfTel.text!)
            model.CompanyPhotos.append(selectedImageData!)
            UserDefaults.standard.set(model.CompanyName, forKey: "Company1")
            UserDefaults.standard.set(model.CompanyPhone, forKey: "Company2")
            UserDefaults.standard.set(model.CompanyPhotos, forKey: "Company3")
        case .otherSection:
            model.OtherName.append(NewBfName.text!)
            model.OtherPhone.append(NewBfTel.text!)
            model.OtherPhotos.append(selectedImageData!)
            UserDefaults.standard.set(model.OtherName, forKey: "Other1")
            UserDefaults.standard.set(model.OtherPhone, forKey: "Other2")
            UserDefaults.standard.set(model.OtherPhotos, forKey: "Other3")
        }
        print(model.FamilyName)
        print(model.FamilyPhone)
        print(model.FamilyPhotos)
        self.dismiss(animated: true, completion: {
            self.NewBfName.text! = ""
            self.NewBfTel.text! = ""
        })
    }
    @objc func keyboardWillShow(notificaation: NSNotification) {
        if !NewBfTel.isFirstResponder {
            return
        }
        if self.view.frame.origin.y == 0 {
            if ((notificaation.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
                self.view.frame.origin.y = -120
            }
        }
    }
    @objc func keyboardWillShow2(notificaation: NSNotification) {
        if !NewBfName.isFirstResponder {
            return
        }
        if self.view.frame.origin.y == 0 {
            if ((notificaation.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
                self.view.frame.origin.y = -90
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

extension ChildSettingViewController: UIImagePickerControllerDelegate, CropViewControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
//        NewBfImage.image = selectedImage
//        selectedImageData = selectedImage.pngData()
//        dismiss(animated: true, completion: nil)
        
        guard let pickerImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        let cropController = CropViewController(image: pickerImage)
//        NewBfImage.image = pickerImage
        cropController.customAspectRatio = NewBfImage.frame.size
        cropController.aspectRatioPickerButtonHidden = true
        cropController.resetAspectRatioEnabled = false
        cropController.rotateButtonsHidden = true
        cropController.cropView.cropBoxResizeEnabled = false
//        cropController.delegate = self
        selectedImageData = pickerImage.pngData()
        dismiss(animated: true, completion: nil)
        
        self.present(cropController, animated: true, completion: nil)
    }
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        self.NewBfImage.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
        self.dismiss(animated: true, completion: nil)
    }
//    func cropViewController(_ cropViewController: CropViewController, didCropToCircularImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
//        updateImageViewWithImage(image, fromCropViewController: cropViewController)
//    }
//    func updateImageViewWithImage(_ image: UIImage, fromCropViewController cropViewController: CropViewController) {
//        self.NewBfImage.image = image
//        cropViewController.dismiss(animated: true, completion: nil)
//    }
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

