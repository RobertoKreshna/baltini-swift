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
        self.tabBarController?.tabBar.isHidden = true
        resetPage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func resetPage(){
        removeUI()
        loadData()
        createUI()
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
        
        let backButton = BackButton.createBackButton(title: "My Address" , icName: "icBack", usePadding: false, tapped: UIAction(handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        pageStackView.addArrangedSubview(backButton)
        backButton.topAnchor.constraint(equalTo: pageStackView.topAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: pageStackView.leftAnchor).isActive = true
        pageStackView.setCustomSpacing(24, after: pageStackView.arrangedSubviews.last!)
        
        if userAddressList!.isEmpty {
            let label = createAddressEmptyLabel()
            pageStackView.addArrangedSubview(label)
            pageStackView.setCustomSpacing(40, after: pageStackView.arrangedSubviews.last!)
            label.widthAnchor.constraint(equalTo: pageStackView.widthAnchor).isActive = true
        } else {
            userAddressList?.forEach({ address in
                //add address tile
                let display = CustomDisplay.getAddressDisplay(
                    address: address,
                    deletePressed: UIAction(handler: { action in
                        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                        context.delete(address)
                        do {
                            try context.save()
                            self.resetPage()
                        } catch {
                            print("Error saving context \(error)")
                        }
                    }),
                    editPressed: UIAction(handler: { action in
                        let vc = EditAddressViewController()
                        vc.currentAddress = address
                        self.navigationController?.pushViewController(vc, animated: true)
                    })
                )
                pageStackView.addArrangedSubview(display)
                pageStackView.setCustomSpacing(24, after: display)
                //create constraint
                display.widthAnchor.constraint(equalTo: pageStackView.widthAnchor).isActive = true
            })
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
            title: "ADD NEW ADDRESS",
            action: UIAction(handler: { action in
                self.navigationController?.pushViewController(AddAddressViewController(), animated: true)
            })
        )
        return addButton
    }
}
