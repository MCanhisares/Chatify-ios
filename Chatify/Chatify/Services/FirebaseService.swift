//
//  FirebaseService.swift
//  Chatify
//
//  Created by Marcel Canhisares on 14/02/17.
//  Copyright © 2017 Azell. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class FirebaseService: NSObject {
    
    static let DatabaseInstance = FIRDatabase.database().reference()
    static var CurrentUser: User? = nil
    
    static func Login(email: String, password: String, completion: @escaping (_ success: Bool) -> Void) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { user, error in
            if let err = error {
                print(err.localizedDescription)
                completion(false)
            } else {
                print(user)
                ProfileService.GetUser(uid: user!.uid, completion: { user in
                    FirebaseService.CurrentUser = user
                    
                    completion(true)
                })
            }
        })
    }
    
    static func CreateAccount(email: String, password: String, username: String, completion: @escaping (_ success: Bool) -> Void) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print(error?.localizedDescription)
                completion(false)
                return
            }
            
            ProfileService.AddUser(username: username, email: email)
            
            FirebaseService.Login(email: email, password: password, completion: { (success) in
                if success {
                    print("Login successful")
                } else {
                    print("Login unsuccessful")
                }
                
                completion(success)
            })
        })
    }        

}
