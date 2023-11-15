//
//  BackButton.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 26/10/23.
//

import UIKit
import BadgeSwift


class BackButton {
    private static func createBackButton(icName: String, tapped: UIAction) -> UIButton {
        let imageButton = UIButton()
        imageButton.setImage(UIImage(named: icName), for: .normal)
        imageButton.addAction(tapped, for: .touchUpInside)
        
        return imageButton
    }
    
    private static func createBackButtonTitle(title: String) -> UILabel {
        let label = UILabel()
        let attributedText = NSAttributedString(
            string: title,
            attributes: [.font : UIFont(name: "Futura-Medium", size: 18)!, .foregroundColor : UIColor.black]
        )
        label.attributedText = attributedText
        return label
    }
    
    static func createBackButton(title:String, icName: String, usePadding: Bool, tapped: UIAction) -> UIStackView{
        let backButtonStack = UIStackView()
        backButtonStack.axis = .horizontal
        
        let backBtnLabel = createBackButtonTitle(title: title)
        let backBtnImage = createBackButton(icName: icName, tapped: tapped)
        
        backBtnImage.widthAnchor.constraint(equalToConstant: 36).isActive = true
        backBtnImage.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        if(usePadding){
            backButtonStack.isLayoutMarginsRelativeArrangement = true
            backButtonStack.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 22)
        }
        
        backButtonStack.addArrangedSubview(backBtnImage)
        backButtonStack.addArrangedSubview(backBtnLabel)
        
        return backButtonStack
    }
    
    private static func createCartButton(tapped: UIAction) -> UIButton{
        let imageButton = UIButton()
        imageButton.setImage(UIImage(named: "icCart"), for: .normal)
        imageButton.addAction(tapped, for: .touchUpInside)
        
        return imageButton
    }
    
    static func createSearchCartBar(owner: UITextFieldDelegate, cartTapped: UIAction) -> UIStackView{
        let searchCartBar = UIStackView()
        searchCartBar.translatesAutoresizingMaskIntoConstraints = false
        
        let searchTextfield = CustomTextfield.createSearchBar(owner: owner, placeholder: "Search...")
        let cart = createCartButton(tapped: cartTapped)
        cart.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        if(CommonStore.shared.getCartProductCount() != 0){
            let badge = BadgeSwift()
            badge.translatesAutoresizingMaskIntoConstraints = false
            cart.addSubview(badge)
            
            badge.text = String(describing: CommonStore.shared.getCartProductCount())
            badge.insets = CGSize(width: 2, height: 1)
            badge.font = UIFont(name: "Futura-Medium", size: 11)!
            badge.textColor = UIColor.white
            badge.badgeColor = UIColor.brandRed
            badge.cornerRadius = 10
            
            badge.bottomAnchor.constraint(equalTo: cart.bottomAnchor).isActive = true
            badge.rightAnchor.constraint(equalTo: cart.rightAnchor).isActive = true
        }

        searchCartBar.addArrangedSubview(searchTextfield)
        searchCartBar.setCustomSpacing(10, after: searchTextfield)
        searchCartBar.addArrangedSubview(cart)
        
        return searchCartBar
    }
    
    static func createBackSearchCartBar(owner: UITextFieldDelegate, backTapped: UIAction, cartTapped: UIAction) -> UIStackView {
        let backSearchCartBar = UIStackView()
        backSearchCartBar.isUserInteractionEnabled = true
        backSearchCartBar.translatesAutoresizingMaskIntoConstraints = false
        
        let backBtnImage = createBackButton(icName: "icBack", tapped: backTapped)
        backBtnImage.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        let searchTextfield = CustomTextfield.createSearchBar(owner: owner, placeholder: "Search...")
        let cart = createCartButton(tapped: cartTapped)
        cart.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        if(CommonStore.shared.getCartProductCount() != 0){
            let badge = BadgeSwift()
            badge.translatesAutoresizingMaskIntoConstraints = false
            cart.addSubview(badge)
            
            badge.text = String(describing: CommonStore.shared.getCartProductCount())
            badge.insets = CGSize(width: 2, height: 1)
            badge.font = UIFont(name: "Futura-Medium", size: 11)!
            badge.textColor = UIColor.white
            badge.badgeColor = UIColor.brandRed
            badge.cornerRadius = 10
            
            badge.bottomAnchor.constraint(equalTo: cart.bottomAnchor).isActive = true
            badge.rightAnchor.constraint(equalTo: cart.rightAnchor).isActive = true
        }
        
        backSearchCartBar.addArrangedSubview(backBtnImage)
        backSearchCartBar.addArrangedSubview(searchTextfield)
        backSearchCartBar.setCustomSpacing(10, after: searchTextfield)
        backSearchCartBar.addArrangedSubview(cart)
        
        return backSearchCartBar
    }
}
