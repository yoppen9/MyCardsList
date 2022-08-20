//
//  CalendarViewController.swift
//  MyCardsList
//
//  Created by 山岸善将 on 2022/06/03.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    @IBOutlet weak var fsCalendar: FSCalendar!
    
    let userData = UserDefaults.standard.stringArray(forKey: "Family2")
    let userImage: [Any] = UserDefaults.standard.array(forKey: "Family3")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("家族の誕生日は\(userData!)です。")
        print("家族の写真は\(userImage)です。")
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        let dataString = formatter.string(from: date)

        if userData!.contains(dataString) {
            return 1
        }
        return 0
    }

}
