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
                     "How long you usually take to shower?",
                     "Do you recycle often?",
                     "How much trash you produce compared to your neighbors?",
                     "What type of transportation you usually use?",
                     "Type of vehicle you or your family own?",
                     "Average hours of car usage per day?",
                     "Do you have any saving supplies at home?",
                     "How long do you have your thermostat on at home per day?",
                     "Do you usually try to use as less light as possible?"
                    ]
    
    var answers = Answers()
    
    var counter = 0
    
    var energyPoints = 0
    var resourcesPoints = 0
    var transportationPoints = 0
    
    @IBOutlet weak var questionTextLabel: UILabel!
    
    @IBOutlet weak var btnAnswerA: UIButton!
    @IBOutlet weak var btnAnswerB: UIButton!
    @IBOutlet weak var btnAnswerC: UIButton!
    @IBOutlet weak var btnAnswerD: UIButton!
    
    @IBOutlet weak var progressBar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
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
            resourcesPoints += 1
        } else if counter <= 6 {
            transportationPoints += 1
        } else if counter > 6 {
            energyPoints += 1
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
    
    @IBAction func btnDTapped(_ sender: Any) {
        if counter <= 3 {
            resourcesPoints += 3
        } else if counter <= 6 {
            transportationPoints += 3
        } else if counter > 6 {
            energyPoints += 3
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
        progressBar.frame.size.width = 1+(view.frame.size.width / 10) * CGFloat(counter)
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
        let user = User.current.uid
        let ref = Database.database().reference().child("users").child(user)
        ref.updateChildValues(["energyPoints" : energyPoints])
        ref.updateChildValues(["transportationPoints" : transportationPoints])
        ref.updateChildValues(["resourcesPoints" : resourcesPoints])
        ref.updateChildValues(["quizScore" : quizScore])

    }
}
























