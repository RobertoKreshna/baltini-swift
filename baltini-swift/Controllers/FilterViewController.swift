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
        self.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height * 0.4) + 32)
        view.backgroundColor = .white
        view.clipsToBounds = true
        
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
        view.addSubview(contentView)

        contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 12).isActive = true
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
        self.navigationController?.pushViewController(PriceFilterViewController(), animated: true)
    }
}
