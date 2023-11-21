//
//  EditAddressViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 30/10/23.
//

import UIKit
import CoreData

class EditAddressViewController : UIViewController {
    let values = ["First Name", "Last Name", "Company (Optional)", "Address 1", "Address 2", "City", "Country", "Province / State", "ZIP Code", "Phone Number"]
    var datas: [String?]?
    var currentAddress: Address? {
        didSet{
            datas = [
                currentAddress?.firstName, currentAddress?.lastName,
                currentAddress?.company, currentAddress?.address1, currentAddress?.address2,
                currentAddress?.city, currentAddress?.country, currentAddress?.province,
                currentAddress?.zipcode, currentAddress?.phone
            ]
        }
    }
    
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
extension EditAddressViewController {
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
        
        let backButton = BackButton.createBackButton(title: "Edit Address" , icName: "icBack", usePadding: false, tapped: UIAction(handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        pageStackView.addArrangedSubview(backButton)
        backButton.topAnchor.constraint(equalTo: pageStackView.topAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: pageStackView.leftAnchor).isActive = true
        
        pageStackView.setCustomSpacing(30, after: pageStackView.arrangedSubviews.last!)

        for i in 0 ... values.count - 1 {
            let tf = CustomTextfield.createTextfield(placeholder: values[i], isPassword: false, owner: self, text: datas![i])
            pageStackView.addArrangedSubview(tf)
            pageStackView.setCustomSpacing(i == values.count - 1 ? 4 : 40, after: tf)
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
                self.updateAddress(args: addressArgs)
            })
        )
        stack.addArrangedSubview(button)
    }
}

//MARK: UI Textfield Delegate
extension EditAddressViewController: UITextFieldDelegate {
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
extension EditAddressViewController {
    func updateAddress(args: AddressArgs){
        if checkIsNotEmpty(args: args) {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let editedAddress = getEditedAddress(context)
            editedAddress?.firstName = args.firstName
            editedAddress?.firstName = args.firstName
            editedAddress?.lastName = args.lastName
            editedAddress?.company = args.company
            editedAddress?.address1 = args.address1
            editedAddress?.address2 = args.address2
            editedAddress?.city = args.city
            editedAddress?.country = args.country
            editedAddress?.province = args.province
            editedAddress?.zipcode = args.zipCode
            editedAddress?.phone = args.phoneNumber
            do{
                try context.save()
                CustomPopup.displayPopup(sender: self, title: "Address Saved", toRoot: false)
            } catch {
                CustomToast.showErrorToast(msg: "Error updating address", sender: self)
            }
        }  else {
            CustomToast.showErrorToast(msg: "All fields required, please fill all the fields above", sender: self)
        }
    }
    
    func checkIsNotEmpty(args: AddressArgs) -> Bool{
        return (args.firstName.isEmpty) || (args.lastName.isEmpty) || (args.address1.isEmpty) || (args.city.isEmpty) || (args.country.isEmpty) || (args.province.isEmpty) || (args.zipCode.isEmpty) || (args.phoneNumber.isEmpty) ? false : true
    }
    
    func getEditedAddress(_ context: NSManagedObjectContext) -> Address? {
        var res: Address? = nil
        
        let request: NSFetchRequest<Address> = Address.fetchRequest()
        do{
            let allAddress = (try context.fetch(request))
            allAddress.forEach { address in
                if(address.id == currentAddress?.id) { res = address }
            }
        } catch {
            CustomToast.showErrorToast(msg: "No address found", sender: self)
        }
        
        return res
    }
}
