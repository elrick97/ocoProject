/*
  Challenges.swift
  ocoProject

  Created by Ricardo Ramirez on 8/2/18.
  Copyright © 2018 Ricardo Ramirez. All rights reserved.
*/
import Foundation
import UIKit
import FirebaseDatabase

class ChallengesViewController: UIViewController {
    
    @IBOutlet weak var overallView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalSeedsTextLabel: UILabel!
    
    var seedCounter = Int()
    var counter: Int = 0
    var reachesThreePoints = Bool()
    var shapeLayer: CAShapeLayer!
    var pulsatingLayer: CAShapeLayer!
    var shapeLayerBackwards: CAShapeLayer!
    var indexPath: IndexPath!
    
    var user: User?
    
    var challenges = [Challenge]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 100.0
        
        challenges = CoreDataHelper.retrieveData()
        updateCounter()
        updateValues()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
        setupCircleLayers()
        animateCircle()
    }
    
    func updateCounter() {
        counter = 0
        updateValues()
        for challenge in challenges {
            if challenge.isCompleted {
                counter += 1
            }
        }
        if counter >= 3 {
            counter = 0
            for challenge in challenges {
                challenge.isCompleted = false
            }
            addSeed()
        }
        CoreDataHelper.saveData()
    }
    
    func updateValues()
    {
        let user = User.current.uid
        
        UserService.show(forUID: user) { (user) in
            self.user = user
            self.totalSeedsTextLabel.text = "\(user?.totalSeeds ?? 00)"
            self.seedCounter = (user?.totalSeeds)!
        }
    }
    private func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor) -> CAShapeLayer
    {
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
    private func setupCircleLayers()
    {
        pulsatingLayer = createCircleShapeLayer(strokeColor: .clear, fillColor: UIColor(red: 118/255, green: 214/255, blue: 113/255, alpha: 0.3))
        overallView.layer.addSublayer(pulsatingLayer)
        animatePulsatingLayer()
        
        let trackLayer = createCircleShapeLayer(strokeColor: UIColor(red: 76/255, green: 217/255, blue: 250/255, alpha: 1), fillColor: .white)
        overallView.layer.addSublayer(trackLayer)
        
        shapeLayer = createCircleShapeLayer(strokeColor: UIColor(red: 118/255, green: 214/255, blue: 113/255, alpha: 1), fillColor: .clear)
        
        shapeLayerBackwards = createCircleShapeLayer(strokeColor: UIColor(red: 76/255, green: 217/255, blue: 250/255, alpha: 1), fillColor: .clear)
        
        shapeLayer.transform = CATransform3DMakeRotation(CGFloat.pi / 1, 0, 0, 0)
        shapeLayer.strokeEnd = 0
        overallView.layer.addSublayer(shapeLayer)
    }
    private func animatePulsatingLayer()
    {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.toValue = 1.2
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        pulsatingLayer.add(animation, forKey: "pulsing")
    }
    
    fileprivate func animateCircle()
    {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        let num = Float(counter) / 3.0
        basicAnimation.toValue = num
        
        basicAnimation.duration = 2
        
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
    
    fileprivate func animateCircleBackwards()
    {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        
        basicAnimation.fillMode = kCAFillModeBackwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayerBackwards.add(basicAnimation, forKey: "urSoBasic")
    }
    
    func addSeed() {
        updateValues()
        let total = self.seedCounter + 1
        let user = User.current
        let ref = Database.database().reference().child("users").child(user.uid)
        ref.updateChildValues(["totalSeeds": total])
        user.totalSeeds = total
    }
    
}

extension ChallengesViewController : UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return challenges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "challengeTableViewCell", for: indexPath) as! ChallengeTableViewCell
        if challenges[indexPath.row].isCompleted  {
            cell.btnCheck.backgroundColor = UIColor.gray
            cell.btnCheck.isEnabled = false
        } else {
            cell.btnCheck.backgroundColor =  UIColor(red: 118/255, green: 214/255, blue: 113/255, alpha: 1)
            cell.btnCheck.isEnabled = true
        }
        if counter == 3 {
            cell.btnCheck.backgroundColor =  UIColor(red: 118/255, green: 214/255, blue: 113/255, alpha: 1)
            cell.btnCheck.isEnabled = true
        }
        cell.challengeTextLabel.text = challenges[indexPath.row].name
        cell.delegate = self
        return cell
    }
}

extension ChallengesViewController: MyCellDelegate
{
    func didTappedCheck(_ sender: ChallengeTableViewCell)
    {
        guard let tappedIndex = tableView.indexPath(for: sender) else {return}
        if counter == 3
        {
            animateCircle()
            print("reaches 3")
            animateCircleBackwards()
        } else {
            counter += 1
            let challenge = challenges[tappedIndex.row]
            challenge.isCompleted = !challenge.isCompleted
            CoreDataHelper.saveData()
            animateCircle()
            updateCounter()
            tableView.reloadData()
        }
    }
}
