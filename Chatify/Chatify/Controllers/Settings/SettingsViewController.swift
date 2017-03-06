//
//  SettingsViewController.swift
//  Chatify
//
//  Created by Marcel Canhisares on 14/02/17.
//  Copyright © 2017 Azell. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var profileImgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getCurrentProfilePicture()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func editSettingsButtonTap(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    func uploadProfileImage() {
        guard let image = profileImgView.image else {
            return
        }
        FirebaseService.CurrentUser?.uploadProfilePhoto(profileImage: image)
    }
    
    func getCurrentProfilePicture() {
        if let url = FirebaseService.CurrentUser?.profileImageUrl, url.characters.count > 0  {
            profileImgView.image = FirebaseService.CurrentUser?.getProfileImage()
        }
     }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let pickerInfo = info as NSDictionary
        let img: UIImage = pickerInfo.object(forKey: UIImagePickerControllerOriginalImage) as! UIImage
        profileImgView.image = img
        
        uploadProfileImage()
        
        self.dismiss(animated: true, completion: nil)
    }


}
