//
//  ClothingTypeFilterViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 06/12/23.
//

import UIKit

class ClothingTypeFilterViewController : UIViewController {
    let types = [
        "T-Shirt", "Sweatshirt", "Trousers", "Shorts", "Shirt", "Jacket", "Jeans", "Briefs", "Shoes", "Blazer", "Jumper", "Swim shorts", "Bag",
        "Coat", "Cardigan", "Leggings", "Skirt", "Blouse", "Bodysuit", "Pyjamas", "Bustier", "Socks", "Jumpsuit"
    ]
    
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
extension ClothingTypeFilterViewController {
    func createUI(){
        self.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3)
        view.backgroundColor = .white
       
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let contentView = CustomBottomSheet.createCheckboxListFilterContent(
            title: "FILTER - CLOTHING TYPE",
            key: "Product Type",
            data: types,
            selectedData: SortFilterValue.shared.getFilterDictValues()[2],
            close: { self.navigationController?.popViewController(animated: true) }
        )
        scrollView.addSubview(contentView)
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
}
