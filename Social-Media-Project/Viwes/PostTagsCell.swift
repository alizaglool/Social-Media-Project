//
//  PostTagsCell.swift
//  Social-Media-Project
//
//  Created by Zaghloul on 13/09/2022.
//

import UIKit

class PostTagsCell: UICollectionViewCell {
    
    @IBOutlet weak var postTageNamelbl: UILabel!
    @IBOutlet weak var tagViewPost: UIView!{
        didSet{
            tagViewPost.layer.cornerRadius = 10
        }
    }
}
