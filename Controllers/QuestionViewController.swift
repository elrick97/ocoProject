//
//  QuestionViewController.swift
//  ocoProject
//
//  Created by Ricardo Ramirez on 7/26/18.
//  Copyright © 2018 Ricardo Ramirez. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class QuestionViewController: UIViewController {
    
    var questions = ["How many times a week do you eat meat?",
                     "How long do you usually take to a shower?",
                     "Do you recycle often?",
                     "How much trash do you produce compared to your neighbors?",
                     "What type of transportation do you usually use?",
                     "What type of vehicles do you or your family own?",
                     "On average, how long do you commute a day?",
                     "Do you have any saving supplies at home?",
                     "How long do you have your thermostat on at home per day?",
                     "Do you usually try to use as less light as possible?"
                    ]
    
    var answers = Answers()
    
    var counter = 0
    
    var energyPoints = Int()
    var resourcesPoints = Int()
    var transportationPoints = Int()
    
    @IBOutlet weak var questionTextLabel: UILabel!
    
    @IBOutlet weak var btnAnswerA: UIButton!
    @IBOutlet weak var btnAnswerB: UIButton!
    @IBOutlet weak var btnAnswerC: UIButton!
    @IBOutlet weak var btnAnswerD: UIButton!
    
    @IBOutlet weak var progressBar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        btnAnswerA.layer.cornerRadius = 10
        btnAnswerB.layer.cornerRadius = 10
        btnAnswerC.layer.cornerRadius = 10
        btnAnswerD.layer.cornerRadius = 10
        
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    @IBAction func btnATapped(_ sender: Any) {
        if counter != 9 {
            counter += 1
            updateUI()
        } else  {
            toMain()
            //to main page
        }
    }
    
    @IBAction func btnBTapped(_ sender: Any) {
        if counter <= 3 {
            resourcesPoints += 2
        } else if counter <= 6 {
            transportationPoints += 2
        } else if counter > 6 {
            energyPoints += 2
        }
        if counter != 9 {
            counter += 1
            updateUI()
        } else  {
            toMain()
            //to main page
        }
    }
    
    @IBAction func btnCTapped(_ sender: Any) {
        if counter <= 3 {
            resourcesPoints += 4
        } else if counter <= 6 {
            transportationPoints += 4
        } else if counter > 6 {
            energyPoints += 4
        }
        if counter != 9 {
            counter += 1
            updateUI()
        } else  {
            toMain()
            //to main page
        }
    }
    
    @IBAction func btnDTapped(_ sender: Any) {
        if counter <= 3 {
            resourcesPoints += 6
        } else if counter <= 6 {
            transportationPoints += 6
        } else if counter > 6 {
            energyPoints += 6
        }
        if counter != 9 {
            counter += 1
            updateUI()
        } else  {
            toMain()
            //to main page
        }
    }

    func updateUI() {
        questionTextLabel.text = questions[counter]
        
        btnAnswerA.setTitle(answers.answers[counter][0], for: .normal)
        btnAnswerB.setTitle(answers.answers[counter][1], for: .normal)
        btnAnswerC.setTitle(answers.answers[counter][2], for: .normal)
        btnAnswerD.setTitle(answers.answers[counter][3], for: .normal)
        progressBar.frame.size.width = 1 + (view.frame.size.width / 10) * CGFloat(counter)
    }
    func toMain() {
        updateValuesInFirebase()
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        if let initialViewController = storyboard.instantiateInitialViewController() {
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
        }
    }
    func updateValuesInFirebase() {
        let quizScore = resourcesPoints + transportationPoints + energyPoints
        let user = User.current
        let ref = Database.database().reference().child("users").child(user.uid)
        ref.updateChildValues(["energyPoints" : energyPoints])
        ref.updateChildValues(["transportationPoints" : transportationPoints])
        ref.updateChildValues(["resourcesPoints" : resourcesPoints])
        ref.updateChildValues(["quizScore" : quizScore])
        user.energyPoints = energyPoints
        user.transportationPoints = transportationPoints
        user.resourcesPoints = resourcesPoints
        user.quizScore = quizScore
    }
}
