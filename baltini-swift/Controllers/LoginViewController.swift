//
//  LoginViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 26/10/23.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    let values: [String] = ["Email", "Password"]
    let needButton: [Bool] = [false, true]
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = true
        removeUI()
        createUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func removeUI() {
       let subviews = view.subviews
       subviews.forEach { subview in
           subview.removeFromSuperview()
       }
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
        
        let backButton = BackButton.createBackButton(title: "Login" , icName: "icBack", usePadding: false, tapped: UIAction(handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        pageStackView.addArrangedSubview(backButton)
        backButton.topAnchor.constraint(equalTo: pageStackView.topAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: pageStackView.leftAnchor).isActive = true
        
        pageStackView.setCustomSpacing(24, after: pageStackView.arrangedSubviews.last!)
        addDescLabel(to: pageStackView)
        pageStackView.setCustomSpacing(24, after: pageStackView.arrangedSubviews.last!)
        
        for i in 0 ... values.count - 1 {
            let tf = CustomTextfield.createTextfield(placeholder: values[i], isPassword: needButton[i], owner: self)
            pageStackView.addArrangedSubview(tf)
            pageStackView.setCustomSpacing(32, after: tf)
            tf.leftAnchor.constraint(equalTo: pageStackView.leftAnchor).isActive = true
            tf.rightAnchor.constraint(equalTo: pageStackView.rightAnchor).isActive = true
        }
        
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
            action: UIAction(handler: { action in
                //get all textfield
                let emailStack = stack.arrangedSubviews[2] as! UIStackView
                let emailTextfield = emailStack.arrangedSubviews[1] as! UITextField
                let passwordStack = stack.arrangedSubviews[3] as! UIStackView
                let passwordContentStack = passwordStack.arrangedSubviews[1] as! UIStackView
                let passwordTextfield = passwordContentStack.arrangedSubviews[0] as! UITextField
                
                self.loginPressed(email: emailTextfield.text!, password: passwordTextfield.text!)
            })
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
    func loginPressed(email: String, password: String){
        if checkIsNotEmpty(email, password) {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            //get all users
            var mailArray = [String]()
            var passwordArray = [String]()
            var userArray = [User]()
            let request: NSFetchRequest<User> = User.fetchRequest()
            do {
                let results = try context.fetch(request)
                for result in results {
                    mailArray.append(result.email!)
                    passwordArray.append(result.password!)
                    userArray.append(result)
                }
            } catch { CustomToast.showErrorToast(msg: "Failed to get all users data", sender: self) }
            //check if user exist
            if(!mailArray.contains(email)){
                CustomToast.showErrorToast(msg: "No user registered with that email", sender: self)
                return
            }
            //check if password matched
            let userIndex = mailArray.firstIndex(where: { $0 == email })
            if passwordArray[userIndex!] != password {
                CustomToast.showErrorToast(msg: "Password is not matched", sender: self)
                return
            }
            //set user
            CommonStore.shared.setUser(user: userArray[userIndex!])
            self.navigationController?.popViewController(animated: true)
        } else {
            CustomToast.showErrorToast(msg: "All fields required, please fill all the fields above", sender: self)
        }
    }
    
    func checkIsNotEmpty(_ email: String, _ password: String) -> Bool{
        return email.isEmpty || password.isEmpty ? false : true
    }
}
