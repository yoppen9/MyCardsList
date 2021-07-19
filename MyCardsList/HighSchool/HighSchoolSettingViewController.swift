//
//  HighSchoolSettingViewController.swift
//  MyCardsList
//
//  Created by 山岸善将 on 2021/07/17.
//

import UIKit

class HighSchoolSettingViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var NewHighSchoolName: UITextField!
    @IBOutlet weak var NewHighSchoolImage: UIImageView!
    @IBOutlet weak var NewHighSchoolDescription: UITextView!
    @IBOutlet weak var NewHighSchoolTel: UITextField!
    var selectedImageData: Data?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.NewHighSchoolName.delegate = self
        self.NewHighSchoolDescription.delegate = self
        self.NewHighSchoolTel.delegate = self
        self.NewHighSchoolTel.keyboardType = UIKeyboardType.numberPad
        NewHighSchoolDescription.layer.borderColor = UIColor.lightGray.cgColor
        NewHighSchoolDescription.layer.borderWidth = 1.0
        NewHighSchoolDescription.layer.cornerRadius = 8
        NewHighSchoolDescription.layer.masksToBounds = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow2), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.NewHighSchoolTel.isFirstResponder) {
            self.NewHighSchoolTel.resignFirstResponder()
        }
        if (self.NewHighSchoolDescription.isFirstResponder) {
            self.NewHighSchoolDescription.resignFirstResponder()
        }
    }
    @IBAction func NewHighSchoolButton(_ sender: Any) {
        guard let text = NewHighSchoolName.text, !text.isEmpty else { return }
//        guard let text = NewHighSchoolTel.text, !text.isEmpty else { return }
//        guard let text = NewHighSchoolDescription.text, !text.isEmpty else { return }
//        guard let text = selectedImageData, !text.isEmpty else { return }
        HighSchoolName.append(NewHighSchoolName.text!)
        HighSchoolPhone.append(NewHighSchoolTel.text!)
        HighSchoolPhotos.append(selectedImageData!)
        HighSchoolDescription.append(NewHighSchoolDescription.text!)
        print(HighSchoolName)
        print(HighSchoolPhone)
        print(HighSchoolPhotos)
        print(HighSchoolDescription)
        NewHighSchoolName.text! = ""
        NewHighSchoolTel.text! = ""
        NewHighSchoolDescription.text! = ""
        UserDefaults.standard.set(HighSchoolName, forKey: "HighSchool1")
        UserDefaults.standard.set(HighSchoolPhone, forKey: "HighSchool2")
        UserDefaults.standard.set(HighSchoolPhotos, forKey: "HighSchool3")
        UserDefaults.standard.set(HighSchoolDescription, forKey: "HighSchool4")
        self.dismiss(animated: true, completion: nil)
    }
    @objc func keyboardWillShow(notificaation: NSNotification) {
        if !NewHighSchoolTel.isFirstResponder {
            return
        }
        if self.view.frame.origin.y == 0 {
            if ((notificaation.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
                self.view.frame.origin.y = -110
            }
        }
    }
    @objc func keyboardWillShow2(notificaation: NSNotification) {
        if !NewHighSchoolDescription.isFirstResponder {
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

extension HighSchoolSettingViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        NewHighSchoolImage.image = selectedImage
        selectedImageData = selectedImage.pngData()
        dismiss(animated: true, completion: nil)
    }
    @IBAction func HighSchoolImageButton(_ sender: Any) {
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

extension HighSchoolSettingViewController {
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        guard let presentationController = presentationController else {
            return
        }
        presentationController.delegate?.presentationControllerDidDismiss?(presentationController)
    }
}

extension HighSchoolSettingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ NewHighSchoolName: UITextField) -> Bool {
        NewHighSchoolName.resignFirstResponder()
        return true
    }
    func textFieldShouldReturn2(_ NewHighSchoolTel: UITextField) -> Bool {
        NewHighSchoolTel.resignFirstResponder()
        return true
    }
}

extension HighSchoolSettingViewController: UITextViewDelegate {
    func textFieldShouldReturn3(_ NewHighSchoolDescription: UITextView) -> Bool {
        NewHighSchoolDescription.resignFirstResponder()
        return true
    }
}
