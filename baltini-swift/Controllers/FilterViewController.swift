//
//  FilterViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 30/11/23.
//

import UIKit

class FilterViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = true
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
extension FilterViewController {
    func createUI(){
        view.backgroundColor = .black.withAlphaComponent(0.2)
        
        let contentView = CustomBottomSheet.createFilterContent(
            keys: SortFilterValue.shared.getFilterDictKeys(),
            values: SortFilterValue.shared.getFilterDictValues(),
            tapped: [
                UITapGestureRecognizer(target: self, action: #selector(self.genderFilterPressed)),
                UITapGestureRecognizer(target: self, action: #selector(self.categoryFilterPressed)),
                UITapGestureRecognizer(target: self, action: #selector(self.productTypeFilterPressed)),
                UITapGestureRecognizer(target: self, action: #selector(self.designerFilterPressed)),
                UITapGestureRecognizer(target: self, action: #selector(self.sizeFilterPressed)),
                UITapGestureRecognizer(target: self, action: #selector(self.priceFilterPressed))
            ], 
            close: {
                self.dismiss(animated: false)
            }
        )
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(
            UIAction(handler: { action in self.dismiss(animated: false)}),
            for: .touchUpInside
        )
        
        view.addSubview(button)
        view.addSubview(contentView)

        contentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.56).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        button.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    @objc private func genderFilterPressed() {
        print("Gender")
    }
    
    @objc private func categoryFilterPressed() {
        print("Category")
    }
    
    @objc private func productTypeFilterPressed() {
        print("Product Type")
    }
    
    @objc private func designerFilterPressed() {
        print("Designer")
    }
    
    @objc private func sizeFilterPressed() {
        print("Size")
    }
    
    @objc private func priceFilterPressed() {
        print("Price")
    }
}
