//
//  Storyboard+Utilities.swift
//  ocoProject
//
//  Created by Ricardo Ramirez on 7/27/18.
//  Copyright © 2018 Ricardo Ramirez. All rights reserved.
//

import Foundation
import UIKit
extension UIStoryboard {
    enum MGType: String {
        case Main
        case SignUp
        
        var filename: String {
            return rawValue
        }
    }
    
    convenience init(type: MGType, bundle: Bundle? = nil){
        self.init(name: type.filename, bundle: bundle)
    }
    
    static func initialViewController(for type: MGType)->UIViewController{
        let storyboard = UIStoryboard(type: type)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            fatalError("Could not instantiate initial vc for \(type.filename) storyboard")
        }
        return initialViewController
    }
}
