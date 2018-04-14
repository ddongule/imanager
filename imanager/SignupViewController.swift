//
//  SignupViewController.swift
//  imanager
//
//  Created by minkyung on 2018. 4. 5..
//  Copyright © 2018년 minkyung. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignupViewController: UIViewController {

    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBAction func signUpTapped(_ sender: Any) {
        if emailTextField.text == "" || passwordTextField.text == "" {
            displayAlert(title: "정보를 기입해 주세요.", message: "이메일과 비밀번호를 모두 입력하셔야 합니다.")
        } else {
            if let email = emailTextField.text {
                if let password = passwordTextField.text {
                    //                    if signUpMode {
                    // SIGN UP
                    Auth.auth().createUser(withEmail: email, password: password, completion: {(user, error) in
                        if error != nil {
                            self.displayAlert(title: "Error", message: error!.localizedDescription)
                        } else {
                            self.displayAlert(title: "회원가입 되었습니다.", message: "")
                            print("회원가입 되었습니다.")
                        }
                    })
                }}
        }}
    
    
    func displayAlert(title:String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
