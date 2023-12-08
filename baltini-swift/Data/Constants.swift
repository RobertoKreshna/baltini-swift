//
//  Constants.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 01/11/23.
//

import Foundation

class Constants {
    static let productData: [Product] = [
        Product(imageName: "product_1", name: "Wind Jacket", brand: "Moschino", price: 672.00, isDisc: true, discPrice: 287.00, id: ""),
        Product(imageName: "product_2", name: "Jewelled Hobo Leather Shoulder Bag", brand: "Alexander McQueen", price: 2595.00, isDisc: true, discPrice: 1922.00, id: ""),
        Product(imageName: "product_3", name: "Sporty Jogger Pants", brand: "Ambush", price: 645.00, isDisc: true, discPrice: 259.00, id: ""),
        Product(imageName: "product_4", name: "Leopard Print Lace Detail Camisole Top", brand: "Just Cavalli", price: 202.00, isDisc: true, discPrice: 155.00, id: ""),
        Product(imageName: "product_5", name: "'Folding Packable' T-Shirt", brand: "Ambush", price: 411.00, isDisc: true, discPrice: 181.00, id: ""),
        Product(imageName: "product_6", name: "Denim Shorts", brand: "MSGM", price: 294.00, isDisc: false, discPrice: nil, id: ""),
        Product(imageName: "product_7", name: "Rainproof Wool Coats", brand: "Fabiana Filippi", price: 1339.00, isDisc: true, discPrice: 992.00, id: ""),
        Product(imageName: "product_8", name: "Paris Cut-Out Detail Mini Dress", brand: "Ami Alexandre Mattiussi", price: 800.00, isDisc: false, discPrice: nil, id: ""),
        Product(imageName: "product_9", name: "Purple Flowery Long Dress", brand: "H&M", price: 50.00, isDisc: true, discPrice: 37.00, id: ""),
        Product(imageName: "product_10", name: "Blue Basic Dress", brand: "Uniqlo", price: 50.00, isDisc: true, discPrice: 30.00, id: ""),
        Product(imageName: "product_11", name: "Reflection Party Dress", brand: "Zara", price: 125.00, isDisc: false, discPrice: nil, id: "")
    ]
    
    static let brandData: [ExclusiveBrand] = [
        ExclusiveBrand(imageName: "brandBanner1", name: "Alexander McQueen", desc: "The Alexander McQueen brand is renowned for its eccentricity and constancy as a high fashion innovator. The company has constantly adopted a gothic, sensual, dark look that is essentially what makes it famous."),
        ExclusiveBrand(imageName: "brandBanner2", name: "Dolce & Gabbana", desc: "Italian designers Domenico Dolce and Stefano Gabbana established the opulent Dolce & Gabbana fashion brand in Legnano in 1985. They debuted their leotard collection in 1988, then in 1989 they started creating swimwear and undergarments."),
        ExclusiveBrand(imageName: "brandBanner3", name: "Versace", desc: "Versace gained recognition on a global scale for his extravagant designs, breathtaking theatrical costumes, and cutting-edge menswear design. Versace's fashion incorporated overt eroticism along with elegant classicism.")
    ]
    
    static let magazinesData: [Magazine] = [
        Magazine(
            imageName: "magazine1",
            title: "Is Imperfect The New Perfect?",
            date: "Mar 01, 2023",
            quotes: "The Industry has hit peak archive, as designers themselves are scooping up their own work left and right and reissuing their greatest hits.",
            by: "RK",
            desc: "Fashion has officially become infatuated with the idea of archives. It’s wildly ubiquitous; now as common as a pair of jeans or an old leather belt stashed in the back of your closet. From people on TikTok marveling over their personal collections and labeling items down to the minute details of exact season and runway look number, to designers themselves diligently hunting down their own work in the secondhand market, it surpasses clothing and garments that are simply vintage, and is more specifically linked to extremely rare runway pieces. In the world of archive fashion, everyone is a collector—but even the world’s top designers can’t get their hands on all their goods. Earlier last year, Anna Sui came across a gray crushed velvet and fur-trimmed halter dress from her fall 1998 collection for sale on Poshmark and immediately DMed Casey Jackson, the blogger behind Seek the Finds, who posted it. “Hi this is Anna Sui. I saw you sold this already but I was wondering if it would be possible for me to buy it instead? We don’t have this sample and it would mean a lot for me to have it in my archive,” she wrote. The conversation went viral on Twitter. Just a few months later, for her resort 2023 collection, she reissued the infamous dress. “It’s strange; I never really looked back, because we were always so busy,” Sui says. “You never have time to really reflect. A lot of the clothes went from the showroom right into storage or garment bags. We never looked at them again.”us in these matters."
        ),
        Magazine(
            imageName: "magazine2", 
            title: "Why Is Fashion so Obsessed With Itself?",
            date: "Feb 01, 2023",
            quotes: "Fashions fade, style is eternal",
            by: "Roberto",
            desc: "Fashion has officially become infatuated with the idea of archives. It’s wildly ubiquitous; now as common as a pair of jeans or an old leather belt stashed in the back of your closet. From people on TikTok marveling over their personal collections and labeling items down to the minute details of exact season and runway look number, to designers themselves diligently hunting down their own work in the secondhand market, it surpasses clothing and garments that are simply vintage, and is more specifically linked to extremely rare runway pieces. In the world of archive fashion, everyone is a collector—but even the world’s top designers can’t get their hands on all their goods. Earlier last year, Anna Sui came across a gray crushed velvet and fur-trimmed halter dress from her fall 1998 collection for sale on Poshmark and immediately DMed Casey Jackson, the blogger behind Seek the Finds, who posted it. “Hi this is Anna Sui. I saw you sold this already but I was wondering if it would be possible for me to buy it instead? We don’t have this sample and it would mean a lot for me to have it in my archive,” she wrote. The conversation went viral on Twitter. Just a few months later, for her resort 2023 collection, she reissued the infamous dress. “It’s strange; I never really looked back, because we were always so busy,” Sui says. “You never have time to really reflect. A lot of the clothes went from the showroom right into storage or garment bags. We never looked at them again.”us in these matters."
        ),
        Magazine(
            imageName: "magazine3", 
            title: "Corset Is One Of The Biggest Trends Of 2022", 
            date: "Feb 01, 2023",
            quotes: "I don't do fashion, i am fashion",
            by: "Kreshna",
            desc: "Fashion has officially become infatuated with the idea of archives. It’s wildly ubiquitous; now as common as a pair of jeans or an old leather belt stashed in the back of your closet. From people on TikTok marveling over their personal collections and labeling items down to the minute details of exact season and runway look number, to designers themselves diligently hunting down their own work in the secondhand market, it surpasses clothing and garments that are simply vintage, and is more specifically linked to extremely rare runway pieces. In the world of archive fashion, everyone is a collector—but even the world’s top designers can’t get their hands on all their goods. Earlier last year, Anna Sui came across a gray crushed velvet and fur-trimmed halter dress from her fall 1998 collection for sale on Poshmark and immediately DMed Casey Jackson, the blogger behind Seek the Finds, who posted it. “Hi this is Anna Sui. I saw you sold this already but I was wondering if it would be possible for me to buy it instead? We don’t have this sample and it would mean a lot for me to have it in my archive,” she wrote. The conversation went viral on Twitter. Just a few months later, for her resort 2023 collection, she reissued the infamous dress. “It’s strange; I never really looked back, because we were always so busy,” Sui says. “You never have time to really reflect. A lot of the clothes went from the showroom right into storage or garment bags. We never looked at them again.”us in these matters."
        ),
        Magazine(
            imageName: "magazine4", 
            title: "Looked Back at How Hollywood Glamorous Celebrities Welcoming Christmas in Their Time", 
            date: "Des 01, 2022",
            quotes: "Buy less, choose well, make it last",
            by: "roberto kreshna",
            desc: "Fashion has officially become infatuated with the idea of archives. It’s wildly ubiquitous; now as common as a pair of jeans or an old leather belt stashed in the back of your closet. From people on TikTok marveling over their personal collections and labeling items down to the minute details of exact season and runway look number, to designers themselves diligently hunting down their own work in the secondhand market, it surpasses clothing and garments that are simply vintage, and is more specifically linked to extremely rare runway pieces. In the world of archive fashion, everyone is a collector—but even the world’s top designers can’t get their hands on all their goods. Earlier last year, Anna Sui came across a gray crushed velvet and fur-trimmed halter dress from her fall 1998 collection for sale on Poshmark and immediately DMed Casey Jackson, the blogger behind Seek the Finds, who posted it. “Hi this is Anna Sui. I saw you sold this already but I was wondering if it would be possible for me to buy it instead? We don’t have this sample and it would mean a lot for me to have it in my archive,” she wrote. The conversation went viral on Twitter. Just a few months later, for her resort 2023 collection, she reissued the infamous dress. “It’s strange; I never really looked back, because we were always so busy,” Sui says. “You never have time to really reflect. A lot of the clothes went from the showroom right into storage or garment bags. We never looked at them again.”us in these matters."
        )
    ]
    
    static let shippingOptionsTitle = [
        "Standart International Shipping (7-10 Business Days) Import Duties & Tax Included",
        "Express International Shipping (3-5 Business Days) Import Duties & Tax Included",
        "Next Day International Shipping (1-2 Business Days) Import Duties & Tax Included"
    ]
    static let shippingOptionsDesc = [
        "11.00 Shipping\n$15.00 Import Duty & Taxes", "$12.00 Shipping\n$16.00 Import Duty & Taxes", "$13.00 Shipping\n$17.00 Import Duty & Taxes"
    ]
    static let shippingTotalCost = [26.00, 28.00, 30.00]
    static let shippingCost = [11.00, 12.00, 13.00]
    static let importTaxesCost = [15.00, 16.00, 17.00]
    static let estTaxesCost = [12.75, 13.60, 14.45]
    
    static let paymentOptions = ["Credit Card", "Shop pay - Pay in full or in installments", "AfterPay", "Klarna - Flexible payments", "NihaoPay"]
    static let paymentOptionsLogo = [
        ["paymentCC1","paymentCC2","paymentCC3","paymentCC4"],
        ["paymentShopPay"],
        ["paymentAfterPay"],
        ["paymentKlarna"],
        ["paymentNihao1", "paymentNihao2", "paymentNihao3"]
    ]
    
    static let key: String = "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"
}
