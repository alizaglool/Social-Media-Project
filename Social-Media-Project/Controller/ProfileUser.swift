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
        
        
        let postId = user.id

        let url = "https://dummyapi.io/data/v1/user/\(postId)"
        let headers: HTTPHeaders = [
            "app-id": "63171e3d8458da831168d2ad"
        ]
        //LoaderView.startAnimating()
        AF.request(url, headers: headers).responseJSON { response in
            
//            self.LoaderView.stopAnimating()
            let josnData = JSON(response.value)
            let decoder = JSONDecoder()
            do {
                self.user = try decoder.decode(User.self, from: josnData.rawData())
                self.setUpUI()
//                self.emailUser.text = self.profile?.email
//                self.phoneUser.text = self.profile?.phone
//                self.countryUser.text = self.profile?.location.country + " - "
//                self.genderUser.text = self.profile?.gender
//                print(self.profile)
                //self.commentTableView.reloadData()
            }catch let error {
                print(error)
            }
        }
   
   }
    func setUpUI(){
        profilenameUser.text = user.firstName + " " + user.lastName
        profileImageUser.setImageFromStringUrl(stringUrl: user.picture)
        profileImageUser.makeImageCircler()
        emailUser.text = user.email
        phoneUser.text = user.phone
        genderUser.text = user.gender
        if let loc = user.location {
            countryUser.text = loc.country! + " - " + loc.city!
        }
        
    }
}
