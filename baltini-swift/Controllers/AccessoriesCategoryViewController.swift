//
//  AccCategoryViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 13/11/23.
//

import UIKit

class AccessoriesCategoryViewController: UIViewController {
    
    private let clothingData = [
        "Man" : ["Belts", "Eyewear", "Hats", "Jewelry", "Other Accessories", "Scarves", "Small Leather Goods"],
        "Woman": ["Belts", "Eyewear", "Hats", "Jewelry", "Scarves & Wraps", "Small Leather Goods", "Other Accessories"]
    ]
    
    var selectedGender: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
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


//MARK: Create UI Methods
extension AccessoriesCategoryViewController {
    
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
        stackView.isUserInteractionEnabled = true
        stackView.spacing = 4
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        BackButton.addBackButton(to: stackView, title: "Clothing", icName: "icBack", sender: self, usePadding: true)
        stackView.setCustomSpacing(24, after: stackView.arrangedSubviews.last!)
        
        clothingData[selectedGender!]?.forEach({ string in
            let row = CustomCell.createCategoryCell(
                title: string,
                useIcon: false,
                tapped: UITapGestureRecognizer(target: self, action: #selector(tapped))
            )
            stackView.addArrangedSubview(row)
        })
    }
}

//MARK: Tapped
extension AccessoriesCategoryViewController {
    @objc func tapped(){
        print("tapped")
    }
}

