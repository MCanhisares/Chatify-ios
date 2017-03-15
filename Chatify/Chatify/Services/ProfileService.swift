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
    
    static let sharedInstance = ProfileService()
    
    var users = [User]()
    
    func getUser(uid: String) -> User? {
        if let i = users.index(where: {$0.uid == uid}) {
            return users[i]
        }
        return nil
    }
    
    func fillUsers(completion: @escaping () -> Void) {
        self.users = []
        FirebaseService.sharedInstance.databaseInstance.child("users").observe(.childAdded, with: { snapshot in
            print(snapshot)
            if let result = snapshot.value as? [String: AnyObject] {
                if let uid = result["uid"] as? String, uid != FirebaseService.sharedInstance.currentUserUid{
                    let username = result["username"] as! String
                    let email = result["email"] as! String
                    let profileImageUrl = result["profileImageUrl"] as! String
                    
                    self.users.append(User(userName: username, email: email, uid: uid, profileImageUrl: profileImageUrl))
                }
            }
            completion()
        })
    }
    
    static func GetUser(uid:String, completion: @escaping (_ user: User) -> Void) {
        FirebaseService.sharedInstance.databaseInstance.child("users").queryOrdered(byChild: "uid").queryEqual(toValue: uid).observe(.childAdded, with: { snapshot in
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
        
        FirebaseService.sharedInstance.databaseInstance.child("users").child(uid!).setValue(post)
    }
    
    
    static func uploadPhoto(profileImage:UIImage, completion: @escaping (_ imageUrl: String) -> Void) {
        let profileImageRef = FIRStorage.storage().reference().child("profileImages").child("\(NSUUID().uuidString).jpg")
        
        if let imageData = UIImageJPEGRepresentation(profileImage, 0.25) {
            
            profileImageRef.put(imageData, metadata: nil) {
                metadata, error in
                if error != nil {
                    print(error)
                } else {
                    print(metadata)
                    
                    if let downloadUrl = metadata?.downloadURL()?.absoluteString {
                        FirebaseService.sharedInstance.databaseInstance.child("users")
                            .child(FirebaseService.sharedInstance.currentUser!.uid)
                            .updateChildValues(["profileImageUrl" : downloadUrl])
                        
                        completion(downloadUrl)
                    }
                }
            }
        }
    }
    
}
