//
//  CustomTextfield.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 26/10/23.
//

import UIKit

class CustomTextfield {
    private static func createTextfield(placeholder: String, owner: UITextFieldDelegate, text: String?) -> UITextField {
        let attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.font: UIFont(name: "Futura-Medium", size: 16)!, .foregroundColor: UIColor.black.withAlphaComponent(0.5)]
        )
        let textfield = UITextField()
        textfield.attributedPlaceholder = attributedPlaceholder
        textfield.font = UIFont(name: "Futura-Medium", size: 16)!
        textfield.textColor = .black
        textfield.borderStyle = .none
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        
        if(text != nil) {
            textfield.text = text
        }
        
        textfield.delegate = owner
        
        return textfield
    }
    
    private static func createTogglePasswordButton(textfield: UITextField) -> UIButton {
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
    
    private static func createPasswordTextfield(placeholder: String, owner: UITextFieldDelegate, text: String?) -> UIView {
        let textfield = createTextfield(placeholder: placeholder, owner: owner, text: text)
        let button = createTogglePasswordButton(textfield: textfield)
        
        let textfieldStack = UIStackView()
        textfieldStack.translatesAutoresizingMaskIntoConstraints = false
        textfieldStack.addArrangedSubview(textfield)
        textfieldStack.addArrangedSubview(button)
        
        button.widthAnchor.constraint(equalToConstant: 24).isActive = true
        button.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        return textfieldStack
    }
    
    private static func createLabel(placeholder: String) -> UILabel {
        let label = UILabel()
        let attributedString = NSAttributedString(
            string: placeholder.uppercased(),
            attributes: [.font: UIFont(name: "Futura-Medium", size: 10)!, .foregroundColor: UIColor.black.withAlphaComponent(0.5)]
        )
        label.attributedText = attributedString
        return label
    }
    
    private static func createBorderLine(width: CGFloat, length: CGFloat) -> UIView {
        let view = UIView()
        let border = CALayer()
        border.backgroundColor = UIColor.textfieldLine.cgColor
        border.frame = CGRect(x: 0, y: 0, width: length, height: width)
        view.layer.addSublayer(border)
        return view
    }
    
    static func createTextfield(placeholder: String, isPassword: Bool, owner: UITextFieldDelegate, text: String? = nil, useDesc: Bool = true, lineLength: CGFloat = UIScreen.main.bounds.width-32) -> UIStackView{
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        
        let textfield = isPassword
        ? createPasswordTextfield(placeholder: placeholder, owner: owner, text: text)
        : createTextfield(placeholder: placeholder, owner: owner, text: text)
        let border = createBorderLine(width: 1, length: lineLength)
        if useDesc{
            let desc = createLabel(placeholder: placeholder)
            stack.addArrangedSubview(desc)
            stack.setCustomSpacing(4, after: desc)
        }
        stack.addArrangedSubview(textfield)
        stack.setCustomSpacing(4, after: textfield)
        stack.addArrangedSubview(border)
        
        return stack
    }
    
    static func createOutlinedSearchBar(owner: UITextFieldDelegate, placeholder: String = "", text: String = "") -> UITextField {
        let attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.font: UIFont(name: "Futura-Medium", size: 14)!, .foregroundColor: UIColor.black.withAlphaComponent(0.5)]
        )
        
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        
        textfield.font = UIFont(name: "Futura-Medium", size: 14)!
        textfield.textColor = .black
        textfield.layer.borderWidth = 1
        textfield.layer.cornerRadius = 8
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        if(placeholder.isEmpty == false) { textfield.attributedPlaceholder = attributedPlaceholder }
        if(text.isEmpty == false) { textfield.text = text }
        
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = UIImage(named: "icSearch")
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 38, height: 30)) //width supposed to be 30, 8 for spacing
        iconContainerView.addSubview(iconView)
        textfield.leftView = iconContainerView
        textfield.leftViewMode = .always
        
        textfield.delegate = owner
        
        return textfield
    }
    
    static func createFilledSearchBar(owner: UITextFieldDelegate, placeholder: String = "", text: String = "") -> UITextField {
        let attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.font: UIFont(name: "Futura-Medium", size: 14)!, .foregroundColor: UIColor.black.withAlphaComponent(0.5)]
        )
        
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        
        textfield.backgroundColor = .brandGray
        textfield.font = UIFont(name: "Futura-Medium", size: 14)!
        textfield.textColor = .black
        textfield.borderStyle = .roundedRect
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        if(placeholder.isEmpty == false) { textfield.attributedPlaceholder = attributedPlaceholder }
        if(text.isEmpty == false) { textfield.text = text }
        
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = UIImage(named: "icSearch")
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        textfield.leftView = iconContainerView
        textfield.leftViewMode = .always
        
        textfield.delegate = owner
        
        return textfield
    }
}
