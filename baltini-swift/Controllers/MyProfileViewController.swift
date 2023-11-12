//
//  MyProfileViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 31/10/23.
//

import UIKit
import CoreData

class MyProfileViewController : UIViewController {
    var currentUser : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = true
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

extension MyProfileViewController {
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
        
        BackButton.addBackButton(to: pageStackView, title: "My Profile", icName: "icBack", sender: self, usePadding: false)
        pageStackView.setCustomSpacing(24, after: pageStackView.arrangedSubviews.last!)
        CustomTextfield.addTextfield(to: pageStackView, placeholder: "First Name", isPassword: false, owner: self, text: currentUser?.firstName)
        pageStackView.setCustomSpacing(24, after: pageStackView.arrangedSubviews.last!)
        CustomTextfield.addTextfield(to: pageStackView, placeholder: "Last Name", isPassword: false, owner: self, text: currentUser?.lastName)
        pageStackView.setCustomSpacing(24, after: pageStackView.arrangedSubviews.last!)
        CustomTextfield.addTextfield(to: pageStackView, placeholder: "Email", isPassword: false, owner: self, text: currentUser?.email)
        pageStackView.setCustomSpacing(32, after: pageStackView.arrangedSubviews.last!)
        
        let changePasswordButton = CustomButton.createUnderlinedButton(title: "CHANGE PASSWORD", action: UIAction(handler: { action in
            self.goToChangePassword()
        }))
        pageStackView.addArrangedSubview(changePasswordButton)
        pageStackView.setCustomSpacing(40, after: pageStackView.arrangedSubviews.last!)
        
        let saveButton = CustomButton.createBlackButton(title: "SAVE", action: UIAction(handler: { action in
            self.savePressed(from: pageStackView)
        }))
        pageStackView.addArrangedSubview(saveButton)
        saveButton.widthAnchor.constraint(equalTo: pageStackView.widthAnchor).isActive = true
    }
}

//MARK: Textfield delegate methods
extension MyProfileViewController: UITextFieldDelegate {
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
extension MyProfileViewController {
    func goToChangePassword(){
        self.navigationController?.pushViewController(ChangePasswordViewController(), animated: true)
    }
    
    func savePressed(from stack: UIStackView){
        //get all textfield
        let firstNameTextfield = stack.arrangedSubviews[2] as! UITextField
        let lastNameTextfield = stack.arrangedSubviews[5] as! UITextField
        let emailTextfield = stack.arrangedSubviews[8] as! UITextField
        
        let firstName = firstNameTextfield.text!
        let lastName = lastNameTextfield.text!
        let email = emailTextfield.text!
        
        if checkIsNotEmpty(firstName, lastName, email) {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            if checkEmailIsNotUsed(context, email: email){
                let editedAccount = getEditedAccount(context)
                editedAccount?.firstName = firstName
                editedAccount?.lastName = lastName
                editedAccount?.email = email
                do{
                    try context.save()
                    CustomPopup.displayPopup(sender: self, title: "Account updated", toRoot: false)
                } catch {
                    CustomToast.showErrorToast(msg: "Error updating account", sender: self)
                }
            } else {
                CustomToast.showErrorToast(msg: "Email has already been used by another user", sender: self)
            }
        } else {
            CustomToast.showErrorToast(msg: "All fields required, please fill all the fields above", sender: self)
        }
    }
    
    func checkIsNotEmpty(_ firstName: String, _ lastname: String, _ email: String) -> Bool{
        return firstName.isEmpty || lastname.isEmpty || email.isEmpty ? false : true
    }
    
    func getEditedAccount(_ context: NSManagedObjectContext) -> User? {
        var res: User? = nil
        
        let request: NSFetchRequest<User> = User.fetchRequest()
        do{
            let allUser = (try context.fetch(request))
            allUser.forEach { user in
                if(user.id == currentUser?.id) { res = user }
            }
        } catch {
            CustomToast.showErrorToast(msg: "No address found", sender: self)
        }
        
        return res
    }
    
    func checkEmailIsNotUsed(_ context: NSManagedObjectContext, email: String) -> Bool{
        var res = 0
        var mailArray = [String]()
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            let results = try context.fetch(request)
            for result in results {
                mailArray.append(result.email!)
            }
        } catch { CustomToast.showErrorToast(msg: "Failed to get all users email", sender: self) }
        mailArray.forEach { mail in
            if mail == email {
                res += 1
            }
        }
        return res > 1 ? false : true
    }
}
