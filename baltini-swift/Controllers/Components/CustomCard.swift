//
//  CustomCard.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 01/11/23.
//

import UIKit

class CustomCard {
    
    static func createItemCard(product: Product, loadImage: Bool = true) -> UIStackView{
        let blueprint = CustomCard()
        
        let individualItemStack = UIStackView()
        individualItemStack.axis = .vertical
        individualItemStack.spacing = 4
        individualItemStack.alignment = .center
        
        let itemImageView = UIImageView()
        if(loadImage){
            if(product.imageName == ""){
                itemImageView.image = UIImage(named: "productPlaceholder")
            } else {
                let url = URL(string: product.imageName)
                let data = try? Data(contentsOf: url!)
                
                if let imageData = data {
                    itemImageView.image = UIImage(data: imageData)
                }
            }
        } else {
            itemImageView.image = UIImage(named: product.imageName)
        }
        
        let itemBrandLabel = UILabel()
        itemBrandLabel.attributedText = NSAttributedString(
            string: product.brand.uppercased(),
            attributes: [
                .font : UIFont(name: "Futura-Medium", size: 14)!,
            ]
        )
        
        let itemNameLabel = UILabel()
        itemNameLabel.attributedText = NSAttributedString(
            string: product.name,
            attributes: [
                .font : UIFont(name: "Futura-Medium", size: 14)!,
                .foregroundColor : UIColor.black.withAlphaComponent(0.5)
            ]
        )
        itemNameLabel.numberOfLines = 3
        itemNameLabel.textAlignment = .center
        
        individualItemStack.addArrangedSubview(itemImageView)
        individualItemStack.addArrangedSubview(itemBrandLabel)
        individualItemStack.addArrangedSubview(itemNameLabel)
        blueprint.addPriceStack(to: individualItemStack, item: product)
        
        return individualItemStack
    }
    
    func addPriceStack(to stack: UIStackView, item: Product){
        let priceStack = UIStackView()
        priceStack.axis = .horizontal
        priceStack.spacing = 4
        
        let itemPriceLabel = UILabel()
        itemPriceLabel.attributedText = NSAttributedString(
            string: String(format: "$%.2f", item.price),
            attributes: [
                .font : UIFont(name: "Futura-Medium", size: 14)!,
                .foregroundColor : UIColor.black.withAlphaComponent(0.5),
                .strikethroughStyle : item.isDisc ? 1 : 0,
            ]
        )
        
        priceStack.addArrangedSubview(itemPriceLabel)
        
        if(item.isDisc == true){
            let itemDiscPriceLabel = UILabel()
            itemDiscPriceLabel.attributedText = NSAttributedString(
                string: String(format: "$%.2f", item.discPrice!),
                attributes: [
                    .font : UIFont(name: "Futura-Medium", size: 14)!,
                    .foregroundColor : UIColor.brandRed
                ]
            )
            priceStack.addArrangedSubview(itemDiscPriceLabel)
        }
        
        stack.addArrangedSubview(priceStack)
    }
}
