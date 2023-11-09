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
    
    static func createFilterButton(tapped: UIAction) -> UIButton{
        let attributedTitle = NSAttributedString(
            string: "FILTER",
            attributes: [.font: UIFont(name: "Futura-Medium", size: 14)!]
        )
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.contentHorizontalAlignment = .left
        button.setImage(UIImage(named: "icFilter"), for: .normal)
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
        configuration.imagePadding = 8
        button.configuration = configuration
        
        button.addAction(tapped, for: .touchUpInside)
        
        return button
    }
    
    static func createSortButton(value: String, tapped: UIAction) -> UIButton{
        let attributedTitle = NSAttributedString(
            string: "SORT",
            attributes: [.font: UIFont(name: "Futura-Medium", size: 10)!]
        )
        
        let attributedValue = AttributedString(
            value.uppercased(),
            attributes: AttributeContainer([.font: UIFont(name: "Futura-Medium", size: 14)!])
        )
        
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.contentHorizontalAlignment = .left
        button.setImage(UIImage(named: "icSort"), for: .normal)
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12)
        configuration.imagePadding = 8
        configuration.attributedSubtitle = attributedValue
        button.configuration = configuration
        
        button.addAction(tapped, for: .touchUpInside)
        
        return button
    }
    
    static func createSizeButton(value: String, selected: Bool, tapped: UIAction) -> UIButton {
        let button = UIButton(type: .system)
        let attributedTitle = NSAttributedString(
            string: value,
            attributes: [.font: UIFont(name: "Futura-Medium", size: 14)!, .foregroundColor : selected ? UIColor.white : UIColor.black]
        )
        button.setAttributedTitle(attributedTitle,for: .normal)
        button.backgroundColor = selected ? .black : .white
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 4
        //add padding
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        button.configuration = configuration
        //add action
        button.addAction(tapped, for: .touchUpInside)
        return button
    }
    
    static func createQuantityButton(imageName: String, isLeft: Bool, tapped: UIAction) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.brandGray.cgColor
        button.layer.cornerRadius = 4
        button.layer.maskedCorners = isLeft ? [.layerMinXMinYCorner, .layerMinXMaxYCorner] : [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        //add padding
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        button.configuration = configuration
        //add action
        button.addAction(tapped, for: .touchUpInside)
        return button
    }
}
