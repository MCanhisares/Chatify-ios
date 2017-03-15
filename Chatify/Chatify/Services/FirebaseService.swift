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
    
    static let sharedInstance = FirebaseService()
    
    let databaseInstance = FIRDatabase.database().reference()
    var currentUser: User? = nil
    var currentUserUid: String?
    
    func login(email: String, password: String, completion: @escaping (_ success: Bool) -> Void) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { user, error in
            if let err = error {
                print(err.localizedDescription)
                completion(false)
            } else {
                print(user)
                self.currentUserUid = user?.uid
                ProfileService.GetUser(uid: user!.uid, completion: { user in
                    self.currentUser = user
                    
                    completion(true)
                })
            }
        })
    }
    
    func createAccount(email: String, password: String, username: String, completion: @escaping (_ success: Bool) -> Void) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print(error?.localizedDescription)
                completion(false)
                return
            }
            
            self.currentUserUid = user?.uid
            
            ProfileService.AddUser(username: username, email: email)
            
            self.login(email: email, password: password, completion: { (success) in
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
