//
//  User.swift
//  Social-Media-Project
//
//  Created by Zaghloul on 08/09/2022.
//

import Foundation

struct User: Decodable {
    var id: String
    var firstName: String
    var lastName: String
    var picture: String?
    var email: String?
    var phone: String?
    var gender: String?
    var location: Location?
}

struct Location: Decodable{
   var city: String?
    var country: String?
}
