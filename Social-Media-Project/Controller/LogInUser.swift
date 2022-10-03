//
//  LogInUser.swift
//  Social-Media-Project
//
//  Created by Zaghloul on 12/09/2022.
//

import UIKit

class LogInUser: UIViewController {

    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnLogInUser(_ sender: UIButton) {
        UserAPI.logInUesr(firstName: firstName.text!, lastName: lastName.text!) { user, messageError in
            if let message = messageError {
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }else {
                if let logedInUser = user {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC")
                    UserManager.logedInUser = logedInUser
                    self.present(vc!, animated: true, completion: nil)
                }
            }
        }
    }
    
}
