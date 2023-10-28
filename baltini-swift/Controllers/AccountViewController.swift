//
//  AccountViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 25/10/23.
//

import UIKit

class AccountViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        removeUI()
        createUI()
    }
    
     func removeUI() {
        let subviews = view.subviews
        subviews.forEach { subview in
            subview.removeFromSuperview()
        }
    }
}

//MARK: Create UI methods
extension AccountViewController {

    func createUI(){
        view.backgroundColor = .white
        
        let pageStackView = UIStackView()
        pageStackView.axis = .vertical
        view.addSubview(pageStackView)
        
        pageStackView.translatesAutoresizingMaskIntoConstraints = false
        pageStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 22).isActive = true
        pageStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        pageStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
        let titleLabel = UILabel()
        titleLabel.text = "My Account"
        titleLabel.font = UIFont(name: "Futura-Medium", size: 18)!
        
        pageStackView.addArrangedSubview(titleLabel)
        pageStackView.setCustomSpacing(30, after: titleLabel)
        
        if(CommonStore.shared.getUser() != nil) {
            let profileRow = createBlackRow(title: "My Profile")
            let addressRow = createBlackRow(title: "My Address")
            pageStackView.addArrangedSubview(profileRow)
            pageStackView.addArrangedSubview(addressRow)
            profileRow.widthAnchor.constraint(equalTo: pageStackView.widthAnchor).isActive = true
            addressRow.widthAnchor.constraint(equalTo: pageStackView.widthAnchor).isActive = true
        }
        
        let magazineRow = createBlackRow(title: "Baltini Magazine")
        let aboutRow = createBlackRow(title: "About Baltini")
        let tcRow = createBlackRow(title: "Terms and Conditions")
        let partnerRow = createBlackRow(title: "Partnership")
        let helpsRow = createBlackRow(title: "Helps")
        
        pageStackView.addArrangedSubview(magazineRow)
        pageStackView.addArrangedSubview(aboutRow)
        pageStackView.addArrangedSubview(tcRow)
        pageStackView.addArrangedSubview(partnerRow)
        pageStackView.addArrangedSubview(helpsRow)
        
        magazineRow.widthAnchor.constraint(equalTo: pageStackView.widthAnchor).isActive = true
        aboutRow.widthAnchor.constraint(equalTo: pageStackView.widthAnchor).isActive = true
        tcRow.widthAnchor.constraint(equalTo: pageStackView.widthAnchor).isActive = true
        partnerRow.widthAnchor.constraint(equalTo: pageStackView.widthAnchor).isActive = true
        helpsRow.widthAnchor.constraint(equalTo: pageStackView.widthAnchor).isActive = true
        
        if(CommonStore.shared.getUser() != nil) {
            let logoutRow = createRedRow(title: "Logout")
            pageStackView.addArrangedSubview(logoutRow)
            logoutRow.widthAnchor.constraint(equalTo: pageStackView.widthAnchor).isActive = true
        }
        
        if(CommonStore.shared.getUser() == nil) {
            pageStackView.setCustomSpacing(30, after: helpsRow)
            let loginButton = CustomButton.createWhiteButton(
                title: "LOGIN TO BALTINI",
                action: UIAction(handler: { action in
                    self.navigationController?.pushViewController(LoginViewController(), animated: true)
                })
            )
            pageStackView.addArrangedSubview(loginButton)
            loginButton.widthAnchor.constraint(equalTo: pageStackView.widthAnchor).isActive = true
        }
        
    }
    
    func createBlackRow(title: String) -> UIView {
        let row = UIStackView()
        row.axis = .horizontal
        
        let label = UILabel()
        label.text = title
        label.font = UIFont(name: "Futura-Medium", size: 14)!
        
        let image = UIImageView(image: UIImage(named: "icRight"))
        
        row.addArrangedSubview(label)
        row.addArrangedSubview(image)
        
        row.layoutMargins = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)
        row.isLayoutMarginsRelativeArrangement = true
        
        return row
    }
    
    func createRedRow(title: String) -> UIView {
            let row = UIStackView()
            row.axis = .horizontal
            
            let label = UILabel()
            label.text = title
            label.font = UIFont(name: "Futura-Medium", size: 14)!
            label.textColor = .brandRed
            
            let image = UIImageView(image: UIImage(named: "icLogout"))
            
            row.addArrangedSubview(label)
            row.addArrangedSubview(image)
            
            row.layoutMargins = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)
            row.isLayoutMarginsRelativeArrangement = true
        
        row.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(logout)))
            
            return row
        }
    
    @objc func logout() {
        CommonStore.shared.setUser(user: nil)
        removeUI()
        createUI()
    }
}

