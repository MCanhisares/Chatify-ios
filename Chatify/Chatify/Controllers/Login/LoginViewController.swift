//
//  LoginViewController.swift
//  Chatify
//
//  Created by Marcel Canhisares on 08/02/17.
//  Copyright © 2017 Azell. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: AdjustableKeyboardViewController, AdjustableKeyboardProtocol {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var originalBottomHeight: CGFloat = 150.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.becomeFirstResponder()
        
        adjustProtocol = self
    }
        
    @IBAction func loginBtnTouchUpInside(_ sender: Any) {
        
        guard let email = emailTextField.text, emailTextField.text!.characters.count > 0 else {
            return
        }
        
        guard let password = passwordTextField.text, passwordTextField.text!.characters.count > 0 else {
            return
        }
        
        FirebaseService.Login(email: email, password: password, completion: { success in
            if success {
                self.performSegue(withIdentifier: kLoginToChatList, sender: sender)
            } else {
                
            }
        })
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
