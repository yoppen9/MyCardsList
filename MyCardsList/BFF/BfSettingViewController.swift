//
//  BfSettingViewController.swift
//  MyCardsList
//
//  Created by 山岸善将 on 2021/07/16.
//

import UIKit

class BfSettingViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var NewBfName: UITextField!
    @IBOutlet weak var NewBfImage: UIImageView!
    @IBOutlet weak var NewBfDescription: UITextView!
    @IBOutlet weak var NewBfTel: UITextField!
    var selectedImageData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.NewBfName.delegate = self
        self.NewBfDescription.delegate = self
        self.NewBfTel.delegate = self
        self.NewBfTel.keyboardType = UIKeyboardType.numberPad
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.NewBfTel.isFirstResponder) {
            self.NewBfTel.resignFirstResponder()
        }
        if (self.NewBfDescription.isFirstResponder) {
            self.NewBfDescription.resignFirstResponder()
        }
    }
    @IBAction func NewBfButton(_ sender: Any) {
        guard let text = NewBfName.text, !text.isEmpty else { return }
        guard let text = NewBfTel.text, !text.isEmpty else { return }
        guard let text = NewBfDescription.text, !text.isEmpty else { return }
        BfName.append(NewBfName.text!)
        BfPhone.append(NewBfTel.text!)
        BfPhotos.append(selectedImageData!)
        BfDescription.append(NewBfDescription.text!)
        print(BfName)
        print(BfPhone)
        print(BfPhotos)
        print(BfDescription)
        NewBfName.text! = ""
        NewBfTel.text! = ""
        NewBfDescription.text! = ""
        UserDefaults.standard.set(BfName, forKey: "Bf1")
        UserDefaults.standard.set(BfPhone, forKey: "Bf2")
        UserDefaults.standard.set(BfPhotos, forKey: "Bf3")
        UserDefaults.standard.set(BfDescription, forKey: "Bf4")
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension BfSettingViewController: UIImagePickerControllerDelegate {
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

extension BfSettingViewController {
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        guard let presentationController = presentationController else {
            return
        }
        presentationController.delegate?.presentationControllerDidDismiss?(presentationController)
    }
}

extension BfSettingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ NewBfName: UITextField) -> Bool {
        NewBfName.resignFirstResponder()
        return true
    }
    func textFieldShouldReturn2(_ NewBfTel: UITextField) -> Bool {
        NewBfTel.resignFirstResponder()
        return true
    }
}

extension BfSettingViewController: UITextViewDelegate {
    func textFieldShouldReturn3(_ NewBfDescription: UITextView) -> Bool {
        NewBfDescription.resignFirstResponder()
        return true
    }
}
