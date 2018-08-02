//
//  ProgressViewController.swift
//  ocoProject
//
//  Created by Ricardo Ramirez on 7/29/18.
//  Copyright © 2018 Ricardo Ramirez. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import FirebaseDatabase
import FirebaseAuth

class ProgressViewController: UIViewController {
    //-----------------------Overall Progress
    var shapeLayer: CAShapeLayer!
    var pulsatingLayer: CAShapeLayer!
    @IBOutlet weak var overallView: UIView!
    //-----------------------left progress
    var shapeLayerLeft: CAShapeLayer!
    @IBOutlet weak var leftView: UIView!
    //-----------------------middle progress
    var shapeLayerMiddle: CAShapeLayer!
    @IBOutlet weak var middleView: UIView!
    //-----------------------right progress
    var shapeLayerRight: CAShapeLayer!
    @IBOutlet weak var rightView: UIView!
    
    //LABELS
    @IBOutlet weak var energyLabel: UILabel!
    @IBOutlet weak var transportationLabel: UILabel!
    @IBOutlet weak var resourcesLabel: UILabel!
    
//    let questionsViewController = QuestionViewController()
    
    var user: User?
    
    var energy = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (didAllow, error) in
            
            
        }
        
        view.backgroundColor = UIColor.white
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        updateValues()
        setupCircleLayersMiddle()
        setupCircleLayersLeft()
        setupCircleLayers()
        setupCircleLayersRight()
        
        if let _ = user {
            animateCircle()
            animateCircleLeft()
            animateCircleMiddle()
            animateCircleRight()
        }
    }
    func updateValues() {
        let user = User.current.uid
        
        UserService.show(forUID: user) { (user) in
            
            self.user = user
            
            self.energyLabel.text = "\(Int(Double((user?.energyPoints)!) / 24 * 100))%"
            self.resourcesLabel.text = "\(Int(Double((user?.resourcesPoints)!) / 18 * 100))%"
            self.transportationLabel.text = "\(Int(Double((user?.transportationPoints)!) / 18 * 100))%"
            
            self.energy = (user?.energyPoints)!
            print(self.energy)
            
            self.animateCircle()
            self.animateCircleLeft()
            self.animateCircleMiddle()
            self.animateCircleRight()
        }
    }
    //-----------------------OVERALL[START]-----------------------
    private func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 130, startAngle: CGFloat.pi, endAngle: 0, clockwise: true)
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = 25
        layer.fillColor = fillColor.cgColor
        layer.lineCap = kCALineCapRound
        layer.position = CGPoint(x: overallView.bounds.midX, y: overallView.bounds.midY + 50)
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
        
        let num: Float = Float((user?.quizScore ?? 0))/60
        basicAnimation.toValue = num
        
        basicAnimation.duration = 2
        
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
    //-----------------------OVERALL[ENDS]-----------------------
    
    //-----------------------LEFT BAR [+START]-----------------------
    fileprivate func animateCircleLeft() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        let num: Float = Float((user?.energyPoints ?? 0))/24.0
        basicAnimation.toValue = num
        basicAnimation.duration = 2
        
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayerLeft.add(basicAnimation, forKey: "usSoBasic")
    }
    
    private func createCircleshapeLayerLeft(strokeColor: UIColor, fillColor: UIColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 30, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = 15
        layer.fillColor = fillColor.cgColor
        layer.lineCap = kCALineCapRound
        layer.position = CGPoint(x: leftView.bounds.midX, y: leftView.bounds.midY)

        return layer
    }
    private func setupCircleLayersLeft() {
        
        let trackLayer = createCircleshapeLayerLeft(strokeColor: UIColor(red: 76/255, green: 217/255, blue: 250/255, alpha: 1), fillColor: .clear)
        leftView.layer.addSublayer(trackLayer)
        
        shapeLayerLeft = createCircleshapeLayerLeft(strokeColor: UIColor(red: 118/255, green: 214/255, blue: 113/255, alpha: 1), fillColor: .clear)
        
        shapeLayerLeft.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        shapeLayerLeft.strokeEnd = 0
        leftView.layer.addSublayer(shapeLayerLeft)
    }
    //-----------------------LEFT [END]-----------------------
    
    //-----------------------MIDDLE [START]-----------------------
    fileprivate func animateCircleMiddle() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        let num: Float = Float((user?.transportationPoints ?? 0))/18.0
        basicAnimation.toValue = num
        
        basicAnimation.duration = 2
        
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayerMiddle.add(basicAnimation, forKey: "usSoBasic")
    }
    
    private func createCircleshapeLayerMiddle(strokeColor: UIColor, fillColor: UIColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 30, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = 15
        layer.fillColor = fillColor.cgColor
        layer.lineCap = kCALineCapRound
        layer.position = CGPoint(x: middleView.bounds.midX, y: middleView.bounds.midY)

        return layer
    }
    private func setupCircleLayersMiddle() {
        
        let trackLayer = createCircleshapeLayerMiddle(strokeColor: UIColor(red: 76/255, green: 217/255, blue: 250/255, alpha: 1), fillColor: .clear)
        middleView.layer.addSublayer(trackLayer)
        
        shapeLayerMiddle = createCircleshapeLayerMiddle(strokeColor: UIColor(red: 118/255, green: 214/255, blue: 113/255, alpha: 1), fillColor: .clear)
        
        shapeLayerMiddle.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        shapeLayerMiddle.strokeEnd = 0
        middleView.layer.addSublayer(shapeLayerMiddle)
    }
    //-----------------------MIDDLE [END]-----------------------
    
    //-----------------------RIGHT [START]-----------------------
    fileprivate func animateCircleRight() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        let num: Float = Float((user?.resourcesPoints ?? 0))/18.0
        basicAnimation.toValue = num
        
        basicAnimation.duration = 2
        
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayerRight.add(basicAnimation, forKey: "usSoBasic")
    }
    
    private func createCircleshapeLayerRight(strokeColor: UIColor, fillColor: UIColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 30, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = 15
        layer.fillColor = fillColor.cgColor
        layer.lineCap = kCALineCapRound
        layer.position = CGPoint(x: rightView.bounds.midX, y: rightView.bounds.midY)

        return layer
    }
    private func setupCircleLayersRight() {
        
        let trackLayer = createCircleshapeLayerRight(strokeColor: UIColor(red: 76/255, green: 217/255, blue: 250/255, alpha: 1), fillColor: .clear)
        rightView.layer.addSublayer(trackLayer)
        
        shapeLayerRight = createCircleshapeLayerRight(strokeColor: UIColor(red: 118/255, green: 214/255, blue: 113/255, alpha: 1), fillColor: .clear)
        
        shapeLayerRight.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        shapeLayerRight.strokeEnd = 0
        rightView.layer.addSublayer(shapeLayerRight)
    }
    //-----------------------RIGHT [END]-----------------------
    
}















