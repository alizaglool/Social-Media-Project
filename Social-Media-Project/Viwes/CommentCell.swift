//
//  CommentCell.swift
//  Social-Media-Project
//
//  Created by Zaghloul on 07/09/2022.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var commentUserImage: UIImageView!
    @IBOutlet weak var commentUserName: UILabel!
    @IBOutlet weak var commentMessageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
