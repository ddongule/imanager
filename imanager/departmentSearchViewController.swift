//
//  departmentSearchViewController.swift
//  imanager
//
//  Created by minkyung on 2018. 4. 19..
//  Copyright © 2018년 minkyung. All rights reserved.
//

import UIKit

class departmentSearchViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {


    @IBOutlet weak var departmentSearchBar: UITextField!
    @IBOutlet weak var departmentList: UITableView!
    
    var originalDepartmentList:[String] = Array()
    
    var departments:[String] = ["총 학생회","통계학과"]
    
    //학과 json 가져오기
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "학과 찾기"
        
        // Do any additional setup after loading the view.
        for department in departments {
            originalDepartmentList.append(department)
        }
        
        departmentList.delegate = self
        departmentList.dataSource = self
        departmentSearchBar.delegate = self
        departmentSearchBar.addTarget(self, action: #selector(searchRecords(_ :)), for: .editingChanged)
        
        
        // 학과 json local file(univ_major.json)에서 가져오기
        
        let path = Bundle.main.path(forResource: "univ_major", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        do {
            let data = try! Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//            print(json)

            guard let array = json as? [Any] else { return }
            
            for univ in array {
                guard let univDict = univ as? [String: Any] else { return }
                guard let univName = univDict["univ_name"] as? String else { print("not a String"); return }
                guard let univCampus = univDict["campus"] as? String else { return }
                guard let univMajor = univDict["major"] as? String else { return }
                print(univName)
                print(univMajor)
                print(" ")
            }
        } catch {
            print(error)
        }
        
    }
    
    //Search Records
    @objc func searchRecords(_ textField: UITextField) {
        self.departments.removeAll()
        if textField.text?.count != 0 {
            for department in originalDepartmentList {
                if let departmentSearch = textField.text {
                    let range = department.lowercased().range(of: departmentSearch, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {
                        self.departments.append(department)
                    }
                }
            }
        } else {
            for department in originalDepartmentList {
                departments.append(department)
            }
        }
        departmentList.reloadData()
    }
    
    //UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        departmentSearchBar.resignFirstResponder()
        return true
    }
    
    
    //UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return departments.count
        return departments.count
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = tableView.dequeueReusableCell(withIdentifier: "department")
//        if cell == nil {
//            cell = UITableViewCell(style: .default, reuseIdentifier: "department")
//        }
//        cell?.textLabel?.text = departments[indexPath.row]
//        return cell!
////    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//        cell.textLabel?.text = univMajors[indexPath.row].univ_name.capitalized
//        return cell
//    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "department")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "department")
        }
        cell?.textLabel?.text = departments[indexPath.row]
        return cell!
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let depDetVC = self.storyboard?.instantiateViewController(withIdentifier: "depSearchDetailViewController") as! depSearchDetailViewController
        depDetVC.strDepartmentName = departments[indexPath.row]
        self.navigationController?.pushViewController(depDetVC, animated: true)
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
