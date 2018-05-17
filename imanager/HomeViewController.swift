//
//  HomeViewController.swift
//  imanager
//
//  Created by minkyung on 2018. 4. 17..
//  Copyright © 2018년 minkyung. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit

class HomeViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func signOutButtonTapped(_ sender: Any) {
        //로그아웃 기능 일단 추가했는데 로그아웃 된지 어떻게 확인할까?
        do {
            try! Auth.auth().signOut()

            if Auth.auth().currentUser == nil {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! FirstViewController
                present(vc, animated: true, completion: nil)
//                displayAlert(title:"로그아웃 되었습니다", message: "")
            }
        } catch let error as NSError {
            displayAlert(title: "오류", message: error.localizedDescription)
            
        }
    }

    
    @IBAction func managingButtonTapped(_ sender: Any) {
        
    }
    
    //Alert 코드임
    func displayAlert(title:String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
//    override func viewDidAppear(_ animated: Bool) {
//        let isUserLoggedIn =
//        if(!isUserLoggedIn) {
//            self.performSegue(withIdentifier: "ViewController", sender: self)
//        }
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
