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
    let id: String
    
    init(imageName: String, name: String, brand: String, price: Double, isDisc: Bool, discPrice: Double?, id: String) {
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
                name: (product["title"] as? String) ?? "",
                brand: (product["vendor"] as? String) ?? "",
                price: (productVariant?[0]["price"] as? NSString)?.doubleValue ?? 0,
                isDisc: false,
                discPrice: nil,
                id: String(describing: product["id"]!)
            )
            if(res == nil){ res = [Product]()}
            res?.append(productData)
        }
        return res
    }
}

class ProductDetail: Codable {
    let id: String
    let images: [String]
    let brand: String
    let name: String
    let variants : [String]?
    let price: [Double]
    let discPrice: [Double]?
    let tags : String?
    
    init(id: String, images: [String], brand: String, name: String, variants: [String]?, price: [Double], discPrice: [Double]?, tags: String?) {
        self.id = id
        self.images = images
        self.brand = brand
        self.name = name
        self.variants = variants
        self.price = price
        self.discPrice = discPrice
        self.tags = tags
    }
    
    static func fromJson(json: Dictionary<String, Any>) -> ProductDetail?{
        let product = json["product"] as! Dictionary<String, Any>
        let images = product["images"] as! [Dictionary<String, Any>]
        var imagesUrl = [String]()
        images.forEach { dict in imagesUrl.append(dict["src"] as! String) }
        let variants = product["variants"] as! [Dictionary<String, Any>]
        var prices = [Double]()
        var variantsTitle = [String]()
        variants.forEach { dict in prices.append((dict["price"] as! NSString).doubleValue); variantsTitle.append(String(describing: dict["title"]!)) }
        let res = ProductDetail(
            id: String(describing: product["id"]!),
            images: imagesUrl,
            brand: String(describing: product["vendor"]!),
            name: String(describing: product["title"]!),
            variants: variantsTitle,
            price: prices,
            discPrice: nil,
            tags: String(describing: product["body_html"]!)
        )
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
