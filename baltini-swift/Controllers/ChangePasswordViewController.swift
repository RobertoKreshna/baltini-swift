//
//  ChangePasswordViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 31/10/23.
//

import UIKit
import CoreData

class ChangePasswordViewController : UIViewController {
    let values: [String] = ["Old Password", "New Password", "Confirm New Password"]
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
        
        let backButton = BackButton.createBackButton(title: "Change Password" , icName: "icBack", usePadding: false, tapped: UIAction(handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        pageStackView.addArrangedSubview(backButton)
        backButton.topAnchor.constraint(equalTo: pageStackView.topAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: pageStackView.leftAnchor).isActive = true
        
        pageStackView.setCustomSpacing(24, after: pageStackView.arrangedSubviews.last!)
        
        for i in 0 ... values.count - 1 {
            let textfield = CustomTextfield.createTextfield(placeholder: values[i], isPassword: true, owner: self)
            pageStackView.addArrangedSubview(textfield)
            pageStackView.setCustomSpacing(i == values.count - 1 ? 32 : 24, after: textfield)
        }
        
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
        let oldPwStack = stack.arrangedSubviews[1] as! UIStackView
        let oldPwContentStack = oldPwStack.arrangedSubviews[1] as! UIStackView
        let oldPasswordTextfield = oldPwContentStack.arrangedSubviews[0] as! UITextField
        let newPwStack = stack.arrangedSubviews[2] as! UIStackView
        let newPwContentStack = newPwStack.arrangedSubviews[1] as! UIStackView
        let newPasswordTextfield = newPwContentStack.arrangedSubviews[0] as! UITextField
        let confNewPwStack = stack.arrangedSubviews[3] as! UIStackView
        let confNewPwContentStack = confNewPwStack.arrangedSubviews[1] as! UIStackView
        let confirmPasswordTextfield = confNewPwContentStack.arrangedSubviews[0] as! UITextField
        
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

