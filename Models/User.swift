//
//  User.swift
//  ocoProject
//
//  Created by Ricardo Ramirez on 7/25/18.
//  Copyright © 2018 Ricardo Ramirez. All rights reserved.
//

import Foundation
import UIKit

class User {
    
    var name: String
    var email: String
    var quizScore: Int
    var quizAverage: Int
//    var password: String
    
    init(name: String, email: String, quizScore: Int, quizAverage: Int/*, password: String*/) {
        self.name = name
        self.email = email
        self.quizScore =  quizScore
        self.quizAverage = quizAverage
//        self.password = password
    }
    
}
