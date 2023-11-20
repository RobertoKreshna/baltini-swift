//
//  SearchViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 20/11/23.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    var searchHistory = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
        removeUI()
        getSearchHistory()
        createUI()
    }
    
    func removeUI() {
       let subviews = view.subviews
       subviews.forEach { subview in
           subview.removeFromSuperview()
       }
   }
}

//MARK: Load Data
extension SearchViewController {
    func getSearchHistory(){
        searchHistory = CommonStore.shared.getSearchHistory()
    }
}

//MARK: Create UI Methods
extension SearchViewController {
    func createUI(){
        //change view bg color
        view.backgroundColor = .white
        
        //create scroll view
        let scrollView = UIScrollView()
        scrollView.isUserInteractionEnabled = true
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //create stack view
        let stackView = UIStackView()
        scrollView.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.isUserInteractionEnabled = true
        stackView.spacing = 16
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let backButton = BackButton.createBackSearchBar(owner: self, backTapped: UIAction(handler: { action in
            self.dismiss(animated: false)
        }))
        
        stackView.addArrangedSubview(backButton)
        backButton.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        backButton.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
    }
}

//MARK: Textfield Delegate Methods
extension SearchViewController : UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text)
    }
}
