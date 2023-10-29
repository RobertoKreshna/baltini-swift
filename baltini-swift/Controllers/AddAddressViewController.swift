//
//  AddAddressViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 29/10/23.
//

import UIKit

class AddAddressViewController : UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
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
        
        BackButton.addBackButton(to: pageStackView, title: "Add Address", sender: self)
        pageStackView.setCustomSpacing(30, after: pageStackView.arrangedSubviews.last!)
        CustomTextfield.addTextfield(to: pageStackView, placeholder: "First Name", isPassword: false, owner: self)
        pageStackView.setCustomSpacing(40, after: pageStackView.arrangedSubviews.last!)
        CustomTextfield.addTextfield(to: pageStackView, placeholder: "Last Name", isPassword: false, owner: self)
        pageStackView.setCustomSpacing(40, after: pageStackView.arrangedSubviews.last!)
        CustomTextfield.addTextfield(to: pageStackView, placeholder: "Company (Optional)", isPassword: false, owner: self)
        pageStackView.setCustomSpacing(40, after: pageStackView.arrangedSubviews.last!)
        CustomTextfield.addTextfield(to: pageStackView, placeholder: "Address 1", isPassword: false, owner: self)
        pageStackView.setCustomSpacing(40, after: pageStackView.arrangedSubviews.last!)
        CustomTextfield.addTextfield(to: pageStackView, placeholder: "Address 2", isPassword: false, owner: self)
        pageStackView.setCustomSpacing(40, after: pageStackView.arrangedSubviews.last!)
        CustomTextfield.addTextfield(to: pageStackView, placeholder: "City", isPassword: false, owner: self)
        pageStackView.setCustomSpacing(40, after: pageStackView.arrangedSubviews.last!)
        CustomTextfield.addTextfield(to: pageStackView, placeholder: "Country", isPassword: false, owner: self)
        pageStackView.setCustomSpacing(40, after: pageStackView.arrangedSubviews.last!)
        CustomTextfield.addTextfield(to: pageStackView, placeholder: "Province / State", isPassword: false, owner: self)
        pageStackView.setCustomSpacing(40, after: pageStackView.arrangedSubviews.last!)
        CustomTextfield.addTextfield(to: pageStackView, placeholder: "ZIP Code", isPassword: false, owner: self)
        pageStackView.setCustomSpacing(40, after: pageStackView.arrangedSubviews.last!)
        CustomTextfield.addTextfield(to: pageStackView, placeholder: "Phone Number", isPassword: false, owner: self)
        pageStackView.setCustomSpacing(4, after: pageStackView.arrangedSubviews.last!)
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
                CustomPopup.displayRegisterPopup(sender: self, title: "Address Saved", toRoot: false)
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

class AddressArgs {
    var firstName: String
    var lastName: String
    var company: String?
    var address1: String
    var address2: String?
    var city: String
    var country: String
    var province: String
    var zipCode: String
    var phoneNumber: String
    
    init(from stack: UIStackView){
        //get all textfield
        let firstNameTextfield = stack.arrangedSubviews[2] as! UITextField
        let lastNameTextfield = stack.arrangedSubviews[5] as! UITextField
        let companyTextfield = stack.arrangedSubviews[8] as! UITextField
        let address1Textfield = stack.arrangedSubviews[11] as! UITextField
        let address2Textfield = stack.arrangedSubviews[14] as! UITextField
        let cityTextfield = stack.arrangedSubviews[17] as! UITextField
        let countryTextfield = stack.arrangedSubviews[20] as! UITextField
        let provinceTextfield = stack.arrangedSubviews[23] as! UITextField
        let zipCodeTextfield = stack.arrangedSubviews[26] as! UITextField
        let phoneNumberTextfield = stack.arrangedSubviews[29] as! UITextField
        
        //assign value
        self.firstName = firstNameTextfield.text!
        self.lastName = lastNameTextfield.text!
        self.company = companyTextfield.text
        self.address1 = address1Textfield.text!
        self.address2 = address2Textfield.text
        self.city = cityTextfield.text!
        self.country = countryTextfield.text!
        self.province = provinceTextfield.text!
        self.zipCode = zipCodeTextfield.text!
        self.phoneNumber = phoneNumberTextfield.text!
    }
}
