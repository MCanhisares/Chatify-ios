//
//  ChatService.swift
//  Chatify
//
//  Created by Marcel Canhisares on 14/02/17.
//  Copyright © 2017 Azell. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

class ChatService: NSObject {
    static var posts = [Post]()
    
    static func fillPosts(uid: String, toId: String, completion: @escaping(_ result:String) -> Void) {
        let allPosts = FirebaseService.databaseInstance.child("Posts")
        print(allPosts)
        
        let post = allPosts.queryOrdered(byChild: "uid").queryEqual(toValue: FirebaseService.currentUser?.uid).observe(.childAdded, with: { snapshot in
            print(snapshot)
        })
        
        let _ = allPosts.queryOrdered(byChild: "uid").queryEqual(toValue: FirebaseService.currentUser?.uid).observe(.childAdded, with: { snapshot in
            print(snapshot)
            if let result = snapshot.value as? [String: AnyObject] {
                let toIdResponse = result["toId"] as! String
                if toIdResponse == toId {
                    let post = Post(username: result["username"] as! String, text: result["text"] as! String, toId: result["toId"] as! String)
                    ChatService.posts.append(post)
                }
            }
        })
    }
}
