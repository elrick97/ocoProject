//
//  Challenges.swift
//  ocoProject
//
//  Created by Ricardo Ramirez on 8/2/18.
//  Copyright © 2018 Ricardo Ramirez. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class ChallengesViewController: UIViewController{
    
    @IBOutlet weak var overallView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalSeedsTextLabel: UILabel!
    
    var counter: Int = 0
    var shapeLayer: CAShapeLayer!
    var pulsatingLayer: CAShapeLayer!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 100.0

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
        setupCircleLayers()
        
        if let _ = user {
            animateCircle()
        }
    }
    
    func updateValues() {
        let user = User.current.uid
        
        UserService.show(forUID: user) { (user) in
            
            self.user = user
           
        }
    }
    private func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 80, startAngle: CGFloat.pi, endAngle: 0, clockwise: true)
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = 25
        layer.fillColor = fillColor.cgColor
        layer.lineCap = kCALineCapRound
        layer.position = CGPoint(x: overallView.bounds.midX, y: overallView.bounds.midY + 40)
        return layer
    }
    private func setupCircleLayers() {
        pulsatingLayer = createCircleShapeLayer(strokeColor: .clear, fillColor: UIColor(red: 118/255, green: 214/255, blue: 113/255, alpha: 0.3))
        overallView.layer.addSublayer(pulsatingLayer)
        animatePulsatingLayer()
        
        let trackLayer = createCircleShapeLayer(strokeColor: UIColor(red: 76/255, green: 217/255, blue: 250/255, alpha: 1), fillColor: .white)
        overallView.layer.addSublayer(trackLayer)
        
        shapeLayer = createCircleShapeLayer(strokeColor: UIColor(red: 118/255, green: 214/255, blue: 113/255, alpha: 1), fillColor: .clear)
        
        shapeLayer.transform = CATransform3DMakeRotation(CGFloat.pi / 1, 0, 0, 0)
        shapeLayer.strokeEnd = 0
        overallView.layer.addSublayer(shapeLayer)
    }
    private func animatePulsatingLayer() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.toValue = 1.2
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        pulsatingLayer.add(animation, forKey: "pulsing")
    }
    
    fileprivate func animateCircle() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        let num = Float(counter) / 3.0
        basicAnimation.toValue = num
        
        basicAnimation.duration = 2
        
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
}

extension ChallengesViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.init().challenge.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "challengeTableViewCell", for: indexPath) as! ChallengeTableViewCell
        cell.challengeTextLabel.text = DataService.init().challenge[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension ChallengesViewController: MyCellDelegate {
    
    func didTappedCheck(_ sender: ChallengeTableViewCell) {
        guard let tappedIndex = tableView.indexPath(for: sender) else {return}
        counter += 1
        sender.btnCheck.isEnabled = false
        animateCircle()
    }
}


