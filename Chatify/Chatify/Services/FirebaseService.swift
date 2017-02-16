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
                FirebaseService.GetUser(uid: user!.uid, completion: { user in
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
            
            FirebaseService.AddUser(username: username, email: email)
            
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
    
    static func GetUser(uid:String, completion: @escaping (_ user: User) -> Void) {
        FirebaseService.DatabaseInstance.child("users").queryOrdered(byChild: "uid").queryEqual(toValue: uid).observe(.childAdded, with: { snapshot in
            print(snapshot)
            
            if let result = snapshot.value as? [String: AnyObject] {
                
                let email = result["email"] as! String
                let uid = result["uid"] as! String
                let username = result["username"] as! String
                let profileImageUrl = result["profileImageUrl"] as! String
                
                completion(User(userName: username, email: email, uid: uid, profileImageUrl: profileImageUrl))
            }
        })
        
    }
    
    static func AddUser(username: String, email: String) {
        let uid = FIRAuth.auth()?.currentUser?.uid
        let post = ["uid": uid,
                    "username": username,
                    "email": email,
                    "profileImageUrl": ""]
        
        FirebaseService.DatabaseInstance.child("users").child(uid!).setValue(post)
    }
    

}
