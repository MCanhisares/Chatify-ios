//
//  RoundedTextField.swift
//  Chatify
//
//  Created by Marcel Canhisares on 16/02/17.
//  Copyright © 2017 Azell. All rights reserved.
//

import UIKit

class RoundedTextView: UITextView {

   
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 10
    }
	
}
