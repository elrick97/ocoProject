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
        let email = emailTextField.text
        let password = passwordTextField.text
        let name = nameTextField.text
        
        if ((email?.isEmpty)! || (password?.isEmpty)! || (name?.isEmpty)!)
        {
                print("--------------EMPTY--------------")
            let alertController = UIAlertController(title: "Please fill out all fields", message:
                "We apreciate your effort", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Got it!", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            Auth.auth().createUser(withEmail: email!, password: password!) { (user, error) in
                    if let error = error
                    {
                        print(error.localizedDescription)
                        let alertController = UIAlertController(title: "Make sure everything is filled correctly!", message:
                            "Psw:6+ch/Valid mail/name", preferredStyle: UIAlertControllerStyle.alert)
                        alertController.addAction(UIAlertAction(title: "Got it!", style: UIAlertActionStyle.default,handler: nil))
                        
                        self.present(alertController, animated: true, completion: nil)
                        return
                    }
                    else
                    {
                        let user = Auth.auth().currentUser
                        UserService.create(user!, name: name!, completion: { (user) in
                            guard let user = user else {
                                //handle Error
                                return
                            }
                            
                            User.setCurrent(user, writeToUserDefaults: true)
                            
                            self.performSegue(withIdentifier: "toQuestionary", sender: self)
                            print("created succesfully")
                        })
                        //make an update to firebase to update the user´s name
                        
                        
                    }
                }
        }
    }
    @IBAction func alreadyAUserTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "toLogin", sender: self)
    }
}










