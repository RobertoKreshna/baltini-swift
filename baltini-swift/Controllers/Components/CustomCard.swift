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
    
    static func createCartItemCard(product: ProductDetail, qty: Int, variant: Int, deletePressed: UIAction) -> UIStackView{
        let card = UIStackView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.alignment = .leading
        card.axis = .horizontal
        
        let itemImageView = UIImageView()
        if(product.images[0] == "http://placekitten.com/200/300"){
            itemImageView.image = UIImage(named: "productPlaceholder")
        } else {
            itemImageView.imageFromServerURL(product.images[0], placeHolder: UIImage(named: "productPlaceholder"))
        }
        
        card.addArrangedSubview(itemImageView)
        itemImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        itemImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        let labelStack = createCartItemLabelStack(
            brand: product.brand,
            name: product.name,
            variants: product.variants![variant],
            price: String(describing: product.price)
        )
        
        card.addArrangedSubview(labelStack)
        
        let deleteIcon = UIButton(type: .system)
        deleteIcon.setImage(UIImage(named: "icDelete")?.withRenderingMode(.alwaysOriginal), for: .normal)
        deleteIcon.addAction(deletePressed, for: .touchUpInside)
        deleteIcon.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        card.addArrangedSubview(deleteIcon)
        
        return card
    }
    
    static func createCartItemLabelStack(brand: String, name: String, variants: String, price: String) -> UIStackView{
        let labelStack = UIStackView()
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        labelStack.axis = .vertical
        
        let brandLabel = UILabel()
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        brandLabel.text = brand
        brandLabel.font = UIFont(name: "Futura-Bold", size: 14)!
        
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = name
        nameLabel.font = UIFont(name: "Futura-Medium", size: 14)!
        
        let variantLabel = UILabel()
        variantLabel.translatesAutoresizingMaskIntoConstraints = false
        variantLabel.text = variants
        variantLabel.font = UIFont(name: "Futura-Medium", size: 14)!
        variantLabel.textColor = .black.withAlphaComponent(0.5)
        
        let priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.text = price
        priceLabel.font = UIFont(name: "Futura-Medium", size: 14)!
        
        labelStack.addArrangedSubview(brandLabel)
        labelStack.setCustomSpacing(4, after: brandLabel)
        labelStack.addArrangedSubview(nameLabel)
        labelStack.setCustomSpacing(4, after: nameLabel)
        labelStack.addArrangedSubview(variantLabel)
        labelStack.setCustomSpacing(8, after: variantLabel)
        labelStack.addArrangedSubview(priceLabel)
        
        return labelStack
    }
}
