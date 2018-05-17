//
//  SignupViewController.swift
//  imanager
//
//  Created by minkyung on 2018. 4. 5..
//  Copyright © 2018년 minkyung. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import MessageUI
import FirebaseDatabase

class SignupViewController: UIViewController, UITextFieldDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var sendMailButton: UIButton!
    @IBAction func sendMail(_ sender: Any) {
        
        //Why email 인증이랑 회원가입이랑 따로 만들었지??
    }
    
    //    var ref: DatabaseReference!
    var ref = Database.database().reference()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    var activeTextfield : UITextField!
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var signUpButton: UIButton!   //버튼을 why? Outlet으로 만들었지?
    @IBAction func signUpTapped(_ sender: Any) {
        if (emailTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! || (nameTextField.text?.isEmpty)! || (passwordConfirmTextField.text?.isEmpty)!
        { displayAlert(title: "정보를 기입해 주세요.", message: "이메일과 비밀번호를 모두 입력하셔야 합니다.")
        } else if ((passwordTextField.text?.elementsEqual(passwordConfirmTextField.text!))! != true)
        {
            displayAlert(title: "비밀번호를 확인해주세요.", message: "두 비밀번호가 다릅니다.")
        } else {
            if let email = emailTextField.text {
                if let password = passwordTextField.text {
                    
                    // SIGN UP
                    Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                        if error != nil {
                            let signuperrorAlert = UIAlertController(title: "Signup error", message: "\(error?.localizedDescription) Please try again later", preferredStyle: .alert)
                            self.present(signuperrorAlert, animated: true, completion: nil)
                            return
                        }
                        self.sendEmail()
                        self.dismiss(animated: true, completion: nil)
                    })
                    
//                    Auth.auth().createUser(withEmail: email, password: password, completion: {(user, error) in
//                        if user != nil
//                        {
//                           print("SUCCESS")
//                        }
//                        else
//                        {
//                            if let myError = error?.localizedDescription
//                            {
//                                print(myError)
//                            }
//                            else
//                            {
//                                print("ERROR")
//                            }
//                        }
//                    })
//                    Auth.auth().createUser(withEmail: email, password: password, completion: {(user, error) in
//                        if error != nil {
//                            self.displayAlert(title: "Error", message: error!.localizedDescription)
//
//                        } else {
//                            let myAlert = UIAlertController(title: "회원가입 되었습니다.", message: "", preferredStyle: UIAlertControllerStyle.alert)
//                            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default ) { action in
//                                self.dismiss(animated: true, completion: nil)}
//
//                            // ok 말고 cancel도 하려면 이렇게 하면 된다. 근데 cancel 해도 회원가입 됨 ㅋ 이걸 해결할 수 잇으면 좋으련만
//                            //   let cancel = UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel, handler: nil)
//                            //   myAlert.addAction(cancel)
//
//                            myAlert.addAction(okAction)
//                            self.present(myAlert, animated: true, completion: nil)
//
//                            // print("회원가입 되었습니다.")
//                            // self.displayAlert(title: "회원가입 되었습니다.", message: "")
//                            // print("회원가입 되었습니다.")
//                        }
//                    })
                }}
        }
    }
    
    func displayAlert(title:String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    // 이메일 보내기 - 아직 못함 -> 5/11 장준혁 시도: 성공
    func sendEmail() {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print("Error: \(String(describing:error!.localizedDescription))")
                return
            }
            Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                if error != nil {
                    let emailNOTSentAlert = UIAlertController(title: "Email Verification", message: "Verification email failed to send:\(error?.localizedDescription)", preferredStyle: .alert); emailNOTSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil)); self.present(emailNOTSentAlert, animated: true, completion: nil)
                }else{
                    let emailSentAlert = UIAlertController(title: "Email Verification", message: "Verification email has been sent. Please tap on the link in the email to verify your account before you can use the features in the app", preferredStyle: .alert)
                    emailSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(emailSentAlert, animated: true, completion: {
                        self.dismiss(animated: true, completion: nil)
                    })
                }
                do {
                    try Auth.auth().signOut()
                } catch {
                    //ERROR HANDLING
                }
            })
        }

    }
    
    
    override func viewDidLoad() {
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordConfirmTextField.delegate = self
        super.viewDidLoad()
        // textfield 디자인
//        emailTextField.backgroundColor =
//        emailTextField.tintColor =
//        emailTextField.textColor =
//        emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor(white:1.0, alpha: 0.6)])
        
        
        // 키보드가 text field 가리는 것 해결
        let center: NotificationCenter = NotificationCenter.default;
        center.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        center.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardDidShow(notification: Notification) {
        let info: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let keyboardY = self.view.frame.size.height - keyboardSize.height
        let editingTextFieldY: CGFloat! = self.activeTextfield?.frame.origin.y
        
        if self.view.frame.origin.y >= 0 {
            //Checking if the textfield is really hidden behind the keyboard
            if editingTextFieldY > keyboardY - 80 {
                UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                    self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y - (editingTextFieldY! - (keyboardY - 80)), width: self.view.bounds.width, height: self.view.bounds.height)
                    }, completion: nil
            )}
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)}, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextfield = textField
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    // 여기까지가 키보드
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//
//    }
    
    // 다 치면 키보드 내려가기
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

