//
//  CustomCheckoutComponent.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 23/11/23.
//

import UIKit

class CustomCheckoutComponent {
    static func createAllProductCard(addTo stackView: UIStackView){
        let products = CommonStore.shared.getCartProducts()
        let qtyList = CommonStore.shared.getQty()
        let varIndexList = CommonStore.shared.getVariantsIndex()
        for i in 0 ... CommonStore.shared.getCartProductCount() - 1 {
            let card = CustomCard.createCheckoutItemCard(
                item: products[i],
                qty: qtyList[i],
                variantIndex: varIndexList[i]
            )
            
            stackView.addArrangedSubview(card)
            
            card.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
            card.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        }
    }
    
    static func createProtectCard() -> UIStackView {
        let card = UIStackView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.axis = .horizontal
        card.alignment = .center
        
        let imageView = UIImageView(image: UIImage(named: "imageProtect"))
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Shipping Protection"
        titleLabel.font = UIFont(name: "Futura-Bold", size: 14)
        titleLabel.textColor = .black
        let priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.text = "$22.00"
        priceLabel.font = UIFont(name: "Futura-Medium", size: 16)
        priceLabel.textColor = .black
        priceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        card.addArrangedSubview(imageView)
        card.setCustomSpacing(8, after: imageView)
        card.addArrangedSubview(titleLabel)
        card.addArrangedSubview(priceLabel)
        
        imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        return card
    }
    
    static func createCouponStack(owner: UITextFieldDelegate) -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .trailing
        
        let textfield = CustomTextfield.createTextfield(
            placeholder: "Gift card or discount code",
            isPassword: false,
            owner: owner,
            useDesc: false,
            lineLength: UIScreen.main.bounds.width * 287 / 375
        )
        
        let btn = CustomButton.createBlackImageButton(imageName: "icRight", tapped: UIAction(handler: { action in
            print("tapped")
        }))
        
        stack.addArrangedSubview(textfield)
        stack.setCustomSpacing(16, after: textfield)
        stack.addArrangedSubview(btn)
        
        return stack
    }
    
    static func createTotalCheckoutStack(leftTop: String, leftBot: String, buttonTitle: String, buttonTapped: UIAction) -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        
        let totalStack = createTotalStack(topString: leftTop, belowString: leftBot)
        let checkoutButton = CustomButton.createBlackButton(title: buttonTitle, action: buttonTapped)
        
        stack.addArrangedSubview(totalStack)
        stack.setCustomSpacing(17, after: totalStack)
        stack.addArrangedSubview(checkoutButton)
        
        checkoutButton.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 0.5).isActive = true
        
        return stack
    }
    
    static func createTotalCheckoutStack(leftTop: String, leftBotLabel: UILabel, buttonTitle: String, buttonTapped: UIAction) -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        
        let totalStack = createTotalStack(topString: leftTop, belowLabel: leftBotLabel)
        let checkoutButton = CustomButton.createBlackButton(title: buttonTitle, action: buttonTapped)
        
        stack.addArrangedSubview(totalStack)
        stack.setCustomSpacing(17, after: totalStack)
        stack.addArrangedSubview(checkoutButton)
        
        checkoutButton.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 0.5).isActive = true
        
        return stack
    }
    
    private static func createTotalStack(topString: String, belowString: String) -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .trailing
        
        let titleLabel = UILabel()
        titleLabel.text = topString
        titleLabel.font = UIFont(name: "Futura-Medium", size: 14)!
        
        let totalLabel = UILabel()
        totalLabel.text = belowString
        totalLabel.font = UIFont(name: "Futura-Bold", size: 14)!
        
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(totalLabel)
        
        return stack
    }
    
    private static func createTotalStack(topString: String, belowLabel: UILabel) -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .trailing
        
        let titleLabel = UILabel()
        titleLabel.text = topString
        titleLabel.font = UIFont(name: "Futura-Medium", size: 14)!
    
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(belowLabel)
        
        return stack
    }
}
