//
//  MyProfileVC.swift
//  Social-Media-Project
//
//  Created by Zaghloul on 14/09/2022.
//

import UIKit

class MyProfileVC: UIViewController {

    //MARK: - OUTLET
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var fristNameuser: UITextField!
    @IBOutlet weak var phoneUser: UITextField!
    @IBOutlet weak var imageUrlUser: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI(){
        userImageView.makeImageCircler()
        if let user = UserManager.logedInUser {
            if let image = user.picture {
                userImageView.setImageFromStringUrl(stringUrl: image)
            }
            userNameLbl.text = user.firstName + " " + user.lastName
            fristNameuser.text = user.firstName
            imageUrlUser.text = user.picture
        }
    }
    
    
    @IBAction func updataUserInfo(_ sender: UIButton) {
        if let userUpdat = UserManager.logedInUser {
            UserAPI.updataUserInfo(userId: userUpdat.id, firstName: fristNameuser.text!, phone: phoneUser.text!, image: imageUrlUser.text!) { responseUser, message in
                if let image = responseUser.picture {
                    self.userImageView.setImageFromStringUrl(stringUrl: image)
                }
                self.userNameLbl.text = responseUser.firstName + " " + responseUser.lastName
                
            }
        }
    }
    
}
