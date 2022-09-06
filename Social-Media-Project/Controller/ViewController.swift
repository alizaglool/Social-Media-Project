//
//  ViewController.swift
//  Social-Media-Project
//
//  Created by Zaghloul on 06/09/2022.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    
    @IBOutlet weak var postTableView: UITableView!
    
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        postTableView.delegate = self
        postTableView.dataSource = self
        let url = "https://dummyapi.io/data/v1/post"
        let headers: HTTPHeaders = [
            "app-id": "63171e3d8458da831168d2ad"
        ]
        AF.request(url, headers: headers).responseJSON { response in
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


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let post = posts[indexPath.row]
        
        cell.postText.text = post.text
        cell.postUserName.text = post.owner.firstName + " " + post.owner.lastName
        if let urlUserImage = URL(string: post.owner.picture){
            if let imageUserData = try? Data(contentsOf: urlUserImage){
                cell.postUserImage.image = UIImage(data: imageUserData)
            }
        }
        // convert Image post from URL to Image Swift
        if let url = URL(string: post.image) {
            if let imageData = try? Data(contentsOf: url){
                cell.postImage.image = UIImage(data: imageData)
            }
        }
        
        return cell
    }
    
    
    
}
