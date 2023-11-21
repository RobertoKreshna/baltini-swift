//
//  AddAddressViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 29/10/23.
//

import UIKit

class AddAddressViewController : UIViewController {
    
    let values: [String] = ["First Name", "Last Name", "Company (Optional)", "Address 1", "Address 2", "City", "Country", "Province / State", "ZIP Code", "Phone Number"]
    
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
extension AddAddressViewController {
    func createUI(){
        view.backgroundColor = .white

        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        let pageStackView = UIStackView()
        scrollView.addSubview(pageStackView)
        
        pageStackView.axis = .vertical
        
        pageStackView.translatesAutoresizingMaskIntoConstraints = false
        pageStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        pageStackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16).isActive = true
        pageStackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16).isActive = true
        pageStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        pageStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32).isActive = true
        
        let backButton = BackButton.createBackButton(title: "Add Address" , icName: "icBack", usePadding: false, tapped: UIAction(handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        pageStackView.addArrangedSubview(backButton)
        backButton.topAnchor.constraint(equalTo: pageStackView.topAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: pageStackView.leftAnchor).isActive = true
        
        pageStackView.setCustomSpacing(30, after: pageStackView.arrangedSubviews.last!)
        for i in 0 ... values.count - 1 {
            let textfield = CustomTextfield.createTextfield(placeholder: values[i], isPassword: false, owner: self)
            pageStackView.addArrangedSubview(textfield)
            pageStackView.setCustomSpacing(i == values.count - 1 ? 4 : 40, after: textfield)
            textfield.leftAnchor.constraint(equalTo: pageStackView.leftAnchor).isActive = true
            textfield.rightAnchor.constraint(equalTo: pageStackView.rightAnchor).isActive = true
        }
        addTextfieldDescription(to: pageStackView, text: "Incase we need to contact you about your order.")
        pageStackView.setCustomSpacing(42, after: pageStackView.arrangedSubviews.last!)
        addAddButton(to: pageStackView)
    }
    
    func addTextfieldDescription(to stack: UIStackView, text: String){
        let attributedTitle = NSAttributedString(
            string: text,
            attributes: [.font : UIFont(name: "Futura-Medium", size: 12)!]
        )
        let label = UILabel()
        label.attributedText = attributedTitle
        
        stack.addArrangedSubview(label)
    }
    
    func addAddButton(to stack: UIStackView) {
        let button = CustomButton.createBlackButton(
            title: "SAVE ADDRESS",
            action: UIAction(handler: { action in
                let addressArgs = AddressArgs(from: stack)
                self.saveNewAddress(args: addressArgs)
            })
        )
        stack.addArrangedSubview(button)
    }
}

//MARK: UI Textfield Delegate
extension AddAddressViewController: UITextFieldDelegate {
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
extension AddAddressViewController {
    func saveNewAddress(args: AddressArgs){
        if checkIsNotEmpty(args: args) {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let newAddress = Address(context: context)
            newAddress.firstName = args.firstName
            newAddress.lastName = args.lastName
            newAddress.company = args.company
            newAddress.address1 = args.address1
            newAddress.address2 = args.address2
            newAddress.city = args.city
            newAddress.country = args.country
            newAddress.province = args.province
            newAddress.zipcode = args.zipCode
            newAddress.phone = args.phoneNumber
            newAddress.belongsTo = CommonStore.shared.getUser()
            do {
                try context.save()
                CustomPopup.displayPopup(sender: self, title: "Address Saved", toRoot: false)
            } catch {
                CustomToast.showErrorToast(msg: "Failed to create new address", sender: self)
            }
        }  else {
            CustomToast.showErrorToast(msg: "All fields required, please fill all the fields above", sender: self)
        }
    }
    
    func checkIsNotEmpty(args: AddressArgs) -> Bool{
        return (args.firstName.isEmpty) || (args.lastName.isEmpty) || (args.address1.isEmpty) || (args.city.isEmpty) || (args.country.isEmpty) || (args.province.isEmpty) || (args.zipCode.isEmpty) || (args.phoneNumber.isEmpty) ? false : true
    }
}
