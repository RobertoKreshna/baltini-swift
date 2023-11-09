//
//  ChangePasswordViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 31/10/23.
//

import UIKit
import CoreData

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
        
        BackButton.addBackButton(to: pageStackView, title: "Change Password", icName: "icBack", sender: self, usePadding: false)
        pageStackView.setCustomSpacing(24, after: pageStackView.arrangedSubviews.last!)
        CustomTextfield.addTextfield(to: pageStackView, placeholder: "Old Password", isPassword: false, owner: self)
        pageStackView.setCustomSpacing(24, after: pageStackView.arrangedSubviews.last!)
        CustomTextfield.addTextfield(to: pageStackView, placeholder: "New Password", isPassword: false, owner: self)
        pageStackView.setCustomSpacing(24, after: pageStackView.arrangedSubviews.last!)
        CustomTextfield.addTextfield(to: pageStackView, placeholder: "Confirm New Password", isPassword: false, owner: self)
        pageStackView.setCustomSpacing(32, after: pageStackView.arrangedSubviews.last!)
        
        let saveButton = CustomButton.createBlackButton(title: "CHANGE PASSWORD", action: UIAction(handler: { action in
            self.changePasswordPressed(from: pageStackView)
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
    func changePasswordPressed(from stack: UIStackView){
        //get all textfield
        let oldPasswordTextfield = stack.arrangedSubviews[2] as! UITextField
        let newPasswordTextfield = stack.arrangedSubviews[5] as! UITextField
        let confirmPasswordTextfield = stack.arrangedSubviews[8] as! UITextField
        
        let oldPassword = oldPasswordTextfield.text!
        let newPassword = newPasswordTextfield.text!
        let confirmNewPassword = confirmPasswordTextfield.text!
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if checkIsNotEmpty(oldPassword, newPassword, confirmNewPassword) {
            if checkConfirm(newPassword, confirmNewPassword){
                if checkOldPassword(inputted: oldPassword, real: getEditedAccountPassword(context)) {
                    let editedAccount = getEditedAccount(context)
                    editedAccount?.password = newPassword
                    do{
                        try context.save()
                        CustomPopup.displayPopup(sender: self, title: "Account updated", toRoot: true)
                    } catch {
                        CustomToast.showErrorToast(msg: "Error updating account", sender: self)
                    }
                } else {
                    CustomToast.showErrorToast(msg: "Old password is wrong", sender: self)
                }
            } else {
                CustomToast.showErrorToast(msg: "Confirm password is wrong", sender: self)
            }
        } else {
            CustomToast.showErrorToast(msg: "All fields required, please fill all the fields above", sender: self)
        }
    }
    
    func checkIsNotEmpty(_ oldPw: String, _ newPw: String, _ confirmPw: String) -> Bool {
        return oldPw.isEmpty || newPw.isEmpty || confirmPw.isEmpty ? false : true
    }
    
    func checkConfirm(_ pw: String, _ confirm: String) -> Bool {
        return pw == confirm
    }
    
    func checkOldPassword(inputted: String, real: String) -> Bool {
        return inputted == real
    }
    
    func getEditedAccountPassword(_ context: NSManagedObjectContext) -> String {
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
        
        return res?.password ?? ""
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
}

