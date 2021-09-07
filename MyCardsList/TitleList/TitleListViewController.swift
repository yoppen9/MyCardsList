//
//  ViewController.swift
//  MyCardsList
//
//  Created by 山岸善将 on 2021/07/02.
//

import UIKit


class TitleListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    private let model: TitleListModel = TitleListModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.dataSource = self
        myTableView.delegate = self
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBfCardsList" {
            let nextVC = segue.destination as! CardListViewController
            nextVC.model = model
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.cardsList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        cell.textLabel?.text = model.cardsList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch model.cardsList[indexPath.row] {
        case "家族":
            model.sectionTitle = "家族"
            model.section = .familySection
            self.performSegue(withIdentifier: "showBfCardsList", sender: nil)
        case "親友":
            model.sectionTitle = "親友"
            model.section = .bfSection
            self.performSegue(withIdentifier: "showBfCardsList", sender: nil)
        case "地元友達":
            model.sectionTitle = "地元友達"
            model.section = .localSection
            self.performSegue(withIdentifier: "showBfCardsList", sender: nil)
        case "高校友達":
            model.sectionTitle = "高校友達"
            model.section = .highSchoolSection
            self.performSegue(withIdentifier: "showBfCardsList", sender: nil)
        case "大学友達":
            model.sectionTitle = "大学"
            model.section = .collegeSection
            self.performSegue(withIdentifier: "showBfCardsList", sender: nil)
        case "会社":
            model.sectionTitle = "会社"
            model.section = .companySection
            self.performSegue(withIdentifier: "showBfCardsList", sender: nil)
        case "その他":
            model.sectionTitle = "その他"
            model.section = .otherSection
            self.performSegue(withIdentifier: "showBfCardsList", sender: nil)
        default:
            return
        }
//        セルの選択解除
//        tableView.deselectRow(at: indexPath, animated: true)
//        switch indexPath.row {
//        case 0:
//            self.performSegue(withIdentifier: "showBfCardsList", sender: nil)
//        case 1:
//            self.performSegue(withIdentifier: "showBfCardsList", sender: nil)
//        case 2:
//            self.performSegue(withIdentifier: "showBfCardsList", sender: nil)
//        case 3:
//            self.performSegue(withIdentifier: "showBfCardsList", sender: nil)
//        case 4:
//            self.performSegue(withIdentifier: "showBfCardsList", sender: nil)
//        case 5:
//            self.performSegue(withIdentifier: "showBfCardsList", sender: nil)
//        case 6:
//            self.performSegue(withIdentifier: "showBfCardsList", sender: nil)
//        default:
//            break
//        }
    }
}

