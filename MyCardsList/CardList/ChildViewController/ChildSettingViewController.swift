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
    @IBOutlet weak var newImage: UIImageView!
    @IBOutlet weak var newTel: UITextField!
    
    var selectedImageData: Data?
    var model: TitleListModel!
    var image:UIImage?
    let datePicler = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newName.delegate = self
        self.newTel.delegate = self
        self.newTel.placeholder = "誕生日"
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
        newTel.inputAccessoryView = toolbar
        newTel.inputView = datePicler
        datePicler.preferredDatePickerStyle = .wheels
        datePicler.datePickerMode = .date
    }
    @objc func donePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        newTel.text = formatter.string(from: datePicler.date)
        self.view.endEditing(true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.newTel.isFirstResponder) {
            self.newTel.resignFirstResponder()
        }
    }
    @IBAction func NewBfButton(_ sender: Any) {
        guard let text = newName.text, !text.isEmpty,
              let text1 = newTel.text, !text1.isEmpty,
              let text3 = selectedImageData, !text3.isEmpty else { return }
        switch self.model.section {
        case .familySection:
            model.familyName.append(newName.text!)
            model.familyPhone.append(newTel.text!)
            model.familyPhotos.append(selectedImageData!)
            UserDefaults.standard.set(model.familyName, forKey: "Family1")
            UserDefaults.standard.set(model.familyPhone, forKey: "Family2")
            UserDefaults.standard.set(model.familyPhotos, forKey: "Family3")
        case .bfSection:
            model.bfName.append(newName.text!)
            model.bfPhone.append(newTel.text!)
            model.bfPhotos.append(selectedImageData!)
            UserDefaults.standard.set(model.bfName, forKey: "Bf1")
            UserDefaults.standard.set(model.bfPhone, forKey: "Bf2")
            UserDefaults.standard.set(model.bfPhotos, forKey: "Bf3")
        case .localSection:
            model.localName.append(newName.text!)
            model.localPhone.append(newTel.text!)
            model.localPhotos.append(selectedImageData!)
            UserDefaults.standard.set(model.localName, forKey: "Local1")
            UserDefaults.standard.set(model.localPhone, forKey: "Local2")
            UserDefaults.standard.set(model.localPhotos, forKey: "Local3")
        case .highSchoolSection:
            model.highSchoolName.append(newName.text!)
            model.highSchoolPhone.append(newTel.text!)
            model.highSchoolPhotos.append(selectedImageData!)
            UserDefaults.standard.set(model.highSchoolName, forKey: "HighSchool1")
            UserDefaults.standard.set(model.highSchoolPhone, forKey: "HighSchool2")
            UserDefaults.standard.set(model.highSchoolPhotos, forKey: "HighSchool3")
        case .collegeSection:
            model.collegeName.append(newName.text!)
            model.collegePhone.append(newTel.text!)
            model.collegePhotos.append(selectedImageData!)
            UserDefaults.standard.set(model.collegeName, forKey: "College1")
            UserDefaults.standard.set(model.collegePhone, forKey: "College2")
            UserDefaults.standard.set(model.collegePhotos, forKey: "College3")
        case .companySection:
            model.companyName.append(newName.text!)
            model.companyPhone.append(newTel.text!)
            model.companyPhotos.append(selectedImageData!)
            UserDefaults.standard.set(model.companyName, forKey: "Company1")
            UserDefaults.standard.set(model.companyPhone, forKey: "Company2")
            UserDefaults.standard.set(model.companyPhotos, forKey: "Company3")
        case .otherSection:
            model.otherName.append(newName.text!)
            model.otherPhone.append(newTel.text!)
            model.otherPhotos.append(selectedImageData!)
            UserDefaults.standard.set(model.otherName, forKey: "Other1")
            UserDefaults.standard.set(model.otherPhone, forKey: "Other2")
            UserDefaults.standard.set(model.otherPhotos, forKey: "Other3")
        }
        self.dismiss(animated: true, completion: {
            self.newName.text! = ""
            self.newTel.text! = ""
        })
    }
    @objc func keyboardWillShow(notificaation: NSNotification) {
        if !newTel.isFirstResponder {
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
    func textFieldShouldReturn(_ NewBfName: UITextField) -> Bool {
        NewBfName.resignFirstResponder()
        return true
    }
    func textFieldShouldReturn2(_ NewBfTel: UITextField) -> Bool {
        NewBfTel.resignFirstResponder()
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
