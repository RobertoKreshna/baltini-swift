//
//  StaticProductData.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 23/10/23.
//

import Foundation

class Product: Codable {
    let imageName: String
    let name: String
    let brand: String
    let price: Double
    let isDisc: Bool
    let discPrice: Double?
    let id: String?
    
    init(imageName: String, name: String, brand: String, price: Double, isDisc: Bool, discPrice: Double?, id: String?) {
        self.imageName = imageName
        self.name = name
        self.brand = brand
        self.price = price
        self.isDisc = isDisc
        self.discPrice = discPrice
        self.id = id
    }
    
    static func fromJson(json: Dictionary<String, Any>) -> [Product]?{
        var res: [Product]? = nil
        let products = json["products"] as? [Dictionary<String, Any>]
        products?.forEach { product in
            let productVariant = product["variants"] as? [Dictionary<String, Any>]
            let productImage = product["image"] as? Dictionary<String, Any>
            let productData = Product(
                imageName: (productImage?["src"] as? String) ?? "",
                name: (product["vendor"] as? String) ?? "",
                brand: (product["vendor"] as? String) ?? "",
                price: (productVariant?[0]["price"] as? NSString)?.doubleValue ?? 0,
                isDisc: false,
                discPrice: nil,
                id: String(describing: product["id"])
            )
            if(res == nil){ res = [Product]()}
            res?.append(productData)
        }
        return res
    }
}

struct ExclusiveBrand {
    let imageName: String
    let name: String
    let desc: String
}

struct Magazine {
    let imageName: String
    let title: String
    let date: String
}
