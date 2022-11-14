//
//  PostDetailVC.swift
//  Social-Media-Project
//
//  Created by Zaghloul on 07/09/2022.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class PostDetailVC: UIViewController {

    var post: Post!
    var comment: [Comment] = []
    
    //MARK: - OUTLETS
    @IBOutlet weak var sendCommentSV: UIStackView!
    @IBOutlet weak var LoaderView: NVActivityIndicatorView!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var postTextLable: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postLikes: UILabel!
    @IBOutlet weak var commentTF: UITextField!
    
    
    
    
    //MARK: - LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserManager.logedInUser == nil {
            sendCommentSV.isHidden = true
        }
        
        commentTableView.dataSource = self
        commentTableView.delegate = self
        setupUI()
       
        getComments()

    }
    
    func getComments(){
        LoaderView.startAnimating()
        PostAPI.getCommentsOfPost(id: post.id) { commentResponce in
            self.comment = commentResponce
            self.commentTableView.reloadData()
            self.LoaderView.stopAnimating()
        }
    }
    
    func setupUI(){
        nameUser.text = post.owner.firstName + " " + post.owner.lastName
        postTextLable.text = post.text
        postLikes.text = String(post.likes)
        if let image = post.owner.picture {
            imageUser.setImageFromStringUrl(stringUrl: image)
        }
        
        imageUser.makeImageCircler()
        if let image = post.image {
            postImage.setImageFromStringUrl(stringUrl: image)

        }
    }
    @IBAction func backToPsats(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createCommentToPost(_ sender: Any) {
        
        let message = commentTF.text!
        if let user = UserManager.logedInUser {
            PostAPI.creatCommenttoPost(postId: post.id, ownerId: user.id, message: message) {
                self.LoaderView.startAnimating()
                self.getComments()
                self.commentTF.text = ""
//            PostAPI.testCommenttoPost(url: .createComment, pramers: [
//                "post": postId,
//                "owner": ownerId,
//                "message": message
//            ], method: .post) {
//                                self.LoaderView.startAnimating()
//                                self.getComments()
//                                self.commentTF.text = ""
//            }
//            }
        }
       
    
        }
    }

}
extension PostDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
        let currentComment = comment[indexPath.row]
        cell.commentMessageLabel.text = currentComment.message
        cell.commentUserName.text = currentComment.owner.firstName + " " + currentComment.owner.lastName
        // the logic of convert Image user from URL
        let commentUserImageUrl = currentComment.owner.picture
        if let userImage = commentUserImageUrl {
            cell.commentUserImage.setImageFromStringUrl(stringUrl: userImage)
        }
        cell.commentUserImage.makeImageCircler()
//        if let url = URL(string: currentComment.owner.picture) {
//            if let imageData = try? Data(contentsOf: url) {
//                cell.commentUserImage.image = UIImage(data: imageData)
//            }
//        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
    
    
}
