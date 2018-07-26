//
//  Answers.swift
//  ocoProject
//
//  Created by Ricardo Ramirez on 7/26/18.
//  Copyright © 2018 Ricardo Ramirez. All rights reserved.
//

import Foundation
import UIKit

struct Answers {
    
    var answers = [[String]] ()

    init() {
        answers = [["4+ times a week", "2-3 times a week", "Once a week", "None"],
                   ["More than 15 min", "10-15 min", "8-10 min", "Less than 6 minutes",],
                   ["Never", "Almost never", "Sometimes", "Always"],
                   ["Way more", "Just a bit more", "The same amount", "Less than them"],
                   ["Car", "Public transportation", "Bike", "Walking"],
                   ["Gas", "Hybrid", "Electric", "None"],
                   ["More than 2 hours", "1:30-2:00 hours", "30-60 min", "0-30 min"],
                   ["Nope", "2-3 gadgets", "Solar panels", "100% sustainable house"],
                   ["4 hours plus",  "3-4 hours", "1-2 hours", "Do not use it at all" ],
                   ["Never", "When I remeber..", "Usually", "Always"]
                    ]
    }
    
}
