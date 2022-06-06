//
//  WeeklyGraphCollectionViewCell.swift
//  Purchase Goal
//
//  Created by Gideon Bedzrah on 14/10/2020.
//

import UIKit

class WeeklyGraphCollectionViewCell:
    UICollectionViewCell {
    
    @IBOutlet weak var weekLabel: UILabel!
    
    @IBOutlet weak var mLabel: UILabel!
    @IBOutlet weak var tLabel: UILabel!
    @IBOutlet weak var wLabel: UILabel!
    @IBOutlet weak var thLabel: UILabel!
    @IBOutlet weak var fLabel: UILabel!
    @IBOutlet weak var sLabel: UILabel!
    @IBOutlet weak var suLabel: UILabel!
    
    
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
                
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        outlineGraph(mLabel, paid: 70)
        outlineGraph(tLabel, paid: 50)
        outlineGraph(wLabel, paid: 250)
        outlineGraph(thLabel, paid: 40)
        outlineGraph(fLabel, paid: 90)
        outlineGraph(sLabel, paid: 200)
        outlineGraph(suLabel, paid: 80)
        
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        print(dateString)
        
        
        switch dateString {
        case "Monday":
            print("some")
        case "Wednesday":
            print("some")
        case "Friday":
            fLabel.layer.borderWidth = 2
            fLabel.layer.borderColor = UIColor(displayP3Red: 57/255, green: 156/255, blue: 168/255, alpha: 1).cgColor
            fLabel.layer.cornerRadius = fLabel.frame.height/2
        default:
            print("some")
        }
    }
    
    func outlineGraph(_ dayLabel: UILabel, paid: Double) {
        
        let amountToPay: Double = 320
        let barHeight: Double = 140
        
        var amount: Double {
            
            let conversion: Double = (paid / amountToPay) * barHeight
//            print(conversion)
            
            if paid > amountToPay {
                return barHeight
            }else {
                return conversion
            }
        }
        
        
        let shape = CAShapeLayer()
        
        
        let linePath = UIBezierPath(roundedRect: CGRect(x: dayLabel.bounds.width / 2.5 , y: -dayLabel.bounds.minY - CGFloat(barHeight) - 10  , width: 10, height: CGFloat(barHeight)), cornerRadius: 10)
        
        let graphPath = UIBezierPath(roundedRect: CGRect(x: dayLabel.bounds.width / 2.5 , y: linePath.bounds.maxY - CGFloat(amount), width: 10, height: CGFloat(amount)), cornerRadius: 10)
        
        
        shape.path = linePath.cgPath
        shape.fillColor = UIColor.systemGray5.cgColor
        
        
        
        let shape2 = CAShapeLayer()
         shape2.path = graphPath.cgPath
         shape2.fillColor = UIColor(displayP3Red: 57/255, green: 156/255, blue: 168/255, alpha: 1).cgColor
         
         shape.addSublayer(shape2)
        
        dayLabel.layer.addSublayer(shape)
        
    }
    
    
}
