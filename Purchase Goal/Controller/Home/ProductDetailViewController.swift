//
//  ProductDetailViewController.swift
//  Purchase Goal
//
//  Created by Gideon Bedzrah on 17/10/2020.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var productInfoView: UIView!
    
    //Brand and Product Information
    @IBOutlet weak var productBrand: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productSummary: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    //Discount Available to the User
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var discountLabel: UILabel!
    
    
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var costSummary: UITextView!
    @IBOutlet weak var totalServiceCost: UILabel!
    
    
    // Options Available to the user
    @IBOutlet weak var optionsView: UIView!
    @IBOutlet weak var optionsLabel: UILabel!
    @IBOutlet weak var optionOne: UIButton!
    @IBOutlet weak var optionTwo: UIButton!
    @IBOutlet weak var optionThree: UIButton!
    
    var installmentSettings = false
    var savedPrice: Double!
    var installmentCost: Double?
    var seletedCell: ProductModel? {
        
        didSet {
            savedPrice = Double(seletedCell!.ProductPrice)
        }
    }
    
    var discountDescription: String?
    
    func updateSummary(_ productInformation: ProductModel) {
        
        costSummary.text = "•\(productInformation.summary.productFeatureOne). \n• \(productInformation.summary.productFeatureTwo)."
        
        if discountDescription != nil {
            costSummary.text += "\n• \(discountDescription!)."
        }
//
        if let install = productInformation.summary.installmentInfo{
            costSummary.text += "\n• \(install)."
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstOptionSelected()
        
        // Passing Cell Data
        if var productInformation = seletedCell {
            
           // initailizing passed data
            productImage.image = UIImage(named: "\(productInformation.ProductImage)")
            productName.text = productInformation.ProductName
            productSummary.text = productInformation.productSubtitle
            productPrice.text = "GHS \(productInformation.ProductPrice)"
            productBrand.text = productInformation.ProductBrand
            
            
            // stock label check
            if productInformation.stock {
                stockLabel.text = "~ in stock"
                stockLabel.textColor = UIColor(named: "MainColor")
            }else {
                stockLabel.text = "~ out of stock"
                stockLabel.textColor = UIColor.red
            }
            
            // Text view attributes
//            costSummary.text = "• AirPods Pro with wireless charging capabilities. \n• Can go up to 5 hours on a single charge"
            
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 10
            let attributes = [NSAttributedString.Key.paragraphStyle : style,
                              .font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.thin),
                              .foregroundColor: UIColor.label]
            costSummary.attributedText = NSAttributedString(string: costSummary.text, attributes:attributes as [NSAttributedString.Key : Any])
            
            
            // Calculating the discount
            if productInformation.ProductDiscount != 0 {
                
                let discountedPrice = Double(savedPrice) * (1 - Double(productInformation.ProductDiscount)/100)
                totalServiceCost.text = "Total: GHS \(String(format: "%.2f", discountedPrice))"
                savedPrice = discountedPrice
                productInformation.summary.DiscountDescription = "\(productInformation.ProductDiscount)% has been taken off the price of the product"
                discountDescription = productInformation.summary.DiscountDescription
                discountLabel.text = "-\(productInformation.ProductDiscount)%"
            }else {
                totalServiceCost.text = "Total: GHS \(String(format: "%.2f", savedPrice))"
                discountView.isHidden = true
                productInformation.summary.DiscountDescription = nil
            }
            
            
            updateSummary(productInformation)
        }
        
        
        
        

        
    }
    
    @IBAction func optionsButtonTapped(_ sender: UIButton) {
        
        switch sender {
        case optionOne:
            firstOptionSelected()
        case optionTwo:
            secondOptionSelected()
        case optionThree:
            thirdOptionSelected()
        default:
            print("no option is selected")
        }
    }
    
    
    @IBAction func installmentButtonTapped(_ sender: UIButton) {
        
        
        sender.isSelected = !sender.isSelected
        
        sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        
        if sender.isSelected {
            installmentSettings = true
            if let price = seletedCell?.ProductPrice {
               let intialDeposit = Double(price) * 0.4
                installmentCost = intialDeposit
                totalServiceCost.text = "Total: GHS \(String(format: "%.2f", intialDeposit))"
            }
        
            if var productInformation = seletedCell {
                productInformation.summary.installmentInfo = "Make a down payment of 40% to start your goal"
                updateSummary(productInformation)
            }
        } else {
            
            if var productInformation = seletedCell {
                productInformation.summary.installmentInfo = nil
                updateSummary(productInformation)
            }
            
            totalServiceCost.text = "Total: GHS \(String(format: "%.2f", savedPrice))"
            installmentSettings = false
        }
        

        
    }
    
    @IBAction func purchaseButtonTapped(_ sender: UIButton) {
        let slideVC = FinanceDetailController()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        slideVC.productInformation = seletedCell
        slideVC.installmentSettings = self.installmentSettings
        slideVC.installment = installmentCost
        slideVC.totalProductPrice = savedPrice
        self.present(slideVC, animated: true, completion: nil)
        
        
    }

    
    private func firstOptionSelected() {
        optionOne.isSelected = true
        optionOne.backgroundColor = UIColor(named: "MainColor")
        
        optionTwo.isSelected = false
        optionTwo.backgroundColor = .systemBackground
        
        optionThree.isSelected = false
        optionThree.backgroundColor = .systemBackground
    }
    private func secondOptionSelected() {
        optionTwo.isSelected = true
        optionTwo.backgroundColor = UIColor(named: "MainColor")
        
        optionOne.isSelected = false
        optionOne.backgroundColor = .systemBackground
        
        optionThree.isSelected = false
        optionThree.backgroundColor = .systemBackground
        
    }
    private func thirdOptionSelected() {
        optionThree.isSelected = true
        optionThree.backgroundColor = UIColor(named: "MainColor")
        
        optionOne.isSelected = false
        optionOne.backgroundColor = .systemBackground
        
        optionTwo.isSelected = false
        optionTwo.backgroundColor = .systemBackground
    }
    
}


extension ProductDetailViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
