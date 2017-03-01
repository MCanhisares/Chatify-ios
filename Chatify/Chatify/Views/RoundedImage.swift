//
//  RoundedImage.swift
//  Chatify
//
//  Created by Marcel Canhisares on 16/02/17.
//  Copyright © 2017 Azell. All rights reserved.
//

import UIKit

class RoundedImage: UIImageView {

    override var image: UIImage?{
        didSet {
            if image != nil{
                addRoundedEffect()
            } else {
                //clean your filter or added layer (remove your effects over the view)
            }
        }
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        addRoundedEffect()
        // Drawing code
    }

    func addRoundedEffect() {
        self.layer.borderWidth=1.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 13
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
    }

}
