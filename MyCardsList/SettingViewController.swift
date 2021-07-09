//
//  SettingViewController.swift
//  MyCardsList
//
//  Created by 山岸善将 on 2021/07/03.
//

import UIKit

class SettingViewController: UIViewController,UINavigationControllerDelegate,UITextViewDelegate {
    
    @IBOutlet weak var NewCardsName: UITextField!
    @IBOutlet weak var NewCardsImage: UIImageView!
    @IBOutlet weak var NewCardsDescription: UITextView!
    @IBOutlet weak var NewCardsTel: UITextField!
    
    var resultHandler: ((String) -> Void)?
    var resultHandler2: ((String) -> Void)?
    var resultHandler3: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.NewCardsName.delegate = self
        self.NewCardsDescription.delegate = self
        self.NewCardsTel.delegate = self
//        電話番号入力を数字だけにする
        self.NewCardsTel.keyboardType = UIKeyboardType.numberPad
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.NewCardsTel.isFirstResponder) {
            self.NewCardsTel.resignFirstResponder()
        }
    }
    func textFieldShouldReturn(_ NewCardsName: UITextField) -> Bool {
        NewCardsName.resignFirstResponder()
        return true
    }
    func textFieldShouldReturn2(_ NewCardsTel: UITextField) -> Bool {
        NewCardsTel.resignFirstResponder()
        return true
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
    @IBAction func NewCardsButton(_ sender: Any) {
        guard let text = NewCardsName.text, !text.isEmpty else { return }
        guard let text = NewCardsTel.text, !text.isEmpty else { return }
        name.append(NewCardsName.text!)
        phoneNumber.append(NewCardsTel.text!)
        print(name)
        print(phoneNumber)
        NewCardsName.text! = ""
        NewCardsTel.text! = ""
        UserDefaults.standard.set(name, forKey: "listPass")
        UserDefaults.standard.set(phoneNumber, forKey: "listPass2")
//        guard let text = self.NewCardsName.text else { return }
//        if let handler = self.resultHandler {
//            handler(text)
//        }
//        guard let text = self.NewCardsDescription.text else { return }
//        if let handler = self.resultHandler2 {
//            handler(text)
//        }
//        guard let text = self.NewCardsTel.text else { return }
//        if let handler = self.resultHandler3 {
//            handler(text)
//        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension SettingViewController: UIImagePickerControllerDelegate {
    //    カメラ撮影、フォトライブラリーの選択後に呼び出される
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    //        撮影、ライブラリーから選択した画像をNewCardsImageに配置
            NewCardsImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
    //        モーダルビューを閉じる
            dismiss(animated: true, completion: nil)
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
}
