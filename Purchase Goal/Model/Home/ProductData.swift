//
//  ProductData.swift
//  Purchase Goal
//
//  Created by Gideon Bedzrah on 18/10/2020.
//

import Foundation

struct ProductData {
    
    static let data: [ProductModel] = [
        ProductModel(ProductBrand: "Apple", ProductName: "AirPods Pro", ProductImage: "AirpodsPro", productSubtitle: "Bluetooth headphone device by Apple", ProductPrice: 1700, ProductDiscount: 20, stock: true, installmentAvailability: true, summary: SummaryData.product1),
        
        ProductModel(ProductBrand: "Sony", ProductName: "NBA 2k21", ProductImage: "NBA2K21", productSubtitle: "nba simulator for Playstation", ProductPrice: 320, ProductDiscount: 0, stock: false, installmentAvailability: true, summary: SummaryData.product1),
        
        ProductModel(ProductBrand: "Sony", ProductName: "PS4 Pro", ProductImage: "PS4Pro", productSubtitle: "Current generation game console with 4k capabilities", ProductPrice: 2700, ProductDiscount: 30, stock: false, installmentAvailability: true, summary: SummaryData.product1),
        
        ProductModel(ProductBrand: "Microsoft", ProductName: "Surface Pro 7", ProductImage: "SurfacePro7", productSubtitle: "A laptop for students by Microsft", ProductPrice: 3000, ProductDiscount: 10, stock: true, installmentAvailability: true, summary: SummaryData.product1)
        
    ]
}
