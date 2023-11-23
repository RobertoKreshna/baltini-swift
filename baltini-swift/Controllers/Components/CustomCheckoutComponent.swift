//
//  CustomCheckoutComponent.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 23/11/23.
//

import UIKit

class CustomCheckoutComponent {
    
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
}
