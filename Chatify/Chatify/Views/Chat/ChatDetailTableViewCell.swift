//
//  ChatTableViewCell.swift
//  Chatify
//
//  Created by Marcel Canhisares on 15/02/17.
//  Copyright © 2017 Azell. All rights reserved.
//

import UIKit

class ChatDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var messageText: RoundedTextView!
    @IBOutlet weak var usernameText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func display(message: Message) {
        messageText.text = message.text
        usernameText.text = message.username
        
        if message.username == FirebaseService.CurrentUser?.userName {
            usernameText.textAlignment = .right
        } else {
            usernameText.textAlignment = .left
        }
    }

}
