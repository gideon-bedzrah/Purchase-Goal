//
//  FinanceDetailController.swift
//  Purchase Goal
//
//  Created by Gideon Bedzrah on 02/11/2020.
//

import UIKit

class FinanceDetailController: UIViewController {

    @IBOutlet weak var weeklyMonthlyLabel: UILabel!
    
    @IBOutlet weak var initialAmount: UILabel!
    
    @IBOutlet weak var installmentAmount: UILabel!
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var minAmount: UILabel!
    @IBOutlet weak var maxAmount: UILabel!
    
    @IBOutlet weak var amountSlider: UISlider!
    
    @IBOutlet weak var durationLeft: UILabel!
    
    @IBOutlet weak var handleView: UIView!
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    var productInformation: ProductModel?
    var installment: Double?
    var totalProductPrice: Double?
    
    var installmentSettings: Bool?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        handleView.roundCorners(.allCorners, radius: 10)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        
        
        if let productInformation = self.productInformation {
            productName.text = productInformation.ProductName
            productImage.image =  UIImage(named: productInformation.ProductImage)
        }
        
        if !installmentSettings! {
            amountSlider.value = .greatestFiniteMagnitude
            amountSlider.isEnabled = false
            durationLeft.text = "0 weeks left"
        }
        
        if let installment = self.installment, let totalProductPrice = self.totalProductPrice {
            
            let periodicPayment = totalProductPrice - installment
            let periodicMin = periodicPayment / 12
            
            maxAmount.text = "GHS \(String(format: "%.2f", periodicPayment))"
            minAmount.text = "GHS \(String(format: "%.2f", periodicMin))"
            
            initialAmount.text = "GHS \(installment)"
            
        }
        
        
    }

    @IBAction func weeklyMonthlyOption(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            weeklyMonthlyLabel.text = "Weekly Amount"
        }else {
            weeklyMonthlyLabel.text = "Monthly Amount"
        }
    }
    
    @IBAction func amountSliderChanged(_ sender: UISlider) {
        
    }
    
    @IBAction func payButtonTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Payment Successfull", message: "You've made your first intallment payment for product name", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    

}

extension FinanceDetailController {
    
    
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}
