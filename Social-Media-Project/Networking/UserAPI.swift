//
//  UserAPI.swift
//  Social-Media-Project
//
//  Created by Zaghloul on 11/09/2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserAPI: API{
    
    
    static func getUserProfile(id: String, complitionHander: @escaping (User) -> ()){
        let url = "\(baseURL)/user/\(id)"
        AF.request(url, headers: headers).responseJSON { response in
            let josnData = JSON(response.value)
            let decoder = JSONDecoder()
            do {
                let users = try decoder.decode(User.self, from: josnData.rawData())
                complitionHander(users)
            }catch let error {
                print(error)
            }
        }
    }
    
    static func registerUesr(firstName: String, lastName: String, email: String, complitionHander: @escaping (User?, String?) -> () ) {
        
        let url = "\(baseURL)/user/create"
        let pramers = [
            "firstName": firstName,
            "lastName": lastName,
            "email": email
        ]
        AF.request(url, method: .post, parameters: pramers, encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success:
                let josnData = JSON(response.value)
                let decoder = JSONDecoder()
                do {
                    let users = try decoder.decode(User.self, from: josnData.rawData())
                    complitionHander(users, nil)
                }catch let error {
                    print(error)
                }
            case .failure(_):
                let jsondata = JSON(response.data)
                let data = jsondata["data"]
                let emailError = data["email"].stringValue
                let firstNameError = jsondata["frisName"].stringValue
                let lastNameError = jsondata["lastName"].stringValue
                let messageError = emailError + " " + firstNameError + " " + lastNameError
                complitionHander(nil, messageError )
            }
           
        }
    }
    
    static func logInUesr(firstName: String, lastName: String, complitionHander: @escaping (User?, String?) -> () ) {
        // 
        let url = "\(baseURL)/user?create"
        let pramers = [
            "created": 1
        ]
        AF.request(url, method: .get, parameters: pramers, encoder: URLEncodedFormParameterEncoder.default, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success:
                let josnData = JSON(response.value)
                let data = josnData["data"]
                let decoder = JSONDecoder()
                do {
                    let users = try decoder.decode([User].self, from: data.rawData())
//                    complitionHander(users, nil)
                    var logedUser: User?
                    for user in users {
                        if user.firstName == firstName && user.lastName == lastName {
                            logedUser = user
                            break
                        }
                    }
                    if let user = logedUser {
                        complitionHander(user, nil)
                    }else{
                        complitionHander(nil, "The FirstName or yhe LastName don't match ")
                    }
                   
                }catch let error {
                    print(error)
                }
            case .failure(_):
                let jsondata = JSON(response.data)
                let data = jsondata["data"]
                let emailError = data["email"].stringValue
                let firstNameError = jsondata["frisName"].stringValue
                let lastNameError = jsondata["lastName"].stringValue
                let messageError = emailError + " " + firstNameError + " " + lastNameError
                complitionHander(nil, messageError )
            }
           
        }
    }
    
    static func updataUserInfo(userId: String, firstName: String, phone: String, image: String, complitionHander: @escaping (User, String?) -> () ) {
        
        let url = "\(baseURL)/user/\(userId)"
        let pramers = [
            "firstName": firstName,
            "picture": image,
            "phone": phone
        ]
        AF.request(url, method: .put, parameters: pramers, encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success:
                let josnData = JSON(response.value)
                let decoder = JSONDecoder()
                do {
                    let users = try decoder.decode(User.self, from: josnData.rawData())
                    complitionHander(users, nil)
                }catch let error {
                    print(error)
                }
            case .failure(_):
                let jsondata = JSON(response.data)
                let data = jsondata["data"]
                let emailError = data["email"].stringValue
                let firstNameError = jsondata["frisName"].stringValue
                let lastNameError = jsondata["lastName"].stringValue
                let messageError = emailError + " " + firstNameError + " " + lastNameError
                //complitionHander(nil, messageError )
            }
           
        }
    }
    
}
