//
//  LoginViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 26/10/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
}

//MARK: Create UI Methods
extension LoginViewController {
    func createUI(){
        view.backgroundColor = .white
        
        let pageStackView = UIStackView()
        pageStackView.axis = .vertical
        view.addSubview(pageStackView)
        pageStackView.isUserInteractionEnabled = true
        
        pageStackView.translatesAutoresizingMaskIntoConstraints = false
        pageStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 22).isActive = true
        pageStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        pageStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
        BackButton.addBackButton(to: pageStackView, sender: self)
        pageStackView.setCustomSpacing(24, after: pageStackView.arrangedSubviews.last!)
        addDescLabel(to: pageStackView)
        pageStackView.setCustomSpacing(24, after: pageStackView.arrangedSubviews.last!)
        addTextfield(to: pageStackView, placeholder: "Email", isPassword: false)
        pageStackView.setCustomSpacing(32, after: pageStackView.arrangedSubviews.last!)
        addTextfield(to: pageStackView, placeholder: "Password", isPassword: true)
        pageStackView.setCustomSpacing(32, after: pageStackView.arrangedSubviews.last!)
    }
    
    func addDescLabel(to stack: UIStackView){
        let attributedText = NSAttributedString(
            string: "Login with your email address and password.",
            attributes: [.font: UIFont(name: "Futura-Medium", size: 16)!]
        )
        let label = UILabel()
        label.attributedText = attributedText
        label.numberOfLines = 0
        
        stack.addArrangedSubview(label)
    }
    
    func addTextfield(to stack: UIStackView, placeholder: String, isPassword: Bool){
        let desc = CustomTextfield.createLabel(placeholder: placeholder)
        let textfield = isPassword 
        ? CustomTextfield.createPasswordTextfield(placeholder: placeholder, owner: self)
        : CustomTextfield.createTextfield(placeholder: placeholder, owner: self)
        let border = CustomTextfield.createBorderLine(width: 1, length: UIScreen.main.bounds.width-32)

        stack.addArrangedSubview(desc)
        stack.setCustomSpacing(4, after: desc)
        stack.addArrangedSubview(textfield)
        stack.setCustomSpacing(4, after: textfield)
        stack.addArrangedSubview(border)
    }
}

//MARK: Textfield delegate methods
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
