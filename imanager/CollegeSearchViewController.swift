//
//  CollegeSearchViewController.swift
//  imanager
//
//  Created by minkyung on 2018. 4. 12..
//  Copyright © 2018년 minkyung. All rights reserved.
//

import UIKit
import Foundation


class CollegeSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var txtSearchBar: UITextField!
    @IBOutlet weak var tblCollegeList: UITableView!

    var colleges:[String] = ["가톨릭대학교","건국대학교","경기대학교","경희대학교","고려대학교","광운대학교","국민대학교","동국대학교","명지대학교","삼육대학교","상명대학교","서강대학교","서경대학교","서울대학교","서울과학기술대학교","서울시립대학교","성균관대학교","세종대학교","숭실대학교","연세대학교","중앙대학교","한국외국어대학교","한성대학교","한양대학교","홍익대학교","경성대학교","고신대학교","동명대학교","동서대학교","동아대학교","동의대학교","부경대학교","부산대학교","부산외국어대학교","신라대학교","영산대학교","인제대학교","한국해양대학교","경북대학교","계명대학교","대구교육대학교","가천대학교","안양대학교","연세대학교","인천대학교","인하대학교","청운대학교","건양대학교","대전대학교","목원대학교","배재대학교","우송대학교","을지대학교","충남대학교","한남대학교","한남대학교","한밭대학교","울산대학교","고려대학교(세종캠퍼스)","고려대학교","홍익대학교(세종캠퍼스)","홍익대학교","가천대학교","가톨릭대학교","강남대학교","경기대학교","경동대학교","경희대학교","단국대학교","대진대학교","동국대학교","명지대학교","성균관대학교","수원대학교","신경대학교","신한대학교","아주대학교","안양대학교","예원예술대학교","용인대학교","을지대학교","중부대학교","중앙대학교","차의과학대학교","평택대학교","한경대학교","한국교통대학교","한국산업기술대학교","한국외국어대학교","한국항공대학교","한세대학교","한신대학교","한양대학교(에리카캠퍼스)","한양대학교","협성대학교","서울교육대학교","추계예술대학교","한국예술종합학교","한국체육대학교","KAIST(카이스트)","부산교육대학교","대구경북과학기술원","경인교육대학교","광주과학기술원","울산과학기술원","경인교육대학교","덕성여자대학교","동덕여자대학교","서울여자대학교","성신여자대학교","숙명여자대학교","이화여자대학교","광주여자대학교","가톨릭대학교","감리교신학대학교","서울기독대학교","성공회대학교","장로회신학대학교","총신대학교","KC대학교","한국성서대학교","서울한영대학교","인천가톨릭대학교","대전신학대학교","침례신학대학교","부산가톨릭대학교","고신대학교","루터대학교","서울신학대학교","서울장신대학교","성결대학교","수원가톨릭대학교","아세아연합신학대학교","중앙승가대학교","칼빈대학교","동양미래대학교","명지전문대학","삼육보건대학교","서일대학교","인덕대학교","경인여자대학교","배화여자대학교","부산여자대학교","서울여자간호대학교","수원여자대학교","숭의여자대학교","한양여자대학교"] //sort하는 법을 모르겠다
    
    
        // 일단 적은 수들의 표본만 진행 => 전체 대학 모든 과를 가져오기가 힘들어서 일단 이렇게 진행하는게 맞을듯
//           이라고 생각햇지만 일단 json으로 해본다.
//    var colleges:[String] = ["서울대학교","연세대학교","고려대학교","서강대학교","성균관대학교","한양대학교","중앙대학교","경희대학교","한국외국어대학교","서울시립대학교","이화여자대학교","숙명여자대학교","건국대학교","동국대학교","홍익대학교"]
    
    

    var originalCollegesList:[String] = Array()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.


        self.title = "내 학교 찾기"
        // 밑의 코드를 써야 search할 때 그 단어가 있는 검색결과가 나오게 됨.
        for college in colleges {
            originalCollegesList.append(college)
        }

        tblCollegeList.delegate = self
        tblCollegeList.dataSource = self
        txtSearchBar.delegate = self
        txtSearchBar.addTarget(self, action: #selector(searchRecords(_ :)), for: .editingChanged)

    }

    //Mark : UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtSearchBar.resignFirstResponder()
        return true
    }


    //Mark : Search Records
    @objc func searchRecords(_ textField: UITextField) {
        self.colleges.removeAll()
        if textField.text?.count != 0 {
            for college in originalCollegesList {
                if let collegeToSearch = textField.text {
                    let range = college.lowercased().range(of: collegeToSearch, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {
                        self.colleges.append(college)
                    }
                }
            }
        } else {
            for college in originalCollegesList {
                colleges.append(college)
            }
        }
        tblCollegeList.reloadData()
    }


    //Mark : UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colleges.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "college")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "college")
        }
        cell?.textLabel?.text = colleges[indexPath.row]
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detVC = self.storyboard?.instantiateViewController(withIdentifier: "CollegeSearchDetailViewController") as! CollegeSearchDetailViewController
        detVC.strCollegeName = colleges[indexPath.row]
        self.navigationController?.pushViewController(detVC, animated: true)
    }


    
    
    // 여기부터 ------------ json으로 해보기

    ///// 예제를 위한 임의의 JSON 데이터
//
//    var univ_names = [Univ()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let path = Bundle.main.path(forResource: "univ_major", ofType: "json")
//        let url = URL(fileURLWithPath: path!)
//
//        func parseUniv() {
//            guard let url = Bundle.main.url(forResource: "univ_major", withExtension: "json"),
//                let jsonData = NSData(contentsOf: url) else {
//                    print("Error finding JSON File")
//                    return
//
//            }
//
//
//
//                let fruitArray = jsonObject["fruits"].arrayValue
//                for aFruit in fruitArray {
//                    let name = aFruit["Name"].stringValue
//                    let imageURL = aFruit["Picture"].stringValue
//                    let description = aFruit["Description"].stringValue
//
//                    let fruit = Fruit(name: name, imageURL: NSURL(string:imageURL)!, description:description)
//                    fruits.append(fruit)
//                }
//
//                self.tableView.reloadData()
//            }, jsonData = NSData(contentsOfURL: url) else {
//                print("Error finding JSON File")
//                return
//            }
//
//            let jsonObject = JSON(data: jsonData)
//
//            let fruitArray = jsonObject["fruits"].arrayValue
//            for aFruit in fruitArray {
//                let name = aFruit["Name"].stringValue
//                let imageURL = aFruit["Picture"].stringValue
//                let description = aFruit["Description"].stringValue
//
//                let fruit = Fruit(name: name, imageURL: NSURL(string:imageURL)!, description:description)
//                fruits.append(fruit)
//            }
//
//            self.tableView.reloadData()
//        }
    
//        do {
//            let data = try! Data(contentsOf: url)
//            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//                        print(json)
//            guard let array = json as? [Any] else { return }
            
//            for univ in array {
//                guard let univDict = univ as? [String: Any] else { return }
//                guard let univName = univDict["univ_name"] as? String else { print("not a String"); return }
//                guard let univCampus = univDict["campus"] as? String else { return }
//                guard let univMajor = univDict["major"] as? String else { return }
//                print(univName)
//                print(univMajor)
//                print(" ")
//
//
//                self.tblCollegeList.reloadData()
//            }
   
    /////
    
    

    }

