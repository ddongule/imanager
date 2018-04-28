//
//  TabCalendarViewController.swift
//  imanager
//
//  Created by minkyung on 2018. 4. 28..
//  Copyright © 2018년 minkyung. All rights reserved.
//

import UIKit

class TabCalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  
    var Months = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
    var DaysOfMonth = ["월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"]
    var DaysInMonths = [31,28,31,30,31,30,31,31,30,31,30,31]
    var currentMonth = String()
    
    var NumberOfEmptyBox = Int() //the number of empty boxes at the start of current month
    var NextNumberOfEmptyBox = Int() // the same with above but with the next month
    var PreviousNumberOfEmptyBox = 0 // the same with above with the prev month
    var Direction = 0 // =0 if we are at the current month, =1 if we are in a future month, =-1 if we are in a past month
    
    var PositionIndex = 0 // here we will store the above of the empty boxes
    
    var LeapYearCounter = 2
    
    @IBOutlet weak var Calendar: UICollectionView!
    @IBOutlet weak var MonthLabel: UILabel!
    
    @IBAction func Next(_ sender: Any) {
        switch currentMonth {
        case "12월":
            month = 0
            year += 1
            Direction = 1
            
            if LeapYearCounter < 5 {
                LeapYearCounter += 1
            }
          
            if LeapYearCounter == 4 {
                DaysInMonths[1] = 29
            }
            
            if LeapYearCounter == 5 {
                LeapYearCounter = 1
                DaysInMonths[1] = 28
            }
   
            
            GetStartDateDayPosition()
            
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
            
        default:
            Direction = 1
            
            GetStartDateDayPosition()
            month += 1

            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
            //Calendar.reloadData()
        }
    }
    
    @IBAction func Back(_ sender: Any) {
        switch currentMonth {
        case "1월":
            month = 11
            year -= 1
            Direction = -1
            
            if LeapYearCounter > 0 {
                LeapYearCounter -= 1
            }
            
            if LeapYearCounter == 0 {
                DaysInMonths[1] = 29
                LeapYearCounter = 4
            } else {
                DaysInMonths[1] = 28
            }
            
            
            GetStartDateDayPosition()
            
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()

        default:
            month -= 1
            Direction = -1
            
            GetStartDateDayPosition()
            
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
        }
    }
    
    func GetStartDateDayPosition() {
        switch Direction {
        case 0:
            switch day {
            case 1...7:
                NumberOfEmptyBox = weekday - day
            case 8...14:
                NumberOfEmptyBox = weekday - day - 7
            case 15...21:
                NumberOfEmptyBox = weekday - day - 14
            case 22...28:
                NumberOfEmptyBox = weekday - day - 21
            case 29...31:
                NumberOfEmptyBox = weekday - day - 28
            default:
                break
            }
            PositionIndex = NumberOfEmptyBox
        
        case 1...:
            NextNumberOfEmptyBox = (PositionIndex + DaysInMonths[month])%7
            PositionIndex = NextNumberOfEmptyBox
        
        case -1:
            PreviousNumberOfEmptyBox = (7 - (DaysInMonths[month] - PositionIndex)%7)
            if PreviousNumberOfEmptyBox == 7 {
                PreviousNumberOfEmptyBox = 0
            }
            PositionIndex = PreviousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentMonth = Months[month]
        MonthLabel.text = "\(currentMonth) \(year)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Direction{
        case 0:
            return DaysInMonths[month] + NumberOfEmptyBox
        case 1:
            return DaysInMonths[month] + NextNumberOfEmptyBox
        case -1:
            return DaysInMonths[month] + PreviousNumberOfEmptyBox
        default:
            fatalError()
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendar", for: indexPath) as! DateCollectionViewCell
        cell.backgroundColor = UIColor.clear
        cell.DateLabel.textColor = UIColor.black
        if cell.isHidden {
            cell.isHidden = false
        }
        
        switch Direction{
        case 0:
            cell.DateLabel.text = "\(indexPath.row + 1 - NumberOfEmptyBox)"
        case 1:
            cell.DateLabel.text = "\(indexPath.row + 1 - NextNumberOfEmptyBox)"
        case -1:
            cell.DateLabel.text = "\(indexPath.row + 1 - PreviousNumberOfEmptyBox)"
        default:
            fatalError()
        }
        
        if Int(cell.DateLabel.text!)! < 1{
            cell.isHidden = true
        }
        
        switch indexPath.row {
        case 0,6,7,13,14,20,21,27,28,34,35:
            if Int(cell.DateLabel.text!)! > 0 {
                cell.DateLabel.textColor = UIColor.lightGray
            }
        default:
            break
        }
        //marks red the cell the shows the current date
        if currentMonth == Months[calendar.component(.month, from:date) - 1] && year == calendar.component(.year, from: date) && indexPath.row + 1 == day {
            cell.backgroundColor = UIColor.cyan
        }
        return cell
    }
}
