//
//  clubSearchViewController.swift
//  imanager
//
//  Created by minkyung on 2018. 4. 19..
//  Copyright © 2018년 minkyung. All rights reserved.
//

import UIKit

class clubSearchViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    

    @IBOutlet weak var clubSearchBar: UITextField!
    @IBOutlet weak var clubList: UITableView!
    
    var originalClubList:[String] = Array()
    
    var clubs:[String] = ["라켓단", "랑데부", "리베로", "미식축구부", "자이언츠", "LOVE 4T", "네비게이토", "CAM","CBA","CCC","CUSCM","SCA","가람터","누리울림","멜로스","블루드래곤","피카통","MuSE","RUBATO","라이너스","산악부","스키부","스킨스쿠버","요트부","하늘지기","날파람","쏜살","의혈검","중앙유도회","피트니스부","해동검도부","만화두레","문학동인회","미술시간","반영","사진연구회","중앙서예연구회","햇귀","사랑터","손짓사랑","푸름회","MIRA","RCY","레인보우피쉬","비꼼","지구인","휴머니즘","새날지기","영죽무대","청룡합창단","타박네","Da C-side", "댄스포즈", "M&M","민탈","소래얼","한백사위","가톨릭학생회","불교학생회","미생마","유스호스텔","BOCA","KUSA","UNSA","셈틀","CECC", "CECOM","CIEN","COMP","COSMOS","HAM","TRC","마인드피플","미제연","시가스펠리스","싸이클리","애니타임","프리스타일","화인법학회","CISSA 국제학학회","C-mash","CUDS","IVF","Journey","KOREA CLUB", "SEN"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title =  "동아리 찾기"
        // Do any additional setup after loading the view.
        for club in clubs {
            originalClubList.append(club)
        }
        clubList.delegate = self
        clubList.dataSource = self
        clubSearchBar.delegate = self
        clubSearchBar.addTarget(self, action: #selector(searchRecords(_ :)), for: .editingChanged)
    }

    @objc func searchRecords(_ textField: UITextField) {
        self.clubs.removeAll()
        if textField.text?.count != 0 {
            for club in originalClubList {
                if let clubSearch = textField.text {
                    let range = club.lowercased().range(of: clubSearch, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {
                        self.clubs.append(club)
                    }
                }
            }
        } else {
            for club in originalClubList {
                clubs.append(club)
            }
        }
        clubList.reloadData()
    }

    //UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        clubSearchBar.resignFirstResponder()
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clubs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "club")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "club")
        }
        cell?.textLabel?.text = clubs[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let clubDetVC = self.storyboard?.instantiateViewController(withIdentifier: "clubSearchDetailViewController") as! clubSearchDetailViewController
        clubDetVC.strClubName = clubs[indexPath.row]
        self.navigationController?.pushViewController(clubDetVC, animated: true)
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
