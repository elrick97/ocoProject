//
//  SignUpViewController.swift
//  ocoProject
//
//  Created by Ricardo Ramirez on 7/24/18.
//  Copyright © 2018 Ricardo Ramirez. All rights reserved.
//
import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {
    
    @IBAction func unwind(segue:UIStoryboardSegue) { }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        if let email = self.emailTextField.text, let password = self.passwordTextField.text, let name = nameTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                } else {
                    self.performSegue(withIdentifier: "toQuestionary", sender: self)
                    print("created succesfully")
                }
            }
        } else {
            print("email/password can't be empty")
        }
    }
    
    @IBAction func alreadyAUserTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "toLogin", sender: self)
    }
}










