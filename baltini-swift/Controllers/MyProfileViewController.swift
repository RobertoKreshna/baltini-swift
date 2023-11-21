//
//  MyProfileViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 31/10/23.
//

import UIKit
import CoreData

class MyProfileViewController : UIViewController {
    let values: [String] = ["First Name", "Last Name", "Email"]
    var datas: [String?]?
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
        datas = [currentUser?.firstName, currentUser?.lastName, currentUser?.email]
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
        
        let backButton = BackButton.createBackButton(title: "My Profile" , icName: "icBack", usePadding: false, tapped: UIAction(handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        pageStackView.addArrangedSubview(backButton)
        backButton.topAnchor.constraint(equalTo: pageStackView.topAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: pageStackView.leftAnchor).isActive = true
        
        pageStackView.setCustomSpacing(24, after: pageStackView.arrangedSubviews.last!)
        
        for i in 0 ... values.count - 1 {
            let tf = CustomTextfield.createTextfield(placeholder: values[i], isPassword: false, owner: self, text: datas![i])
            pageStackView.addArrangedSubview(tf)
            pageStackView.setCustomSpacing(i == values.count - 1 ? 32 : 24, after: tf)
        }
        
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
        let firstNameStack = stack.arrangedSubviews[1] as! UIStackView
        let firstNameTextfield = firstNameStack.arrangedSubviews[1] as! UITextField
        let lastNameStack = stack.arrangedSubviews[2] as! UIStackView
        let lastNameTextfield = lastNameStack.arrangedSubviews[1] as! UITextField
        let emailStack = stack.arrangedSubviews[3] as! UIStackView
        let emailTextfield = emailStack.arrangedSubviews[1] as! UITextField
        
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
