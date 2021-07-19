//
//  SettingViewController.swift
//  MyCardsList
//
//  Created by 山岸善将 on 2021/07/03.
//

import UIKit

class SettingViewController: UIViewController,UINavigationControllerDelegate {
    
    @IBOutlet weak var NewCardsName: UITextField!
    @IBOutlet weak var NewCardsImage: UIImageView!
    @IBOutlet weak var NewCardsDescription: UITextView!
    @IBOutlet weak var NewCardsTel: UITextField!
    var selectedImageData: Data?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.NewCardsName.delegate = self
        self.NewCardsDescription.delegate = self
        self.NewCardsTel.delegate = self
        self.NewCardsTel.keyboardType = UIKeyboardType.numberPad
        NewCardsDescription.layer.borderColor = UIColor.lightGray.cgColor
        NewCardsDescription.layer.borderWidth = 1.0
        NewCardsDescription.layer.cornerRadius = 8
        NewCardsDescription.layer.masksToBounds = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow2), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.NewCardsTel.isFirstResponder) {
            self.NewCardsTel.resignFirstResponder()
        }
        if (self.NewCardsDescription.isFirstResponder) {
            self.NewCardsDescription.resignFirstResponder()
        }
    }
    @IBAction func NewCardsButton(_ sender: Any) {
        guard let text = NewCardsName.text, !text.isEmpty else { return }
//        guard let text = NewCardsTel.text, !text.isEmpty else { return }
//        guard let text = NewCardsDescription.text, !text.isEmpty else { return }
//        guard let text = selectedImageData, !text.isEmpty else { return }
        name.append(NewCardsName.text!)
        phoneNumber.append(NewCardsTel.text!)
        photos.append(selectedImageData!)
        description1.append(NewCardsDescription.text!)
        print(name)
        print(phoneNumber)
        print(photos)
        print(description1)
        NewCardsName.text! = ""
        NewCardsTel.text! = ""
        NewCardsDescription.text! = ""
        UserDefaults.standard.set(name, forKey: "listPass")
        UserDefaults.standard.set(phoneNumber, forKey: "listPass2")
        UserDefaults.standard.set(photos, forKey: "listPass3")
        UserDefaults.standard.set(description1, forKey: "listPass4")
        self.dismiss(animated: true, completion: nil)
    }
    @objc func keyboardWillShow(notificaation: NSNotification) {
        if !NewCardsTel.isFirstResponder {
            return
        }
        if self.view.frame.origin.y == 0 {
            if ((notificaation.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
                self.view.frame.origin.y = -110
            }
        }
    }
    @objc func keyboardWillShow2(notificaation: NSNotification) {
        if !NewCardsDescription.isFirstResponder {
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

extension SettingViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        NewCardsImage.image = selectedImage
        selectedImageData = selectedImage.pngData()
        dismiss(animated: true, completion: nil)
    }
    @IBAction func ImageButtonAction(_ sender: Any) {
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

extension SettingViewController {
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        guard let presentationController = presentationController else {
            return
        }
        presentationController.delegate?.presentationControllerDidDismiss?(presentationController)
    }
}

extension SettingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ NewCardsName: UITextField) -> Bool {
        NewCardsName.resignFirstResponder()
        return true
    }
    func textFieldShouldReturn2(_ NewCardsTel: UITextField) -> Bool {
        NewCardsTel.resignFirstResponder()
        return true
    }
}

extension SettingViewController: UITextViewDelegate {
    func textFieldShouldReturn3(_ NewCardsDescription: UITextView) -> Bool {
        NewCardsDescription.resignFirstResponder()
        return true
    }
}
