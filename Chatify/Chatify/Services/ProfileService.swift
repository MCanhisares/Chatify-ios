//
//  ProfileService.swift
//  Chatify
//
//  Created by Marcel Canhisares on 15/02/17.
//  Copyright © 2017 Azell. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ProfileService: NSObject {
    static let Uid = FIRAuth.auth()?.currentUser?.uid
    
    static var Users = [User]()
    
    static func GetCurrentUser(uid: String) -> User? {
        if let i = Users.index(where: {$0.uid == uid}) {
            return Users[i]
        }
        return nil
    }
    
    static func FillUsers(completion: @escaping () -> Void) {
        ProfileService.Users = []
        FirebaseService.DatabaseInstance.child("users").observe(.childAdded, with: { snapshot in
            print(snapshot)
            if let result = snapshot.value as? [String: AnyObject] {
                let uid = result["uid"] as! String
                let username = result["username"] as! String
                let email = result["email"] as! String
                let profileImageUrl = result["profileImageUrl"] as! String
                
                ProfileService.Users.append(User(userName: username, email: email, uid: uid, profileImageUrl: profileImageUrl))
            }
            completion()
        })
    }
}
