//
//  LocalSettingViewController.swift
//  MyCardsList
//
//  Created by 山岸善将 on 2021/07/17.
//

import UIKit

class LocalSettingViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var NewLocalName: UITextField!
    @IBOutlet weak var NewLocalImage: UIImageView!
    @IBOutlet weak var NewLocalDescription: UITextView!
    @IBOutlet weak var NewLocalTel: UITextField!
    var selectedImageData: Data?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.NewLocalName.delegate = self
        self.NewLocalDescription.delegate = self
        self.NewLocalTel.delegate = self
        self.NewLocalTel.keyboardType = UIKeyboardType.numberPad
        NewLocalDescription.layer.borderColor = UIColor.lightGray.cgColor
        NewLocalDescription.layer.borderWidth = 1.0
        NewLocalDescription.layer.cornerRadius = 8
        NewLocalDescription.layer.masksToBounds = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow2), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.NewLocalTel.isFirstResponder) {
            self.NewLocalTel.resignFirstResponder()
        }
        if (self.NewLocalDescription.isFirstResponder) {
            self.NewLocalDescription.resignFirstResponder()
        }
    }
    @IBAction func NewLocalButton(_ sender: Any) {
        guard let text = NewLocalName.text, !text.isEmpty else { return }
//        guard let text = NewLocalTel.text, !text.isEmpty else { return }
//        guard let text = NewLocalDescription.text, !text.isEmpty else { return }
//        guard let text = selectedImageData, !text.isEmpty else { return }
        LocalName.append(NewLocalName.text!)
        LocalPhone.append(NewLocalTel.text!)
        LocalPhotos.append(selectedImageData!)
        LocalDescription.append(NewLocalDescription.text!)
        print(LocalName)
        print(LocalPhone)
        print(LocalPhotos)
        print(LocalDescription)
        NewLocalName.text! = ""
        NewLocalTel.text! = ""
        NewLocalDescription.text! = ""
        UserDefaults.standard.set(LocalName, forKey: "Local1")
        UserDefaults.standard.set(LocalPhone, forKey: "Local2")
        UserDefaults.standard.set(LocalPhotos, forKey: "Local3")
        UserDefaults.standard.set(LocalDescription, forKey: "Local4")
        self.dismiss(animated: true, completion: nil)
    }
    @objc func keyboardWillShow(notificaation: NSNotification) {
        if !NewLocalTel.isFirstResponder {
            return
        }
        if self.view.frame.origin.y == 0 {
            if ((notificaation.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
                self.view.frame.origin.y = -110
            }
        }
    }
    @objc func keyboardWillShow2(notificaation: NSNotification) {
        if !NewLocalDescription.isFirstResponder {
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

extension LocalSettingViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        NewLocalImage.image = selectedImage
        selectedImageData = selectedImage.pngData()
        dismiss(animated: true, completion: nil)
    }
    @IBAction func LocalImageButton(_ sender: Any) {
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

extension LocalSettingViewController {
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        guard let presentationController = presentationController else {
            return
        }
        presentationController.delegate?.presentationControllerDidDismiss?(presentationController)
    }
}

extension LocalSettingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ NewLocalName: UITextField) -> Bool {
        NewLocalName.resignFirstResponder()
        return true
    }
    func textFieldShouldReturn2(_ NewLocalTel: UITextField) -> Bool {
        NewLocalTel.resignFirstResponder()
        return true
    }
}

extension LocalSettingViewController: UITextViewDelegate {
    func textFieldShouldReturn3(_ NewLocalDescription: UITextView) -> Bool {
        NewLocalDescription.resignFirstResponder()
        return true
    }
}
