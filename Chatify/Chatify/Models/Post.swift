//
//  Post.swift
//  Chatify
//
//  Created by Marcel Canhisares on 14/02/17.
//  Copyright © 2017 Azell. All rights reserved.
//

import UIKit

class Post: NSObject {
    var username: String
    var text: String
    var toId: String
    
    init(username: String, text: String, toId: String) {
        self.username = username
        self.text = text
        self.toId = toId
    }
}
