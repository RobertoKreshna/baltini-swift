//
//  LoginViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 26/10/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        createUI()
    }
    
    func setupNavigationItem(){
        
    }
}

//MARK: Create UI Methods
extension LoginViewController {
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
    }
}
