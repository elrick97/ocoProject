//
//  ChallengeTableViewCell.swift
//  ocoProject
//
//  Created by Ricardo Ramirez on 8/2/18.
//  Copyright © 2018 Ricardo Ramirez. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol MyCellDelegate {
    func didTappedCheck(_ sender: ChallengeTableViewCell)
}

class ChallengeTableViewCell: UITableViewCell {
    
    var challenge: Challenge?
    
    @IBOutlet weak var challengeTextLabel: UILabel!
    @IBOutlet weak var btnCheck: UIButton!
    
    var delegate: MyCellDelegate?
    

    @IBAction func btnCheckTapped(_ sender: Any) {
//        CoreDataHelper.saveChallenge()
        delegate?.didTappedCheck(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    
}
