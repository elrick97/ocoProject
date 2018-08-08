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
import MessageUI

class ProfileViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnRetakeTest.layer.cornerRadius = 10
        btnLogOut.layer.cornerRadius = 10
        btnFeedback.layer.cornerRadius = 10
        
    }
    @IBOutlet weak var btnRetakeTest: UIButton!
    @IBOutlet weak var btnLogOut: UIButton!
    @IBOutlet weak var btnFeedback: UIButton!
    
    @IBAction func logOutBtn(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        let storyBoard : UIStoryboard = UIStoryboard(name: "SignUp", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SignUp")
        self.present(nextViewController, animated: true, completion: nil)
    }
    @IBAction func feedbackTapped(_ sender: Any) {
        let mailComposeViewController = configureMailController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            showMailError()
        }
    }
    
    @IBAction func retakeTestTapped(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "SignUp", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "questionaryViewController")
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    func configureMailController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["seeds.project.ricardo@gmail.com"])
        mailComposerVC.setSubject("Seeds App Feedback")
        mailComposerVC.setMessageBody("Hey we have some advice that will help you!", isHTML: false)
        
        return mailComposerVC
    }
    func showMailError() {
        let sendMailErrorAlert = UIAlertController(title: "Could not send mail", message: "Your device could not send email", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Ok", style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}











