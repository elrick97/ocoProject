//
//  ProfileViewController.swift
//  ocoProject
//
//  Created by Ricardo Ramirez on 8/3/18.
//  Copyright © 2018 Ricardo Ramirez. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func logOutBtn(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            let window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIViewController(nibName: "SignUp", bundle: nil)
            window.rootViewController = storyboard
            window.makeKeyAndVisible()
        }
    }
}
