//
//  CollegeSearchDetailViewController.swift
//  imanager
//
//  Created by minkyung on 2018. 4. 12..
//  Copyright © 2018년 minkyung. All rights reserved.
//

import UIKit

class CollegeSearchDetailViewController: UIViewController {
    //왜 적용이 안될까?
    @IBOutlet weak var departmentButton: UIRoundPrimaryButton!
    @IBOutlet weak var clubButton: UIRoundPrimaryButton!
    
    @IBOutlet weak var lblDetail: UILabel!
    var strCollegeName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblDetail.text = strCollegeName + "의 학생회 및 동아리"
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
