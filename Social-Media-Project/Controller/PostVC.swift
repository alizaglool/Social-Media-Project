//
//  ViewController.swift
//  Social-Media-Project
//
//  Created by Zaghloul on 06/09/2022.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class PostVC: UIViewController {
    
    //MARK: - OUTLET
    @IBOutlet weak var continerViewAddPost: UIView!{
        didSet{
            continerViewAddPost.layer.cornerRadius = 25
        }
    }
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var nameTag: UILabel!
    @IBOutlet weak var continerView: UIView!
    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var postTableView: UITableView!
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    //MARK: - VARABALE
    var posts: [Post] = []
    var tag: String?
    var page = 0
    var total = 0
    //MARK: - LIFR CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(NewPostAdded), name: NSNotification.Name("NewPostAdded"), object: nil)
        
        continerView.layer.cornerRadius = 20
        // if user SignIn on App
        if let user = UserManager.logedInUser {
            welcomeLbl.text = "Welcom, \(user.firstName)"
        }else{
            welcomeLbl.text = "Welcom"
            continerViewAddPost.isHidden = true
        }
        // if tapped in tag
        if let myTag = tag {
            nameTag.text = myTag
        }else{
            btnBack.isHidden = true
            continerView.isHidden = true
        }
        
        postTableView.delegate = self
        postTableView.dataSource = self
        
        // Noticiation
        NotificationCenter.default.addObserver(self, selector: #selector(userProfileTapped), name: NSNotification.Name("userStackViewTapped"), object: nil)
        getAllPost()
//        loaderView.startAnimating()
//        PostAPI.getPostUsers(tags: tag) { postResponse in
//            self.posts = postResponse
//            self.postTableView.reloadData()
//            self.loaderView.stopAnimating()
//        }
    }
    func getAllPost(){
        loaderView.startAnimating()
        PostAPI.getPostUsers(page: page, tags: tag) { postResponse,total  in
            self.total = total
            self.posts.append(contentsOf: postResponse)
            self.postTableView.reloadData()
            self.loaderView.stopAnimating()
        }
    }
        //MARK: - ACTIONS
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logout"{
            UserManager.logedInUser = nil
        }
    }
    
    @objc func NewPostAdded(){
        self.posts = []
        self.page = 0
        getAllPost()
    }
    
    @objc func userProfileTapped(notifiction: Notification){
        if let cell = notifiction.userInfo?["cell"] as? UITableViewCell {
            if let indexPath = postTableView.indexPath(for: cell) {
                let post = posts[indexPath.row]
                let storyboard: UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ProfileUser") as! ProfileUser
                vc.user = post.owner
                showDetailViewController(vc, sender: nil)
            }
        }
    }
    
    @IBAction func btnDissPage(_ sender: Any) {
        dismiss(animated: true)
    }
}
 // MARK: - TABLEVIEW
extension PostVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let post = posts[indexPath.row]
        
        cell.postText.text = post.text
        cell.postUserName.text = post.owner.firstName + " " + post.owner.lastName
        // the logic of convert Image user from URL
        cell.postUserImage.makeImageCircler()
        
        let userImageStringUrl = post.owner.picture
        if let image = userImageStringUrl {
            cell.postUserImage.setImageFromStringUrl(stringUrl: image)
        }
        
        // the logic of convert Image post from URL
        let postImageStringUrl = post.image
        if let image = postImageStringUrl {
            cell.postImage.setImageFromStringUrl(stringUrl: image)

        }
        cell.postLikes.text = "\(post.likes)"
        
        cell.tags = post.tags ?? []
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 486
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPost = posts[indexPath.row]
        let storyboard: UIStoryboard = UIStoryboard(name: "PostDetail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PostDetailVC") as! PostDetailVC
        vc.post = selectedPost
        self.showDetailViewController(vc, sender: self)
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == posts.count - 1 && posts.count < total {
            page = page + 1
            getAllPost()
        }
    }
    
    
}
