//
//  MoreDealsCollectionViewCell.swift
//  Purchase Goal
//
//  Created by Gideon Bedzrah on 03/11/2020.
//

import UIKit

class MoreDealsCollectionViewCell: UICollectionViewCell {
    
        @IBOutlet weak var productImage: UIImageView!
        @IBOutlet weak var productName: UILabel!
        
        @IBOutlet weak var productPrice: UILabel!
        @IBOutlet weak var brandLabel: UILabel!
        @IBOutlet weak var discountLabel: UILabel!
        
        var setProductDetails: ProductModel? {
            didSet {
                
                productImage.image = UIImage(named: setProductDetails?.ProductImage ?? "")
                productName.text = setProductDetails?.ProductName
                brandLabel.text = setProductDetails?.ProductBrand
                productPrice.text = "GHS \(setProductDetails?.ProductPrice ?? 0)"
                discountLabel.text = "\(setProductDetails?.ProductDiscount ?? 0)%"
            }
        }
        
        override class func awakeFromNib() {
            super.awakeFromNib()
        }
        
        
        override func layoutSubviews() {
            super.layoutSubviews()
            layer.cornerRadius = 10

        }
 
}
