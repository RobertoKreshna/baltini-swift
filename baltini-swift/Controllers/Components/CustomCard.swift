//
//  CustomCard.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 01/11/23.
//

import UIKit

class CustomCard {
    
    static func createItemCard(product: Product, loadImage: Bool = true) -> UIStackView{
        let individualItemStack = UIStackView()
        individualItemStack.axis = .vertical
        individualItemStack.spacing = 4
        individualItemStack.alignment = .center
        
        let itemImageView = UIImageView()
        if(loadImage){
            if(product.imageName == ""){
                itemImageView.image = UIImage(named: "productPlaceholder")
            } else {
                itemImageView.imageFromServerURL(product.imageName, placeHolder: UIImage(named: "productPlaceholder"))
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
        itemBrandLabel.textAlignment = .center
        
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
        addPriceStack(to: individualItemStack, item: product)
        
        itemImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        individualItemStack.isUserInteractionEnabled = true
        let gestureRecognizer = ItemTapped(target: self, action: #selector(self.tapped(_:)), id: product.id ?? "")
        individualItemStack.addGestureRecognizer(gestureRecognizer)
        
        return individualItemStack
    }
    
    static private func addPriceStack(to stack: UIStackView, item: Product){
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
    
    @objc static private func tapped(_ recognizer: ItemTapped){
        print("ID")
        print(recognizer.id)
    }
}
