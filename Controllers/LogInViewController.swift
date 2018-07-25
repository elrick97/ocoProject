//
//  LogInViewController.swift
//  ocoProject
//
//  Created by Ricardo Ramirez on 7/25/18.
//  Copyright © 2018 Ricardo Ramirez. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func logInTapped(_ sender: Any) {
        if let email = self.emailTextField.text, let password = self.passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                } else {
                    print("You are IN")
                }
            }
        } else {
            print("email/password can't be empty")
        }
    }
    @IBAction func createNewAccountTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindToCreateAccount", sender: self)
    }
    
    
}
