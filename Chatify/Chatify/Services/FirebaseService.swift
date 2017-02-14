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
    
    static let databaseInstance = FIRDatabase.database().reference()
    static var currentUserId: String = ""
    static var currentUser: FIRUser? = nil
    
    static func Login(email: String, password: String, completion: @escaping (_ success: Bool) -> Void) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { user, error in
            if let err = error {
                print(err.localizedDescription)
                completion(false)
            } else {
                self.currentUser = user
                self.currentUserId = (user?.uid)!
                completion(true)
            }
        })
    }
    

}
