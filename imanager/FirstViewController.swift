//
//  FirstViewController.swift
//  imanager
//
//  Created by minkyung on 2018. 4. 15..
//  Copyright © 2018년 minkyung. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class FirstViewController: UIViewController, UIViewControllerTransitioningDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //style of the view
        loginView.layer.cornerRadius = 6
        loginView.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        loginView.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        loginView.layer.shadowRadius = 1.7
        loginView.layer.shadowOpacity = 0.45
        
        // default FB Login button
//        let loginButton = FBSDKLoginButton()
//        loginButton.center = view.center
//        loginButton.frame = CGRect(x: 25, y: 355, width: view.frame.width - 50, height: 40)
//        loginButton.readPermissions = ["public_profile", "email"]
//        loginButton.delegate = self
//        view.addSubview(loginButton)
//            // 사실 밑의 코드 없어도 잘 작동함
//        loginButton.delegate = self as FBSDKLoginButtonDelegate
//
        
// default FB login
//    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
//        if error != nil {
//            print(error)
//        } else if result.isCancelled {
//            print("User has canceled login")
//        } else {
//            if result.grantedPermissions.contains("email") {
//                if let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"]) {
//                    graphRequest.start(completionHandler: {(connection, result, error) in
//                        if error != nil {
//                            print(error!)
//                        } else {
//                            if let userDeets = result {
//                                print(userDeets)
//                            }
//                        }
//                    })
//                }
//            }
//        }
//    }
//
        // Custom FB login button
        let customFBloginBtn = UIButton(type: .system)
        customFBloginBtn.frame = CGRect(x: 25, y: 400, width: view.frame.width - 50, height: 40)
        customFBloginBtn.setTitle("페이스북 로그인", for: .normal)
        customFBloginBtn.tintColor = UIColor.white
        customFBloginBtn.backgroundColor = UIColor(red: 255/255, green: 199/255, blue: 0/255, alpha: 1)
        customFBloginBtn.addTarget(self, action: #selector(handleCustomFBLogin), for: .touchUpInside)
        customFBloginBtn.titleLabel?.font = UIFont.init(name: "Apple SD Gothic Neo", size: 22)
        view.addSubview(customFBloginBtn)
        // Do any additional setup after loading the view.
    }

    // viewdidload에 설정되어있는 것은 바깥에서 인식이 안되는건가? 궁금스
    let customFBloginBtn = UIButton(type: .system)
    
    
    
    @objc func handleCustomFBLogin() {
        FBSDKLoginManager().logIn(withReadPermissions: [
//            "public_profile",
                                                        "email"], from: self) { (result, err) in
            if err != nil {
                //에러 메시지 뜨게
                print("Custom FB Login failed:", err!)
                return
            }
            self.showEmailAddress()
            self.performSegue(withIdentifier: "signIntoHomeVC", sender: nil)
        }
    }
    
    func showEmailAddress() {
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields":
//            "public_profile,
            "email"]).start {
            (connection, result, err) in
            if err != nil {
                print("Failed to start graph request:", err!)
                return
            }
            print(result!)
        }
    }
    
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("logged Out")
    }
    
    
    
    
    
    
    
    //여기까지 FBlogin
    
    
    
    @IBOutlet weak var loginView: UIView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var loginAdminButton: UIRoundPrimaryButton!
    @IBAction func loginAdminButtonPressed(_ sender: Any) {
        if (loginView.isHidden == true) {
            loginView.isHidden = false
        } else {
            loginView.isHidden = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.loginView.isHidden = true
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
