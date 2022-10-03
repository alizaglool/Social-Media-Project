//
//  NewPostVC.swift
//  Social-Media-Project
//
//  Created by Zaghloul on 13/09/2022.
//

import UIKit

class NewPostVC: UIViewController {

    @IBOutlet weak var newTextPostTF: UITextField!
    @IBOutlet weak var newImagePostTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closePageAddPost(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnAddPostClicked(_ sender: Any) {
        if let user = UserManager.logedInUser {
            PostAPI.addNewPost(text: newTextPostTF.text!, ownerId: user.id ) {
                NotificationCenter.default.post(name: NSNotification.Name("NewPostAdded"), object: nil, userInfo: nil)
                self.dismiss(animated: true, completion: nil)
            }

        }
    }
    
}
