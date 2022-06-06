//
//  ProductModel.swift
//  Purchase Goal
//
//  Created by Gideon Bedzrah on 18/10/2020.
//

import Foundation

struct ProductModel {
    var ProductBrand: String
    var ProductName: String
    var ProductImage: String
    var productSubtitle: String
    var ProductPrice: Int
    var ProductDiscount: Int
    var stock: Bool
    var installmentAvailability: Bool
    var options: [Options]?
    var summary: Summary
}

struct Options {
    let name: String
    let selected: Bool
    let extraCharge: Int?
}

struct Summary {
    let productFeatureOne: String
    let productFeatureTwo: String
    var DiscountDescription: String?
    var installmentInfo: String?
}
