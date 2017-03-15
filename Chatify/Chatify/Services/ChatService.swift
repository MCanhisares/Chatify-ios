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
    
    static let sharedInstance = ChatService()
    
    var messages = [Message]()
    
    func fillMessages(uid: String, toId: String, completion: @escaping () -> Void) {
        
        FirebaseService.sharedInstance.databaseInstance.child("messages").observe(.childAdded, with: { snapshot in
            print(snapshot)
            if let result = snapshot.value as? [String: AnyObject] {
                let toIdResponse = result["toId"] as! String
                let fromIdResponse = result["uid"] as! String
                if (toIdResponse == toId && fromIdResponse == uid) || (toIdResponse == uid && fromIdResponse == toId) {
                    
                    let message = Message(username: result["username"] as! String, text: result["text"] as! String, toId: result["toId"] as! String)
                    
                    self.messages.append(message)
                }
            }
            completion()
        })
    }
    
    func addMessage(text: String, toId: String) {
        let uid = FirebaseService.sharedInstance.currentUser!.uid
        let username = FirebaseService.sharedInstance.currentUser!.userName
        
        let post = ["uid": uid,
                    "username" : username,
                    "text" : text,
                    "toId" : toId]
        
        FirebaseService.sharedInstance.databaseInstance.child("messages").childByAutoId().setValue(post)
    }
}
