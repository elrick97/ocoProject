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
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBAction func unwind(segue:UIStoryboardSegue) { }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnAlreadyAUser: UIButton!
    
    
     override func viewDidLoad() {
        super.viewDidLoad()
        btnSignUp.layer.cornerRadius = 20
        btnAlreadyAUser.layer.cornerRadius = 20
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
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
                    if let error = error {
                        print(error.localizedDescription)
                        let alertController = UIAlertController(title: "Make sure everything is filled correctly!", message:
                            "\(error.localizedDescription)", preferredStyle: UIAlertControllerStyle.alert)
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
                            Notifications.setUpNotification1()
                            Notifications.setUpNotification2()
                            Notifications.setUpNotification3()
                            Notifications.setUpNotification4()
                            Notifications.setUpNotification5()
                            Notifications.setUpNotification6()
                            Notifications.setUpNotification7()
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







