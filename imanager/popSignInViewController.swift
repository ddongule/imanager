//
//  popSignInViewController.swift
//  imanager
//
//  Created by minkyung on 2018. 4. 6..
//  Copyright © 2018년 minkyung. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class popSignInViewController: UIViewController, FBSDKLoginButtonDelegate, UIViewControllerTransitioningDelegate {
    
    //    var fbloginButton = FBSDKLoginButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Default Facebook Login button
        // Do any additional setup after loading the view.
        let loginButton = FBSDKLoginButton()
        loginButton.center = view.center
        loginButton.frame = CGRect(x: 25, y: 355, width: view.frame.width - 50, height: 40)
        loginButton.readPermissions = ["public_profile", "email"]
        loginButton.delegate = self
        view.addSubview(loginButton)
        
        //        //Custom Facebook Login Button
        //        let customFBLoginButton = UIButton(type: .custom)
        //        customFBLoginButton.frame = CGRect(x: 15, y: 60, width: view.frame.width - 30, height: 30)
        //        customFBLoginButton.setTitle("Login with Facebook", for: .normal)
        //        customFBLoginButton.tintColor = UIColor.white
        //        customFBLoginButton.backgroundColor = UIColor.blue
        //
        //        view.addSubview(customFBLoginButton)
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
        } else if result.isCancelled {
            print("User has canceled login")
        } else {
            if result.grantedPermissions.contains("email") {
                if let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"]) {
                    graphRequest.start(completionHandler: {(connection, result, error) in
                        if error != nil {
                            print(error!)
                        } else {
                            if let userDeets = result {
                                print(userDeets)
                            }
                        }
                    })
                }
            }
        }
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("logged Out")
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


