//
//  PostCell.swift
//  Social-Media-Project
//
//  Created by Zaghloul on 06/09/2022.
//

import UIKit

class PostCell: UITableViewCell {


    @IBOutlet weak var userStackView: UIStackView!{
        didSet{
            userStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userStackViewTapped)))
        }
    }
    @IBOutlet weak var postTagsCollectionView: UICollectionView!{
        didSet{
            postTagsCollectionView.delegate = self
            postTagsCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var postLikes: UILabel!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postUserName: UILabel!
    @IBOutlet weak var postUserImage: UIImageView!
    
    var tags: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
        //MARK: - Actions
    
    @objc func userStackViewTapped(){
        NotificationCenter.default.post(name: NSNotification.Name("userStackViewTapped"), object: nil, userInfo: ["cell": self])
    }

}

extension PostCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostTageCell", for: indexPath) as! PostTagsCell
        
        cell.postTageNamelbl.text = tags[indexPath.row]
        return cell
    }
    
    
}
