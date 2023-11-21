//
//  RegisterViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 27/10/23.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {
    
    let values: [String] = ["First Name", "Last Name", "Email", "Password"]
    let needButton: [Bool] = [false, false, false, true]
    
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
        
        let backButton = BackButton.createBackButton(title: "Create Account" , icName: "icBack", usePadding: false, tapped: UIAction(handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        pageStackView.addArrangedSubview(backButton)
        backButton.topAnchor.constraint(equalTo: pageStackView.topAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: pageStackView.leftAnchor).isActive = true
        
        pageStackView.setCustomSpacing(24, after: pageStackView.arrangedSubviews.last!)
        for i in 0 ... values.count - 1{
            let textfield = CustomTextfield.createTextfield(placeholder: values[i], isPassword: needButton[i], owner: self)
            pageStackView.addArrangedSubview(textfield)
            pageStackView.setCustomSpacing(i == values.count - 1 ? 40 : 32, after: textfield)
            textfield.leftAnchor.constraint(equalTo: pageStackView.leftAnchor).isActive = true
            textfield.rightAnchor.constraint(equalTo: pageStackView.rightAnchor).isActive = true
        }
        addCreateButton(to: pageStackView)
    }
    
    func addCreateButton(to stack: UIStackView){
        let button = CustomButton.createBlackButton(
            title: "CREATE",
            action: UIAction(handler: { action in
                //get all textfield
                let firstNameStack = stack.arrangedSubviews[1] as! UIStackView
                let firstNameTextfield = firstNameStack.arrangedSubviews[1] as! UITextField
                let lastNameStack = stack.arrangedSubviews[2] as! UIStackView
                let lastNameTextfield = lastNameStack.arrangedSubviews[1] as! UITextField
                let emailStack = stack.arrangedSubviews[3] as! UIStackView
                let emailTextfield = emailStack.arrangedSubviews[1] as! UITextField
                let passwordStack = stack.arrangedSubviews[4] as! UIStackView
                let passwordContentStack = passwordStack.arrangedSubviews[1] as! UIStackView
                let passwordTextfield = passwordContentStack.arrangedSubviews[0] as! UITextField
                //use the textfield to create account
                self.createAccount(
                    firstName: firstNameTextfield.text!,
                    lastName: lastNameTextfield.text!,
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
    func createAccount(firstName: String, lastName: String, email: String, password: String){
        if checkIsNotEmpty(firstName, lastName, email, password) {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            //check email is used or no
            var mailArray = [String]()
            let request: NSFetchRequest<User> = User.fetchRequest()
            do {
                let results = try context.fetch(request)
                for result in results {
                    mailArray.append(result.email!)
                }
            } catch { CustomToast.showErrorToast(msg: "Failed to get all users data", sender: self) }
            //register
            if mailArray.contains(email){
                CustomToast.showErrorToast(msg: "Email (\(email)) has been used by another user", sender: self)
            } else {
                let newUser = User(context: context)
                newUser.firstName = firstName
                newUser.lastName = lastName
                newUser.email = email
                newUser.password = password
                do {
                    try context.save()
                    CommonStore.shared.setUser(user: newUser)
                    CustomPopup.displayPopup(sender: self, title: "Account Created", toRoot: true)
                } catch {
                    CustomToast.showErrorToast(msg: "Failed to create new user with name \(firstName) \(lastName)", sender: self)
                }
            }
        } else {
            CustomToast.showErrorToast(msg: "All fields required, please fill all the fields above", sender: self)
        }
    }
    
    func checkIsNotEmpty(_ firstName: String, _ lastname: String, _ email: String, _ password: String) -> Bool{
        return firstName.isEmpty || lastname.isEmpty || email.isEmpty || password.isEmpty ? false : true
    }
}

