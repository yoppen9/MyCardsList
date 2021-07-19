//
//  CollegeSettingViewController.swift
//  MyCardsList
//
//  Created by 山岸善将 on 2021/07/18.
//

import UIKit

class CollegeSettingViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var NewCollegeName: UITextField!
    @IBOutlet weak var NewCollegeImage: UIImageView!
    @IBOutlet weak var NewCollegeDescription: UITextView!
    @IBOutlet weak var NewCollegeTel: UITextField!
    var selectedImageData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.NewCollegeName.delegate = self
        self.NewCollegeDescription.delegate = self
        self.NewCollegeTel.delegate = self
        self.NewCollegeTel.keyboardType = UIKeyboardType.numberPad
        NewCollegeDescription.layer.borderColor = UIColor.lightGray.cgColor
        NewCollegeDescription.layer.borderWidth = 1.0
        NewCollegeDescription.layer.cornerRadius = 8
        NewCollegeDescription.layer.masksToBounds = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow2), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.NewCollegeTel.isFirstResponder) {
            self.NewCollegeTel.resignFirstResponder()
        }
        if (self.NewCollegeDescription.isFirstResponder) {
            self.NewCollegeDescription.resignFirstResponder()
        }
    }
    @IBAction func NewCollegeButton(_ sender: Any) {
        guard let text = NewCollegeName.text, !text.isEmpty else { return }
//        guard let text = NewCollegeTel.text, !text.isEmpty else { return }
//        guard let text = NewCollegeDescription.text, !text.isEmpty else { return }
//        guard let text = selectedImageData, !text.isEmpty else { return }
        CollegeName.append(NewCollegeName.text!)
        CollegePhone.append(NewCollegeTel.text!)
        CollegePhotos.append(selectedImageData!)
        CollegeDescription.append(NewCollegeDescription.text!)
        print(CollegeName)
        print(CollegePhone)
        print(CollegePhotos)
        print(CollegeDescription)
        NewCollegeName.text! = ""
        NewCollegeTel.text! = ""
        NewCollegeDescription.text! = ""
        UserDefaults.standard.set(CollegeName, forKey: "College1")
        UserDefaults.standard.set(CollegePhone, forKey: "College2")
        UserDefaults.standard.set(CollegePhotos, forKey: "College3")
        UserDefaults.standard.set(CollegeDescription, forKey: "College4")
        self.dismiss(animated: true, completion: nil)
    }
    @objc func keyboardWillShow(notificaation: NSNotification) {
        if !NewCollegeTel.isFirstResponder {
            return
        }
        if self.view.frame.origin.y == 0 {
            if ((notificaation.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
                self.view.frame.origin.y = -110
            }
        }
    }
    @objc func keyboardWillShow2(notificaation: NSNotification) {
        if !NewCollegeDescription.isFirstResponder {
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

extension CollegeSettingViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        NewCollegeImage.image = selectedImage
        selectedImageData = selectedImage.pngData()
        dismiss(animated: true, completion: nil)
    }
    @IBAction func CollegeImageButton(_ sender: Any) {
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

extension CollegeSettingViewController {
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        guard let presentationController = presentationController else {
            return
        }
        presentationController.delegate?.presentationControllerDidDismiss?(presentationController)
    }
}

extension CollegeSettingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ NewCollegeName: UITextField) -> Bool {
        NewCollegeName.resignFirstResponder()
        return true
    }
    func textFieldShouldReturn2(_ NewCollegeTel: UITextField) -> Bool {
        NewCollegeTel.resignFirstResponder()
        return true
    }
}

extension CollegeSettingViewController: UITextViewDelegate {
    func textFieldShouldReturn3(_ NewCollegeDescription: UITextView) -> Bool {
        NewCollegeDescription.resignFirstResponder()
        return true
    }
}
