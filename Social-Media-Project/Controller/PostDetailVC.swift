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
    @IBOutlet weak var LoaderView: NVActivityIndicatorView!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var postTextLable: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postLikes: UILabel!
    
    
    
    
    //MARK: - LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTableView.dataSource = self
        commentTableView.delegate = self
        let url = "https://dummyapi.io/data/v1/post/\(post.id)/comment"
        let headers: HTTPHeaders = [
            "app-id": "63171e3d8458da831168d2ad"
        ]
        LoaderView.startAnimating()
        AF.request(url, headers: headers).responseJSON { response in
            self.LoaderView.stopAnimating()
            let josnData = JSON(response.value)
            let data = josnData["data"]
            let decoder = JSONDecoder()
            do {
                self.comment = try decoder.decode([Comment].self, from: data.rawData())
                self.commentTableView.reloadData()
            }catch let error {
                print(error)
            }
        

        }
        nameUser.text = post.owner.firstName + " " + post.owner.lastName
        postTextLable.text = post.text
        postLikes.text = String(post.likes)
        imageUser.setImageFromStringUrl(stringUrl: post.owner.picture)
        imageUser.makeImageCircler()
        postImage.setImageFromStringUrl(stringUrl: post.image)
    }
    
    @IBAction func backToPsats(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
        cell.commentUserImage.setImageFromStringUrl(stringUrl: commentUserImageUrl)
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
