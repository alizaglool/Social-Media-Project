//
//  PostCell.swift
//  Social-Media-Project
//
//  Created by Zaghloul on 06/09/2022.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postUserName: UILabel!
    @IBOutlet weak var postUserImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}