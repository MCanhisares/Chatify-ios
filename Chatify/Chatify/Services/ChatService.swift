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
    static var Messages = [Message]()
    
    static func FillMessages(uid: String, toId: String, completion: @escaping () -> Void) {        
        
        FirebaseService.DatabaseInstance.child("messages").observe(.childAdded, with: { snapshot in
            print(snapshot)
            if let result = snapshot.value as? [String: AnyObject] {
                let toIdResponse = result["toId"] as! String
                let fromIdResponse = result["uid"] as! String
                if (toIdResponse == toId && fromIdResponse == uid) || (toIdResponse == uid && fromIdResponse == toId) {
                    
                    let message = Message(username: result["username"] as! String, text: result["text"] as! String, toId: result["toId"] as! String)
                    
                    ChatService.Messages.append(message)
                }
            }
            completion()
        })
    }
    
    static func AddMessage(text: String, toId: String) {
        let uid = FirebaseService.CurrentUser!.uid
        let username = FirebaseService.CurrentUser!.userName
        
        let post = ["uid": uid,
                    "username" : username,
                    "text" : text,
                    "toId" : toId]
        
        FirebaseService.DatabaseInstance.child("messages").childByAutoId().setValue(post)
    }
}