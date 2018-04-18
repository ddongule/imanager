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
        
        // log in을 해야지만 homeViewController 으로 가기
        // sign up 한 유저인지 아닌지 본다.
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
//            self.performSegue(withIdentifier: "signIntoHomeVC", sender: nil)
//            print(user?.email) //이거 하면 user가 회원가입 햇는지 안햇는지 로그로 볼 수 있음
        }

        // 정보를 제대로 입력하지 않았을 때 Alert
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
                            
                            let loginAlert = UIAlertController(title: "로그인 되었습니다.", message: "", preferredStyle: UIAlertControllerStyle.alert)
                            let loginAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default ) { action in
//                                self.dismiss(animated: true, completion: nil)
                                // 밑의 코드를 작성해야 home view controller로 이동한다.
                                self.performSegue(withIdentifier: "signIntoHomeVC", sender: nil)
                            }
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
        handleTextField()
    }

    
    
    
    
    //로그인 양식(이메일, 비밀번호) 다 쓰기 전까지 로그인 버튼 비활성화
    func handleTextField() {
        emailTextField.addTarget(self, action: #selector(ViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
        passwordTextField.addTarget(self, action: #selector(ViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
    }
//
//    @objc func textFieldDidChange() {
//        guard let email = emailTextField.text, !email.isEmpty,
//            let password = passwordTextField.text, !password.isEmpty
//
//            else {
//                loginButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
//                loginButton.isEnabled = false
//                return
//        }
//        loginButton.setTitleColor(UIColor.white, for: UIControlState.normal)
//        loginButton.isEnabled = true
//    }
//
    @objc func textFieldDidChange() {
        if (emailTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! {
            loginButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
            loginButton.isEnabled = false
        } else {
            loginButton.setTitleColor(UIColor.white, for: UIControlState.normal)
            loginButton.isEnabled = true
        }
        
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













