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
    
    var departments:[String] = ["총 학생회","인문대학 학생회","사회과학대학 학생회","경영경제대학 학생회", "사범대학 학생회", "자연과학대학 학생회", "공과대학 학생회", "창의ICT 공과대학 학생회", "의과대학 학생회", "간호대학 학생회","생명공학대학 학생회", "예술대학 학생회", "체육대학 학생회", "국어국문학과", "영어영문학과", "유럽문화학부", "아시아문화학부", "철학과", "역사학과", "정치국제학과", "공공인재학부", "심리학과", "문헌정보학과", "사회복지학부", "미디어커뮤니케이션학부", "사회학과", "도시계획부동산학과", "경영학부(경영학)", "경영학부(글로벌경영)", "경제학부", "응용통계학과", "광고홍보학과", "국제물류학과", "산업보안학과", "지식경영학부", "교육학과", "유아교육과", "영어교육과", "체육교육과", "물리학과", "화학과", "생명과학과", "수학과", "사회기반시스템학부", "화학신소재공학부", "기계공학부", "에너지시스템공학부", "건축학부(4년제)","건축학부(5년제)","전기전자공학부", "융합공학부", "소프트웨어학부", "의학부", "생명자원공학부", "식품공학부", "시스템생명공학과", "공연영상창작학부", "미술학부", "디자인학부", "전통예술학부","음악학부", "글로벌예술학부", "연극(연출)", "연극(연기)", "연극(뮤지컬)", "영화", "공간연출", "문예창작", "사진", "무용", "한국화", "서양화", "조소", "공예", "산업디자인", "시각디자인", "실내환경디자인", "패션디자인", "음악예술", "연회예술", "작곡", "성악", "피아노", "관현악"]
    
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
//                print(univName)
//                print(univMajor)
//                print(" ")
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
