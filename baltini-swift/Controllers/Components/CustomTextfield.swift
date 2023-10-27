//
//  CustomTextfield.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 26/10/23.
//

import UIKit

class CustomTextfield {
    static func createTextfield(placeholder: String, owner: UITextFieldDelegate) -> UITextField {
        let attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.font: UIFont(name: "Futura-Medium", size: 16)!, .foregroundColor: UIColor.black.withAlphaComponent(0.5)]
        )
        
        let textfield = UITextField()
        textfield.attributedPlaceholder = attributedPlaceholder
        textfield.font = UIFont(name: "Futura-Medium", size: 16)!
        textfield.textColor = .black
        textfield.borderStyle = .none
        textfield.delegate = owner
        
        return textfield
    }
    
    static func createTogglePasswordButton(textfield: UITextField) -> UIButton {
        let passwordToggleButton = UIButton()
        passwordToggleButton.setImage(UIImage(named: "icEyeClosed"), for: .normal)
        textfield.isSecureTextEntry = true
        
        passwordToggleButton.addAction(
            UIAction(handler: { action in
                passwordToggleButton.setImage(UIImage(named: textfield.isSecureTextEntry ? "icEyeOpen" : "icEyeClosed"), for: .normal)
                textfield.isSecureTextEntry = !textfield.isSecureTextEntry
            }),
            for: .touchUpInside
        )
        
        return passwordToggleButton
    }
    
    static func createLabel(placeholder: String) -> UILabel {
        let label = UILabel()
        let attributedString = NSAttributedString(
            string: placeholder.uppercased(),
            attributes: [.font: UIFont(name: "Futura-Medium", size: 10)!, .foregroundColor: UIColor.black.withAlphaComponent(0.5)]
        )
        label.attributedText = attributedString
        return label
    }
    
    static func createBorderLine(width: CGFloat, length: CGFloat) -> UIView {
        let view = UIView()
        let border = CALayer()
        border.backgroundColor = UIColor.textfieldLine.cgColor
        border.frame = CGRect(x: 0, y: 0, width: length, height: width)
        view.layer.addSublayer(border)
        return view
    }
}
