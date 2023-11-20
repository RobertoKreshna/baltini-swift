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
    
    static func createCartItemCard(product: ProductDetail, qty: Int, variant: Int, deletePressed: UIAction, minPressed: UIAction, plusPressed: UIAction, qtyLabel: PaddingLabel) -> UIStackView{
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
        card.setCustomSpacing(8, after: itemImageView)
        
        let labelStack = createCartItemLabelStack(
            brand: product.brand,
            name: product.name,
            variants: product.variants![variant],
            price: String(describing: product.price[variant]),
            qty: qty,
            minPressed: minPressed,
            plusPressed: plusPressed,
            qtyLabel: qtyLabel
        )
        
        card.addArrangedSubview(labelStack)
        
        let deleteIcon = UIButton(type: .system)
        deleteIcon.setImage(UIImage(named: "icDelete")?.withRenderingMode(.alwaysOriginal), for: .normal)
        deleteIcon.addAction(deletePressed, for: .touchUpInside)
        deleteIcon.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        card.addArrangedSubview(deleteIcon)
        
        return card
    }
    
    static func createCartItemLabelStack(brand: String, name: String, variants: String, price: String, qty: Int, minPressed: UIAction, plusPressed: UIAction, qtyLabel: PaddingLabel) -> UIStackView{
        let labelStack = UIStackView()
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        labelStack.axis = .vertical
        labelStack.alignment = .leading
        
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
        
        let quantityStack = createItemQuantityStack(qty: qty, minPressed: minPressed, plusPressed: plusPressed, qtyLabel: qtyLabel)
        
        labelStack.addArrangedSubview(brandLabel)
        labelStack.setCustomSpacing(4, after: brandLabel)
        labelStack.addArrangedSubview(nameLabel)
        labelStack.setCustomSpacing(4, after: nameLabel)
        labelStack.addArrangedSubview(variantLabel)
        labelStack.setCustomSpacing(8, after: variantLabel)
        labelStack.addArrangedSubview(priceLabel)
        labelStack.setCustomSpacing(8, after: priceLabel)
        labelStack.addArrangedSubview(quantityStack)
        
        return labelStack
    }
    
    static func createItemQuantityStack(qty: Int, minPressed: UIAction, plusPressed: UIAction, qtyLabel: PaddingLabel) -> UIStackView{
        let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        
        let qtyTitle = NSAttributedString(
            string: String(qty),
            attributes: [.font : UIFont(name: "Futura-Medium", size: 14)!, .foregroundColor : UIColor.black]
        )
        
        qtyLabel.attributedText = qtyTitle
        qtyLabel.topInset = 10
        qtyLabel.bottomInset = 10
        qtyLabel.leftInset = 20
        qtyLabel.rightInset = 20
        qtyLabel.layer.borderWidth = 1
        qtyLabel.layer.borderColor = UIColor.brandGray.cgColor
        
        let minButton = CustomButton.createQuantityButton(imageName: "icMin", isLeft: true, tapped: minPressed)
        let plusButton = CustomButton.createQuantityButton(imageName: "icPlus", isLeft: false, tapped: plusPressed)
        
        buttonStack.addArrangedSubview(minButton)
        buttonStack.addArrangedSubview(qtyLabel)
        buttonStack.addArrangedSubview(plusButton)
        
        return buttonStack
    }
}
