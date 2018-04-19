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
    
    var clubs:[String] = ["중앙동아리"]
    
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
