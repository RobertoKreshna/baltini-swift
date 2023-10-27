//
//  CustomButton.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 27/10/23.
//

import UIKit

class CustomButton {
    static func createUnderlinedButton(title: String, action: UIAction) -> UIButton{
        let attributedTitle = NSAttributedString(
            string: title,
            attributes: [.font: UIFont(name: "Futura-Medium", size: 12)!, .foregroundColor : UIColor.black, .underlineStyle : 1]
        )
        let button = UIButton(type: .system)
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addAction(action, for: .touchUpInside)
        return button
    }
    
    static func createWhiteButton(title: String, action: UIAction) -> UIButton{
        let button = UIButton(type: .system)
        let attributedTitle = NSAttributedString(
            string: title,
            attributes: [.font: UIFont(name: "Futura-Medium", size: 14)!, .foregroundColor : UIColor.black]
        )
        button.setAttributedTitle(attributedTitle,for: .normal)
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 4
        //add padding
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 0)
        button.configuration = configuration
        //add action
        button.addAction(action, for: .touchUpInside)
        return button
    }
    
    static func createBlackButton(title: String, action: UIAction) -> UIButton{
        let button = UIButton(type: .system)
        let attributedTitle = NSAttributedString(
            string: title,
            attributes: [.font: UIFont(name: "Futura-Medium", size: 14)!, .foregroundColor : UIColor.white]
        )
        button.setAttributedTitle(attributedTitle,for: .normal)
        button.backgroundColor = .black
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 4
        //add padding
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 0)
        button.configuration = configuration
        //add action
        button.addAction(action, for: .touchUpInside)
        return button
    }
}
