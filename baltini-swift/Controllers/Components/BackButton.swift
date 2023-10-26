//
//  BackButton.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 26/10/23.
//

import UIKit


class BackButton {
    func createBackButton() -> UIButton {
        let imageButton = UIButton()
        imageButton.setImage(UIImage(named: "icBack"), for: .normal)
        
        return imageButton
    }
    
    func createBackButtonTitle(title: String) -> UILabel {
        let label = UILabel()
        let attributedText = NSAttributedString(
            string: title,
            attributes: [.font : UIFont(name: "Futura-Medium", size: 18)!, .foregroundColor : UIColor.black]
        )
        label.attributedText = attributedText
        return label
    }
    
    static func addBackButton(to stack: UIStackView, sender: UIViewController){
        let backButtonBlueprint = BackButton()

        let function = UIAction { action in sender.navigationController?.popViewController(animated: true) }
        
        let backButtonStack = UIStackView()
        backButtonStack.axis = .horizontal
        
        let backBtnLabel = backButtonBlueprint.createBackButtonTitle(title: "Login")
        let backBtnImage = backButtonBlueprint.createBackButton()
        backBtnImage.addAction(function, for: .touchUpInside)
        
        backBtnImage.widthAnchor.constraint(equalToConstant: 36).isActive = true
        backBtnImage.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        backButtonStack.addArrangedSubview(backBtnImage)
        backButtonStack.addArrangedSubview(backBtnLabel)
        
        stack.addArrangedSubview(backButtonStack)
        
        backButtonStack.topAnchor.constraint(equalTo: stack.topAnchor).isActive = true
        backButtonStack.leftAnchor.constraint(equalTo: stack.leftAnchor).isActive = true
    }
    
    
}
