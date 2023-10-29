//
//  MyAddressViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 29/10/23.
//

import UIKit
import CoreData

class MyAddressViewController: UIViewController {
    var userAddressList: [Address]?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        removeUI()
        loadData()
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
    
    func loadData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let user = CommonStore.shared.getUser()
        let request: NSFetchRequest<Address> = Address.fetchRequest()
        let emailPredicate = NSPredicate(format: "belongsTo.email MATCHES %@", user!.email!)
        request.predicate = emailPredicate
        do {
            userAddressList = try context.fetch(request)
        } catch { CustomToast.showErrorToast(msg: "Failed to get all users data", sender: self) }
    }
}

//MARK: Create UI Methods
extension MyAddressViewController {
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
        
        BackButton.addBackButton(to: pageStackView, title: "My Address", sender: self)
        pageStackView.setCustomSpacing(40, after: pageStackView.arrangedSubviews.last!)
        
        if userAddressList!.isEmpty {
            let label = createAddressEmptyLabel()
            pageStackView.addArrangedSubview(label)
            pageStackView.setCustomSpacing(40, after: pageStackView.arrangedSubviews.last!)
            label.widthAnchor.constraint(equalTo: pageStackView.widthAnchor).isActive = true
        } else {
            print(userAddressList?.count)
        }
        let addButton = createAddButton()
        pageStackView.addArrangedSubview(addButton)
        addButton.widthAnchor.constraint(equalTo: pageStackView.widthAnchor).isActive = true
    }
    
    func createAddressEmptyLabel() -> UILabel{
        let label = UILabel()
        let attributedTitle = NSAttributedString(
            string: "There are no address recorded",
            attributes: [.font : UIFont(name: "Futura-Medium", size: 18)!]
        )
        label.attributedText = attributedTitle
        label.textAlignment = .center
        return label
    }
    
    func createAddButton() -> UIButton{
        let addButton = CustomButton.createBlackButton(
            title: "Add new address",
            action: UIAction(handler: { action in
                self.navigationController?.pushViewController(AddAddressViewController(), animated: true)
            })
        )
        return addButton
    }
}
