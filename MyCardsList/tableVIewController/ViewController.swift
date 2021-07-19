//
//  ViewController.swift
//  MyCardsList
//
//  Created by 山岸善将 on 2021/07/02.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let cardsList = ["家族","親友","地元友達","高校友達","大学友達","会社","その他"]
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.dataSource = self
        myTableView.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardsList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        cell.textLabel?.text = cardsList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        セルの選択解除
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            self.performSegue(withIdentifier: "showCardsList", sender: nil)
        case 1:
            self.performSegue(withIdentifier: "showBfCardsList", sender: nil)
        case 2:
            self.performSegue(withIdentifier: "showLocalCardsList", sender: nil)
        case 3:
            self.performSegue(withIdentifier: "showHighSchoolCardsList", sender: nil)
        case 4:
            self.performSegue(withIdentifier: "showCollegeCardsList", sender: nil)
        case 5:
            self.performSegue(withIdentifier: "showCompanyCardsList", sender: nil)
        case 6:
            self.performSegue(withIdentifier: "showOtherCardsList", sender: nil)
        default:
            break
        }
    }
}

