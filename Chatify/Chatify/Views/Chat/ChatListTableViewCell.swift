//
//  ChatListTableViewCell.swift
//  Chatify
//
//  Created by Marcel Canhisares on 16/02/17.
//  Copyright © 2017 Azell. All rights reserved.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: RoundedImage!
    @IBOutlet weak var profileName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
