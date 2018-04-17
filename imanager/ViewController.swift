//
//  ViewController.swift
//  imanager
//
//  Created by minkyung on 2018. 4. 5..
//  Copyright © 2018년 minkyung. All rights reserved.
//

import UIKit
import FirebaseAuth


class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    func displayAlert(title:String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
//        if emailTextField.text == "" || passwordTextField.text == "" {
//            displayAlert(title: "정보를 기입해 주세요.", message: "이메일과 비밀번호를 모두 입력하셔야 합니다.")
//        } else {
            if let email = emailTextField.text {
                if let password = passwordTextField.text {
                    // LOG IN
                    Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                        if error == nil {
//                            self.displayAlert(title:"로그인 되었습니다", message: "")
//                            print("로그인 되었습니다.")
//
                            
                            var loginAlert = UIAlertController(title: "로그인 되었습니다.", message: "", preferredStyle: UIAlertControllerStyle.alert)
                            
                            let loginAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default ) { action in
                                self.dismiss(animated: true, completion: nil)}
                            
                            loginAlert.addAction(loginAction)
                            self.present(loginAlert, animated: true, completion: nil)
                            
                        } else {
                            self.displayAlert(title: "Error", message: error!.localizedDescription)
                        }
                    })
                }}
        }

    override func viewDidLoad() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    // 만약 회원가입 하러가기를 코드로 보여주려면 밑과 같이 하면 됨
    //let signUpViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
    //self.present(SignupViewController, animated: true)
    
    
}













