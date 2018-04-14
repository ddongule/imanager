//
//  ManagingViewController.swift
//  imanager
//
//  Created by m/Users/minkyung/Desktop/imanager_/imanager/imanagerinkyung on 2018. 4. 14..
//  Copyright © 2018년 minkyung. All rights reserved.
//

import UIKit

class ManagingViewController: UIViewController {

    @IBOutlet weak var MonthLabel: UILabel!
    @IBAction func Next(_ sender: Any) {
        switch currentMonth {
        case "12월":
            month = 0
            year += 1
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.autoupdatingCurrent
            
        default:
            month += 1
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.autoupdatingCurrent
            //Calendar.reloadData()
        }
    }
    @IBAction func Back(_ sender: Any) {
        switch currentMonth {
        case "1월":
            month = 11
            year -= 1
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.autoupdatingCurrent

        default:
            month -= 1
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.autoupdatingCurrent
        }
    }
    var currentMonth = String()
    
    let Months = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentMonth = Months[month]
        MonthLabel.text = "\(currentMonth) \(year)"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
