//
//  LoginViewController.swift
//  Chatify
//
//  Created by Marcel Canhisares on 08/02/17.
//  Copyright © 2017 Azell. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: AdjustableKeyboardViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailTextField.becomeFirstResponder()
    }
        
    @IBAction func loginBtnTouchUpInside(_ sender: Any) {
//        if let email = emailTextField.text, let password = passwordTextField.text, email.characters.count > 0, password.characters.count > 0 {
        let email = "test1@gmail.com"
        let password = "password"
            FirebaseService.Login(email: email, password: password, completion: { success in
                if success {
                    self.performSegue(withIdentifier: kLoginToChatList, sender: sender)
                }
            })
//        }
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
