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
    
    
    @IBOutlet weak var postTableView: UITableView!
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        postTableView.delegate = self
        postTableView.dataSource = self
        
        // Noticiation
        NotificationCenter.default.addObserver(self, selector: #selector(userProfileTapped), name: NSNotification.Name("userStackViewTapped"), object: nil)
        let url = "https://dummyapi.io/data/v1/post"
        let headers: HTTPHeaders = [
            "app-id": "63171e3d8458da831168d2ad"
        ]
        loaderView.startAnimating()
        AF.request(url, headers: headers).responseJSON { response in
            self.loaderView.stopAnimating()
            let josnData = JSON(response.value)
            let data = josnData["data"]
            let decoder = JSONDecoder()
            do {
                self.posts = try decoder.decode([Post].self, from: data.rawData())
                self.postTableView.reloadData()
            }catch let error {
                print(error)
            }
            
        }
    }
    
        //MARK: - ACTIONS
    
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
}

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
//        if let urlUserImage = URL(string: userImageStringUrl){
//            if let imageUserData = try? Data(contentsOf: urlUserImage){
//                cell.postUserImage.image = UIImage(data: imageUserData)
//            }
//        }
        cell.postUserImage.setImageFromStringUrl(stringUrl: userImageStringUrl)
        // the logic of convert Image post from URL
        let postImageStringUrl = post.image
//        if let url = URL(string: postImageStringUrl) {
//            if let imageData = try? Data(contentsOf: url){
//                cell.postImage.image = UIImage(data: imageData)
//            }
//        }
        cell.postImage.setImageFromStringUrl(stringUrl: postImageStringUrl)
        cell.postLikes.text = "\(post.likes)"
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 470
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPost = posts[indexPath.row]
        let storyboard: UIStoryboard = UIStoryboard(name: "PostDetail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PostDetailVC") as! PostDetailVC
        vc.post = selectedPost
        self.showDetailViewController(vc, sender: self)
        
    }
    
    
    
}
