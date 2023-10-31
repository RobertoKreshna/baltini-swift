//
//  ChangePasswordViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 31/10/23.
//

import UIKit

class ChangePasswordViewController : UIViewController {
    var currentUser : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        removeUI()
        loadData()
        createUI()
    }
    
    func loadData(){
        currentUser = CommonStore.shared.getUser()
    }
    
     func removeUI() {
        let subviews = view.subviews
        subviews.forEach { subview in
            subview.removeFromSuperview()
        }
    }
}


//MARK: Create UI Methods

extension ChangePasswordViewController {
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
        
        BackButton.addBackButton(to: pageStackView, title: "My Profile", sender: self)
        pageStackView.setCustomSpacing(24, after: pageStackView.arrangedSubviews.last!)
        CustomTextfield.addTextfield(to: pageStackView, placeholder: "First Name", isPassword: false, owner: self, text: currentUser?.firstName)
        pageStackView.setCustomSpacing(24, after: pageStackView.arrangedSubviews.last!)
        CustomTextfield.addTextfield(to: pageStackView, placeholder: "Last Name", isPassword: false, owner: self, text: currentUser?.lastName)
        pageStackView.setCustomSpacing(24, after: pageStackView.arrangedSubviews.last!)
        CustomTextfield.addTextfield(to: pageStackView, placeholder: "Email", isPassword: false, owner: self, text: currentUser?.email)
        pageStackView.setCustomSpacing(32, after: pageStackView.arrangedSubviews.last!)
        
        let changePasswordButton = CustomButton.createUnderlinedButton(title: "CHANGE PASSWORD", action: UIAction(handler: { action in
            print("change password")
        }))
        pageStackView.addArrangedSubview(changePasswordButton)
        pageStackView.setCustomSpacing(40, after: pageStackView.arrangedSubviews.last!)
        
        let saveButton = CustomButton.createBlackButton(title: "SAVE", action: UIAction(handler: { action in
            print("save")
        }))
        pageStackView.addArrangedSubview(saveButton)
        saveButton.widthAnchor.constraint(equalTo: pageStackView.widthAnchor).isActive = true
    }
}

//MARK: Textfield delegate methods
extension ChangePasswordViewController: UITextFieldDelegate {
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
extension ChangePasswordViewController {
    func goToChangePassword() {
        
    }
}

