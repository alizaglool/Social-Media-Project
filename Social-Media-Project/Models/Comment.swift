//
//  Comment.swift
//  Social-Media-Project
//
//  Created by Zaghloul on 07/09/2022.
//

import Foundation

struct Comment: Decodable {
    var id: String
    var message: String
    var owner: User
}
