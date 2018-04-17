//
//  SignupViewController.swift
//  imanager
//
//  Created by minkyung on 2018. 4. 5..
//  Copyright © 2018년 minkyung. All rights reserved.
//

import UIKit
import FirebaseAuth
import MessageUI


class SignupViewController: UIViewController, UITextFieldDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBAction func signUpTapped(_ sender: Any) {
        if (emailTextField.text?.isEmpty)! ||
            (passwordTextField.text?.isEmpty)! ||
            (nameTextField.text?.isEmpty)! ||
            (passwordConfirmTextField.text?.isEmpty)!
        { displayAlert(title: "정보를 기입해 주세요.", message: "이메일과 비밀번호를 모두 입력하셔야 합니다.")
        } else if ((passwordTextField.text?.elementsEqual(passwordConfirmTextField.text!))! != true)
        {
            displayAlert(title: "비밀번호를 확인해주세요.", message: "두 비밀번호가 다릅니다.")
        } else {
            if let email = emailTextField.text {
                if let password = passwordTextField.text {

                    // SIGN UP
                    Auth.auth().createUser(withEmail: email, password: password, completion: {(user, error) in
                        if error != nil {
                            self.displayAlert(title: "Error", message: error!.localizedDescription)
                            
                        } else {
                            var myAlert = UIAlertController(title: "회원가입 되었습니다.", message: "", preferredStyle: UIAlertControllerStyle.alert)
                            
                            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default ) { action in
                                self.dismiss(animated: true, completion: nil)}
                            
                            // ok 말고 cancel도 하려면 이렇게 하면 된다. 근데 cancel 해도 회원가입 됨 ㅋ
                            
//                            let cancel = UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel, handler: nil)
//                            myAlert.addAction(cancel)
                            
                            myAlert.addAction(okAction)
                            self.present(myAlert, animated: true, completion: nil)

                            
//                            print("회원가입 되었습니다.")
//                            self.displayAlert(title: "회원가입 되었습니다.", message: "")
//                            print("회원가입 되었습니다.")
                        }
                    })
//                    return self.dismiss(animated: true, completion: nil)
                    
                }}
            }
        
        
    }
    
    func displayAlert(title:String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    // 이메일 보내기

    
    

    
    override func viewDidLoad() {
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordConfirmTextField.delegate = self
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            passwordConfirmTextField.becomeFirstResponder()
        } else if textField == passwordConfirmTextField {
            textField.resignFirstResponder()
        }; return true
    }
}
