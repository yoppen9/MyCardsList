//
//  CompanySettingViewController.swift
//  MyCardsList
//
//  Created by 山岸善将 on 2021/07/18.
//

import UIKit

class CompanySettingViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var NewCompanyName: UITextField!
    @IBOutlet weak var NewCompanyImage: UIImageView!
    @IBOutlet weak var NewCompanyDescription: UITextView!
    @IBOutlet weak var NewCompanyTel: UITextField!
    var selectedImageData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.NewCompanyName.delegate = self
        self.NewCompanyDescription.delegate = self
        self.NewCompanyTel.delegate = self
        self.NewCompanyTel.keyboardType = UIKeyboardType.numberPad
        NewCompanyDescription.layer.borderColor = UIColor.lightGray.cgColor
        NewCompanyDescription.layer.borderWidth = 1.0
        NewCompanyDescription.layer.cornerRadius = 8
        NewCompanyDescription.layer.masksToBounds = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow2), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.NewCompanyTel.isFirstResponder) {
            self.NewCompanyTel.resignFirstResponder()
        }
        if (self.NewCompanyDescription.isFirstResponder) {
            self.NewCompanyDescription.resignFirstResponder()
        }
    }
    @IBAction func NewCompanyButton(_ sender: Any) {
        guard let text = NewCompanyName.text, !text.isEmpty else { return }
//        guard let text = NewCompanyTel.text, !text.isEmpty else { return }
//        guard let text = NewCompanyDescription.text, !text.isEmpty else { return }
//        guard let text = selectedImageData, !text.isEmpty else { return }
        CompanyName.append(NewCompanyName.text!)
        CompanyPhone.append(NewCompanyTel.text!)
        CompanyPhotos.append(selectedImageData!)
        CompanyDescription.append(NewCompanyDescription.text!)
        print(CompanyName)
        print(CompanyPhone)
        print(CompanyPhotos)
        print(CompanyDescription)
        NewCompanyName.text! = ""
        NewCompanyTel.text! = ""
        NewCompanyDescription.text! = ""
        UserDefaults.standard.set(CompanyName, forKey: "Company1")
        UserDefaults.standard.set(CompanyPhone, forKey: "Company2")
        UserDefaults.standard.set(CompanyPhotos, forKey: "Company3")
        UserDefaults.standard.set(CompanyDescription, forKey: "Company4")
        self.dismiss(animated: true, completion: nil)
    }
    @objc func keyboardWillShow(notificaation: NSNotification) {
        if !NewCompanyTel.isFirstResponder {
            return
        }
        if self.view.frame.origin.y == 0 {
            if ((notificaation.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
                self.view.frame.origin.y = -110
            }
        }
    }
    @objc func keyboardWillShow2(notificaation: NSNotification) {
        if !NewCompanyDescription.isFirstResponder {
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

extension CompanySettingViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        NewCompanyImage.image = selectedImage
        selectedImageData = selectedImage.pngData()
        dismiss(animated: true, completion: nil)
    }
    @IBAction func CompanyImageButton(_ sender: Any) {
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

extension CompanySettingViewController {
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        guard let presentationController = presentationController else {
            return
        }
        presentationController.delegate?.presentationControllerDidDismiss?(presentationController)
    }
}

extension CompanySettingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ NewCompanyName: UITextField) -> Bool {
        NewCompanyName.resignFirstResponder()
        return true
    }
    func textFieldShouldReturn2(_ NewCompanyTel: UITextField) -> Bool {
        NewCompanyTel.resignFirstResponder()
        return true
    }
}

extension CompanySettingViewController: UITextViewDelegate {
    func textFieldShouldReturn3(_ NewCompanyDescription: UITextView) -> Bool {
        NewCompanyDescription.resignFirstResponder()
        return true
    }
}
