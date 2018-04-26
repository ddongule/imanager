//
//  ManagingViewController.swift
//  imanager
//
//  Created by m/Users/minkyung/Desktop/imanager_/imanager/imanagerinkyung on 2018. 4. 14..
//  Copyright © 2018년 minkyung. All rights reserved.
//


import UIKit
import Floaty

class ManagingViewController: UIViewController, FloatyDelegate {

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

    
    override func viewDidAppear(_ animated: Bool) {
        layoutFAB()
    }
    
    // + 버튼 나오는거
    func layoutFAB() {
        let fab = Floaty()
        let item = FloatyItem()
        item.buttonColor = UIColor(red: 188/255, green: 46/255, blue: 35/255, alpha: 1)
        item.circleShadowColor = UIColor(red: 11/255, green: 36/255, blue: 35/255, alpha: 1)
        item.titleShadowColor = UIColor(red: 108/255, green: 96/255, blue: 105/255, alpha: 1)
        item.title = "Custom Item"
        item.handler = { item in }
        
        //fab.addItem(title: "I got a title")
//        alert 나오게 하기
        
//        fab.addItem("현금 내역 추가하기", icon: UIImage(named: "Contacts Filled.png"))
//        { item in
//            let alert = UIAlertController(title: "뀨", message: "메시지" , preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Send Request", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }
        
        fab.addItem("현금 내역 추가하기", icon: UIImage(named: "Contacts Filled.png"))
        { item in
            let cash = self.storyboard?.instantiateViewController(withIdentifier: "addCashViewController") as! addCashViewController
            self.navigationController?.pushViewController(cash, animated: true)
        }
        
        fab.paddingY = 55
        fab.fabDelegate = self
        self.view.addSubview(fab)
        
        
        
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
