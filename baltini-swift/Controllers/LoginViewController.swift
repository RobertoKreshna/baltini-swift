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
        pageStackView.alignment = .leading
        view.addSubview(pageStackView)
        
        pageStackView.isUserInteractionEnabled = true
        pageStackView.translatesAutoresizingMaskIntoConstraints = false
        pageStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 22).isActive = true
        pageStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        pageStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
        BackButton.addBackButton(to: pageStackView, title: "Login", sender: self)
        pageStackView.setCustomSpacing(24, after: pageStackView.arrangedSubviews.last!)
        addDescLabel(to: pageStackView)
        pageStackView.setCustomSpacing(24, after: pageStackView.arrangedSubviews.last!)
        CustomTextfield.addTextfield(to: pageStackView, placeholder: "Email", isPassword: false, owner: self)
        pageStackView.setCustomSpacing(32, after: pageStackView.arrangedSubviews.last!)
        CustomTextfield.addTextfield(to: pageStackView, placeholder: "Password", isPassword: true, owner: self)
        pageStackView.setCustomSpacing(32, after: pageStackView.arrangedSubviews.last!)
        addForgotPassword(to: pageStackView)
        pageStackView.setCustomSpacing(40, after: pageStackView.arrangedSubviews.last!)
        addLoginOrRegisterButton(to: pageStackView)
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
    
    func addForgotPassword(to stack: UIStackView){
        let button = CustomButton.createUnderlinedButton(
            title: "FORGOT PASSWORD",
            action: UIAction(handler: { action in
                self.navigationController?.pushViewController(ForgotPasswordViewController(), animated: true)
            })
        )
        stack.addArrangedSubview(button)
    }
    
    func addLoginOrRegisterButton(to stack: UIStackView){
        let loginButton = CustomButton.createBlackButton(
            title: "LOGIN",
            action: UIAction(handler: { action in self.loginPressed() })
        )
        let orLabel = createOrLabel()
        let registerButton = CustomButton.createWhiteButton(
            title: "CREATE BALTINI ACCOUNT",
            action: UIAction(handler: { action in self.navigationController?.pushViewController(RegisterViewController(), animated: true) })
        )
        stack.addArrangedSubview(loginButton)
        stack.setCustomSpacing(24, after: stack.arrangedSubviews.last!)
        stack.addArrangedSubview(orLabel)
        stack.setCustomSpacing(24, after: stack.arrangedSubviews.last!)
        stack.addArrangedSubview(registerButton)
        
        loginButton.widthAnchor.constraint(equalTo: stack.widthAnchor).isActive = true
        orLabel.widthAnchor.constraint(equalTo: stack.widthAnchor).isActive = true
        registerButton.widthAnchor.constraint(equalTo: stack.widthAnchor).isActive = true
    }
    
    func createOrLabel() -> UILabel {
        let label = UILabel()
        let attributedText = NSAttributedString(
            string: "or",
            attributes: [.font: UIFont(name: "Futura-Medium", size: 16)!]
        )
        label.attributedText = attributedText
        label.textAlignment = .center
        
        return label
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

//MARK: Business Logic
extension LoginViewController {
    func loginPressed(){
        
    }
}
