//
//  CartModel.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 10/11/23.
//

import Foundation

class Cart {
    var agreeTC: Bool = false
    var useProtect: Bool = false
    
    var products: [ProductDetail] = [ProductDetail]()
    var qty: [Int] = [Int]()
    var variantsIndex: [Int] = [Int]()
    
    var recentlyDeleted: ProductDetail? = nil
    var recentlyDeletedQty: Int? = nil
    var recentlyDeletedVariantsIndex: Int? = nil
}
