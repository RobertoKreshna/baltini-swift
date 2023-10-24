//
//  StaticProductData.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 23/10/23.
//

import Foundation

struct Product {
    let imageName: String
    let name: String
    let brand: String
    let price: Double
    let isDisc: Bool
    let discPrice: Double?
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

struct const {
    static let productData: [Product] = [
        Product(imageName: "product_1", name: "Wind Jacket", brand: "Moschino", price: 672.00, isDisc: true, discPrice: 287.00),
        Product(imageName: "product_2", name: "Jewelled Hobo Leather Shoulder Bag", brand: "Alexander McQueen", price: 2595.00, isDisc: true, discPrice: 1922.00),
        Product(imageName: "product_3", name: "Sporty Jogger Pants", brand: "Ambush", price: 645.00, isDisc: true, discPrice: 259.00),
        Product(imageName: "product_4", name: "Leopard Print Lace Detail Camisole Top", brand: "Just Cavalli", price: 202.00, isDisc: true, discPrice: 155.00),
        Product(imageName: "product_5", name: "'Folding Packable' T-Shirt", brand: "Ambush", price: 411.00, isDisc: true, discPrice: 181.00),
        Product(imageName: "product_6", name: "Denim Shorts", brand: "MSGM", price: 294.00, isDisc: false, discPrice: nil),
        Product(imageName: "product_7", name: "Rainproof Wool Coats", brand: "Fabiana Filippi", price: 1339.00, isDisc: true, discPrice: 992.00),
        Product(imageName: "product_8", name: "Paris Cut-Out Detail Mini Dress", brand: "Ami Alexandre Mattiussi", price: 800.00, isDisc: false, discPrice: nil),
        Product(imageName: "product_9", name: "Purple Flowery Long Dress", brand: "H&M", price: 50.00, isDisc: true, discPrice: 37.00),
        Product(imageName: "product_10", name: "Blue Basic Dress", brand: "Uniqlo", price: 50.00, isDisc: true, discPrice: 30.00),
        Product(imageName: "product_11", name: "Reflection Party Dress", brand: "Zara", price: 125.00, isDisc: false, discPrice: nil)
    ]
    
    static let brandData: [ExclusiveBrand] = [
        ExclusiveBrand(imageName: "brandBanner1", name: "Alexander McQueen", desc: "The Alexander McQueen brand is renowned for its eccentricity and constancy as a high fashion innovator. The company has constantly adopted a gothic, sensual, dark look that is essentially what makes it famous."),
        ExclusiveBrand(imageName: "brandBanner2", name: "Dolce & Gabbana", desc: "Italian designers Domenico Dolce and Stefano Gabbana established the opulent Dolce & Gabbana fashion brand in Legnano in 1985. They debuted their leotard collection in 1988, then in 1989 they started creating swimwear and undergarments."),
        ExclusiveBrand(imageName: "brandBanner3", name: "Versace", desc: "Versace gained recognition on a global scale for his extravagant designs, breathtaking theatrical costumes, and cutting-edge menswear design. Versace's fashion incorporated overt eroticism along with elegant classicism.")
    ]
    
    static let magazinesData: [Magazine] = [
        Magazine(imageName: "magazine1", title: "Is Imperfect The New Perfect?", date: "Mar 01, 2023"),
        Magazine(imageName: "magazine2", title: "Why Is Fashion so Obsessed With Itself?", date: "Feb 01, 2023"),
        Magazine(imageName: "magazine3", title: "Corset Is One Of The Biggest Trends Of 2022", date: "Feb 01, 2023"),
        Magazine(imageName: "magazine4", title: "Looked Back at How Hollywood Glamorous Celebrities Welcoming Christmas in Their Time", date: "Des 01, 2022")
    ]
}
