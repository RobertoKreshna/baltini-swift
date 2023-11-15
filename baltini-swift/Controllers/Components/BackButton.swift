//
//  BackButton.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 26/10/23.
//

import UIKit


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
    
    
}
