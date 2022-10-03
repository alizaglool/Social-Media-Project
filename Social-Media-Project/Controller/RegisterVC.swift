//
//  RegisterVC.swift
//  Social-Media-Project
//
//  Created by Zaghloul on 12/09/2022.
//

import UIKit

class RegisterVC: UIViewController {

    
    @IBOutlet weak var fristName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailUser: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnRegisterUser(_ sender: UIButton) {
        
        UserAPI.registerUesr(firstName: fristName.text!, lastName: lastName.text!, email: emailUser.text!) { User, emailError in
            if emailError != nil {
                let alert = UIAlertController(title: "Error", message: emailError, preferredStyle: .alert)
                let okAlart = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(okAlart)
                self.present(alert, animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: "Scusse", message: "The Register is Done", preferredStyle: .alert)
                let okAlart = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(okAlart)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "PostVC") as! PostVC
                self.present(alert, animated: true, completion: nil)
                self.showDetailViewController(vc, sender: nil)
                
            }
        }
    }
    
    @IBAction func signInUser(_ sender: Any) {
        dismiss(animated: true)
    }
}
