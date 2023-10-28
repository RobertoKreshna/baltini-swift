//
//  RegisterViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 27/10/23.
//

import UIKit

class RegisterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
}

//MARK: Create UI Methods
extension RegisterViewController {
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
        
        BackButton.addBackButton(to: pageStackView, title: "Create Account", sender: self)
        pageStackView.setCustomSpacing(24, after: pageStackView.arrangedSubviews.last!)
        CustomTextfield.addTextfield(to: pageStackView, placeholder: "First Name", isPassword: false, owner: self)
        pageStackView.setCustomSpacing(32, after: pageStackView.arrangedSubviews.last!)
        CustomTextfield.addTextfield(to: pageStackView, placeholder: "Last Name", isPassword: false, owner: self)
        pageStackView.setCustomSpacing(32, after: pageStackView.arrangedSubviews.last!)
        CustomTextfield.addTextfield(to: pageStackView, placeholder: "Email", isPassword: false, owner: self)
        pageStackView.setCustomSpacing(32, after: pageStackView.arrangedSubviews.last!)
        CustomTextfield.addTextfield(to: pageStackView, placeholder: "Password", isPassword: true, owner: self)
        pageStackView.setCustomSpacing(40, after: pageStackView.arrangedSubviews.last!)
        addCreateButton(to: pageStackView)
    }
    
    func addCreateButton(to stack: UIStackView){
        let button = CustomButton.createBlackButton(
            title: "CREATE",
            action: UIAction(handler: { action in
                //get all textfield
                let firstNameTextfield = stack.arrangedSubviews[2] as! UITextField
                let lastNameTextfield = stack.arrangedSubviews[5] as! UITextField
                let emailTextfield = stack.arrangedSubviews[8] as! UITextField
                let passwordStack = stack.arrangedSubviews[11] as! UIStackView
                let passwordTextfield = passwordStack.arrangedSubviews[0] as! UITextField
                //use the textfield to create account
                self.createAccount(
                    firstName: firstNameTextfield.text!,
                    lastname: lastNameTextfield.text!,
                    email: emailTextfield.text!,
                    password: passwordTextfield.text!
                )
            })
        )
        stack.addArrangedSubview(button)
        button.widthAnchor.constraint(equalTo: stack.widthAnchor).isActive = true
    }
}

//MARK: Textfield delegate methods
extension RegisterViewController: UITextFieldDelegate {
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
extension RegisterViewController {
    func createAccount(firstName: String, lastname: String, email: String, password: String){
//        if checkIsNotEmpty(firstName, lastname, email, password) {
//            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//            let newUser = User(context: context)
//            newUser.firstName = firstName
//            newUser.lastName = lastname
//            newUser.email = email
//            newUser.password = password
//            do {
//                try context.save()
//            } catch {
//                CustomToast.showErrorToast(msg: "Failed to create User", sender: self)
//            }
//        } else {
//            CustomToast.showErrorToast(msg: "All fields required, please fill all the fields above", sender: self)
//        }
        CustomPopup.displayRegisterPopup(sender: self)
    }
    
    func checkIsNotEmpty(_ firstName: String, _ lastname: String, _ email: String, _ password: String) -> Bool{
        return firstName.isEmpty || lastname.isEmpty || email.isEmpty || password.isEmpty ? false : true
    }
}

