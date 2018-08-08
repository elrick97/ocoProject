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
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnNewAccount: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnLogin.layer.cornerRadius = 20
        btnNewAccount.layer.cornerRadius = 20
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    @IBAction func logInTapped(_ sender: Any) {
        
        let email = emailTextField.text
        let password = passwordTextField.text
        
        if ((email?.isEmpty)! && (password?.isEmpty)!)
        {
            print("--------------EMPTY--------------")
            let alertController = UIAlertController(title: "Please fill out all fields", message:
                "We apreciate your effort", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Got it!", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            Auth.auth().signIn(withEmail: email!, password: password!) { (data, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                } else {
                    print("YOU ARE IN")
                    let user1 = data?.user.uid
                    UserService.show(forUID: (user1)!, completion: { (user1) in
                        User.setCurrent(user1!, writeToUserDefaults: true)
                        self.toMain()
                    })
                }
            }
        }
    }
    @IBAction func createNewAccountTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindToCreateAccount", sender: self)
    }
    func toMain() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        if let initialViewController = storyboard.instantiateInitialViewController() {
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
        }
    }
}
