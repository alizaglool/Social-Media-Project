//
//  Post.swift
//  Social-Media-Project
//
//  Created by Zaghloul on 06/09/2022.
//

import Foundation
import UIKit

struct Post: Decodable {
    var id: String
    var image: String
    var likes: Int
    var text: String
    var owner: User
}


