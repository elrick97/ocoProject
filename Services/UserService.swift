//
//  UserService.swift
//  ocoProject
//
//  Created by Ricardo Ramirez on 7/26/18.
//  Copyright © 2018 Ricardo Ramirez. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth.FIRUser
import FirebaseDatabase

class UserService {
    static func create(_ firUser: FirebaseAuth.User, name: String, completion: @escaping (User?) -> Void) {
        let userAttrs = ["name": name,
                         "quizScore": 0,
                         "energyPoints": 0,
                         "transportationPoints": 0,
                         "resourcesPoints": 0,
                         "quizAverage" : 0,
                         "totalSeeds": 0] as [String : Any]

        let ref = Database.database().reference().child("users").child(firUser.uid)
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }

            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                completion(user)
            })
        }
    }
    static func show(forUID uid: String, completion: @escaping (User?) -> Void) {
        let ref = Database.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let user = User(snapshot: snapshot) else {
                return completion(nil)
            }
            completion(user)
        })
    }

}
