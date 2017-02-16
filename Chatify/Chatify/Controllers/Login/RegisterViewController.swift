//
//  RegisterViewController.swift
//  Chatify
//
//  Created by Marcel Canhisares on 14/02/17.
//  Copyright © 2017 Azell. All rights reserved.
//

import UIKit

class RegisterViewController: AdjustableKeyboardViewController, AdjustableKeyboardProtocol {

    var originalBottomHeight: CGFloat = 150.0
    
    // MARK: Outlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTextField.becomeFirstResponder()
        
        adjustProtocol = self
    }
    
    @IBAction func btnRegisterTouchUpInside(_ sender: Any) {
        
        guard let email = emailTextField.text, email.characters.count > 0 else {
            return 
        }
        
        guard let password = passwordTextField.text, password.characters.count > 0 else {
            return
        }

        guard let username = usernameTextField.text, username.characters.count > 0 else {
            return
        }
        
        FirebaseService.CreateAccount(email: email, password: password, username: username) { (success) in
            if success {
                self.performSegue(withIdentifier: kRegisterToChatList, sender: sender)
            }
        }
        
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
