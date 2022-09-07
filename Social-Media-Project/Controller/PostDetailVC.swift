//
//  PostDetailVC.swift
//  Social-Media-Project
//
//  Created by Zaghloul on 07/09/2022.
//

import UIKit
import Alamofire
import SwiftyJSON

class PostDetailVC: UIViewController {

    var post: Post!
    var comment: [Comment] = []
    
    //MARK: - OUTLETS
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var postTextLable: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postLikes: UILabel!
    @IBOutlet weak var backView: UIView!{
        didSet{
            backView.layer.shadowColor = UIColor.gray.cgColor
            backView.layer.shadowOpacity = 0.4
            backView.layer.shadowOffset = CGSize(width: 0, height: 10)
            backView.layer.shadowRadius = 10
            backView.layer.cornerRadius = 5
        }
    }
    
    
    
    //MARK: - LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTableView.dataSource = self
        commentTableView.delegate = self
        let url = "https://dummyapi.io/data/v1/post/\(post.id)/comment"
        let headers: HTTPHeaders = [
            "app-id": "63171e3d8458da831168d2ad"
        ]
        AF.request(url, headers: headers).responseJSON { response in
            let josnData = JSON(response.value)
            let data = josnData["data"]
            let decoder = JSONDecoder()
            do {
                self.comment = try decoder.decode([Comment].self, from: data.rawData())
                self.commentTableView.reloadData()
            }catch let error {
                print(data)
            }
        

        }
        nameUser.text = post.owner.firstName + " " + post.owner.lastName
        postTextLable.text = post.text
        postLikes.text = String(post.likes)
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
        
        cell.commentMessageLabel.text = comment[indexPath.row].message
        return cell
    }
    
    
}
