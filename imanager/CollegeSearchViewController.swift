//
//  CollegeSearchViewController.swift
//  imanager
//
//  Created by minkyung on 2018. 4. 12..
//  Copyright © 2018년 minkyung. All rights reserved.
//

import UIKit

class CollegeSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var txtSearchBar: UITextField!
    @IBOutlet weak var tblCollegeList: UITableView!
    
    var colleges:[String] = ["중앙대학교", "서강대학교", "서울대학교", "연세대학교", "고려대학교", "성균관대학교", "한양대학교", "경희대학교", "한국외국어대학교", "시립대학교", "이화여자대학교","숙명여자대학교"] //sort 하는 법을 잘 몰겟슴
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


