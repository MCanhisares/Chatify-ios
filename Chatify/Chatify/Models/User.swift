//
//  User.swift
//  Chatify
//
//  Created by Marcel Canhisares on 15/02/17.
//  Copyright © 2017 Azell. All rights reserved.
//

import UIKit

class User: NSObject {

    var userName: String
    var email: String
    var uid: String
    var profileImageUrl: String
    
    init(userName: String, email: String, uid: String, profileImageUrl: String) {
        self.userName = userName
        self.email = email
        self.uid = uid
        self.profileImageUrl = profileImageUrl
        super.init()
    }
    
    func getProfileImage() -> UIImage {
        if let url = NSURL(string: profileImageUrl) {
            if let data = NSData(contentsOf: url as URL) {
                return UIImage(data: data as Data)!
            }
        }
        return UIImage(named: "user")!
    }
    
    func uploadProfilePhoto(profileImage: UIImage) {
        ProfileService.uploadPhoto(profileImage: profileImage) { profileImageUrl in
            self.profileImageUrl = profileImageUrl
        }
    }
}
