//
//  GoalsTableViewCell.swift
//  Purchase Goal
//
//  Created by Gideon Bedzrah on 13/10/2020.
//

import UIKit

class GoalsTableViewCell: UITableViewCell {

    // Product Information
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var productVariantOne: UILabel!
    @IBOutlet weak var productVariantTwo: UILabel!
    @IBOutlet weak var progressRingView: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    //Payment Information
    @IBOutlet weak var amountDue: UILabel!
    @IBOutlet weak var daysLeft: UILabel!
    
    let circleShape = CAShapeLayer()
    
    var setGoalDetails: GoalsModel? {
        didSet {
            brandLabel.text = setGoalDetails?.brandName
            productLabel.text = setGoalDetails?.productName
            amountDue.text = "GHS \(setGoalDetails!.installmentAmount)"
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Bezier Path
        
//        let center = progressRingView.center
        let centerTwo = CGPoint(x: progressRingView.frame.size.width/2, y: progressRingView.frame.size.height/2)
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: progressRingView.frame.width/2.5, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        let path = circularPath.cgPath
        
        // Track layer
        let trackLayer = CAShapeLayer()
        trackLayer.path = path
        trackLayer.strokeColor = UIColor.systemGray5.cgColor
        trackLayer.lineWidth = 15
//        trackLayer.lineCap = .round
        trackLayer.position = centerTwo
        trackLayer.fillColor = UIColor.clear.cgColor
        progressRingView.layer.addSublayer(trackLayer)
        
        
        // Progress layer
        circleShape.path = path
        circleShape.strokeColor = UIColor(displayP3Red: 57/255, green: 156/255, blue: 168/255, alpha: 1).cgColor
        circleShape.lineWidth = 15
        circleShape.lineCap = .round
        circleShape.fillColor = UIColor.clear.cgColor
        circleShape.transform = CATransform3DMakeRotation(-CGFloat.pi/2, 0, 0, 1)
        circleShape.position = centerTwo
        circleShape.strokeEnd = 0.5
        
        progressRingView.layer.addSublayer(circleShape)
        
        
    }

    func animate() -> CABasicAnimation {
        
        let ringAnimation = CABasicAnimation(keyPath: "strokeEnd")
        ringAnimation.toValue = 1
        ringAnimation.duration = 2
        
        ringAnimation.fillMode = .forwards
        ringAnimation.isRemovedOnCompletion = false
        
        return ringAnimation
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func payButtonTapped(_ sender: UIButton) {
        
//        let alert = UIAlertController(title: "Make payment", message: "you are closer to achieving your goal", preferredStyle: .alert)
//
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        circleShape.add(animate(), forKey: "animatingCircle")
    }
    
    
}
