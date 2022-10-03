//
//  ProfileUser.swift
//  Social-Media-Project
//
//  Created by Zaghloul on 08/09/2022.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProfileUser: UIViewController {
    
    var user: User!
    //var profile : Profile?

    @IBOutlet weak var profilenameUser: UILabel!
    @IBOutlet weak var profileImageUser: UIImageView!
    @IBOutlet weak var emailUser: UILabel!
    @IBOutlet weak var phoneUser: UILabel!
    @IBOutlet weak var countryUser: UILabel!
    @IBOutlet weak var genderUser: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
        UserAPI.getUserProfile(id: user.id) { userResponse in
            self.user = userResponse
            self.setUpUI()
        }
        
   
   }
    func setUpUI(){
        profilenameUser.text = user.firstName + " " + user.lastName
        profileImageUser.setImageFromStringUrl(stringUrl: user.picture!)
        profileImageUser.makeImageCircler()
        emailUser.text = user.email
        phoneUser.text = user.phone
        genderUser.text = user.gender
        if let loc = user.location {
            countryUser.text = loc.country! + " - " + loc.city!
        }
        
    }
}
