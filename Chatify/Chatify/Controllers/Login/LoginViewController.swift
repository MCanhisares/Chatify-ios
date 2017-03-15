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

    // MARK: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var originalBottomHeight: CGFloat = (UIScreen.main.bounds.height / 2) - 50.0
    
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
        
        FirebaseService.sharedInstance.login(email: email, password: password, completion: { success in
            if success {
                self.performSegue(withIdentifier: kLoginToChatList, sender: sender)
            } else {
                //TODO HANDLE ERRORS
            }
        })
    }
}
