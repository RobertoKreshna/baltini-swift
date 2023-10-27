//
//  CustomTextfield.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 26/10/23.
//

import UIKit

class CustomTextfield {
     func createTextfield(placeholder: String, owner: UITextFieldDelegate) -> UITextField {
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
    
     func createTogglePasswordButton(textfield: UITextField) -> UIButton {
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
    
     func createPasswordTextfield(placeholder: String, owner: UITextFieldDelegate) -> UIView {
        let textfield = createTextfield(placeholder: placeholder, owner: owner)
        let button = createTogglePasswordButton(textfield: textfield)
        
        let textfieldStack = UIStackView()
        textfieldStack.addArrangedSubview(textfield)
        textfieldStack.addArrangedSubview(button)
        
        button.widthAnchor.constraint(equalToConstant: 24).isActive = true
        button.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        return textfieldStack
    }
    
     func createLabel(placeholder: String) -> UILabel {
        let label = UILabel()
        let attributedString = NSAttributedString(
            string: placeholder.uppercased(),
            attributes: [.font: UIFont(name: "Futura-Medium", size: 10)!, .foregroundColor: UIColor.black.withAlphaComponent(0.5)]
        )
        label.attributedText = attributedString
        return label
    }
    
     func createBorderLine(width: CGFloat, length: CGFloat) -> UIView {
        let view = UIView()
        let border = CALayer()
        border.backgroundColor = UIColor.textfieldLine.cgColor
        border.frame = CGRect(x: 0, y: 0, width: length, height: width)
        view.layer.addSublayer(border)
        return view
    }
    
    static func addTextfield(to stack: UIStackView, placeholder: String, isPassword: Bool, owner: UITextFieldDelegate){
        let blueprint = CustomTextfield()
        let desc = blueprint.createLabel(placeholder: placeholder)
        let textfield = isPassword
        ? blueprint.createPasswordTextfield(placeholder: placeholder, owner: owner)
        : blueprint.createTextfield(placeholder: placeholder, owner: owner)
        let border = blueprint.createBorderLine(width: 1, length: UIScreen.main.bounds.width-32)

        stack.addArrangedSubview(desc)
        stack.setCustomSpacing(4, after: desc)
        stack.addArrangedSubview(textfield)
        stack.setCustomSpacing(4, after: textfield)
        stack.addArrangedSubview(border)
        
        textfield.widthAnchor.constraint(equalTo: stack.widthAnchor).isActive = true
    }
}
