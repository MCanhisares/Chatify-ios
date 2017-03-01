//
//  RoundCornerButton.swift
//  Chatify
//
//  Created by Marcel Canhisares on 08/02/17.
//  Copyright © 2017 Azell. All rights reserved.
//

import UIKit

class RoundCornerButton: UIButton {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
    }        

}
