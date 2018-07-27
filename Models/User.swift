//
//  User.swift
//  ocoProject
//
//  Created by Ricardo Ramirez on 7/25/18.
//  Copyright © 2018 Ricardo Ramirez. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase.FIRDataSnapshot

class User {
    
    var uid: String
    var name: String
    var email: String
    var quizScore: Int
    var energyPoints: Int
    var transportationPoints: Int
    var resourcesPoints: Int
    var quizAverage: Int
//    var password: String
    
    init(name: String, email: String, quizScore: Int, quizAverage: Int/*, password: String*/, uid: String, energyPoints: Int, transportationPoints: Int, resourcesPoints: Int) {
        self.uid = uid
        self.name = name
        self.email = email
        self.quizScore =  quizScore
        self.quizAverage = quizAverage
        self.energyPoints = energyPoints
        self.transportationPoints = transportationPoints
        self.resourcesPoints = resourcesPoints
//        self.password = password
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any],
            let name = dict["name"] as? String,
            let quizScore = dict["quizScore"] as? Int,
            let email = dict["email"] as? String,
            let energyPoints = dict["energyPoints"] as? Int,
            let transportationPoints = dict["transportationPoints"] as? Int,
            let quizAverage = dict["quizAverage"] as? Int,
            let resourcesPoints = dict["resourcesPoints"] as? Int
            else {return nil}
        self.uid = snapshot.key
        self.name = name
        self.quizScore =  quizScore
        self.energyPoints = energyPoints
        self.quizAverage = quizAverage
        self.transportationPoints = transportationPoints
        self.resourcesPoints = resourcesPoints
        self.email = email
    }
    
}
