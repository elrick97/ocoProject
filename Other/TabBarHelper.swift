//
//  TabBarHelper.swift
//  ocoProject
//
//  Created by Ricardo Ramirez on 7/30/18.
//  Copyright © 2018 Ricardo Ramirez. All rights reserved.
//

import Foundation
import UIKit

class TabBarHelper: UITabBarController {
    
    @IBInspectable var defaultIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = defaultIndex
    }
}
