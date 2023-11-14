//
//  MenCategoryViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 13/11/23.
//

import UIKit

class ManCategoryViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
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
extension ManCategoryViewController {
    func createUI(){
        view.backgroundColor = .white
        
        //create stack view
        let stackView = UIStackView()
        view.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.spacing = 4
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        let designerCell = CustomCell.createCategoryCell(
            title: "Designer",
            useIcon: true,
            tapped:UITapGestureRecognizer(target: self, action: #selector(goToDesigner))
        )
        let newArrivalCell = CustomCell.createCategoryCell(
            title: "New Arrival",
            useIcon: false,
            tapped:UITapGestureRecognizer(target: self, action: #selector(tapped))
        )
        let saleCell = CustomCell.createCategoryCell(
            title: "SALE",
            useIcon: false,
            tapped:UITapGestureRecognizer(target: self, action: #selector(tapped))
        )
        let allCell = CustomCell.createCategoryCell(
            title: "Shop All",
            useIcon: false,
            tapped:UITapGestureRecognizer(target: self, action: #selector(tapped))
        )
        let clothingCell = CustomCell.createCategoryCell(
            title: "Clothing",
            useIcon: true,
            tapped:UITapGestureRecognizer(target: self, action: #selector(goToClothing))
        )
        let shoeCell = CustomCell.createCategoryCell(
            title: "Shoes",
            useIcon: true,
            tapped:UITapGestureRecognizer(target: self, action: #selector(goToShoes))
        )
        let bagCell = CustomCell.createCategoryCell(
            title: "Bags",
            useIcon: true,
            tapped:UITapGestureRecognizer(target: self, action: #selector(goToBags))
        )
        let accCell = CustomCell.createCategoryCell(
            title: "Accessories",
            useIcon: true,
            tapped:UITapGestureRecognizer(target: self, action: #selector(goToAccessories))
        )
        
        stackView.addArrangedSubview(designerCell)
        stackView.addArrangedSubview(newArrivalCell)
        stackView.addArrangedSubview(saleCell)
        stackView.addArrangedSubview(allCell)
        stackView.addArrangedSubview(clothingCell)
        stackView.addArrangedSubview(shoeCell)
        stackView.addArrangedSubview(bagCell)
        stackView.addArrangedSubview(accCell)
    }
}

//MARK: Navigations

extension ManCategoryViewController {
    @objc func tapped(){
        print("tapped")
    }
    
    @objc func goToDesigner(){
        let vc = DesignerViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goToClothing(){
        let vc = ClothingCategoryViewController()
        vc.selectedGender = "Man"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goToShoes(){
        let vc = ShoesCategoryViewController()
        vc.selectedGender = "Man"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goToBags(){
        let vc = BagsCategoryViewController()
        vc.selectedGender = "Man"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goToAccessories(){
        let vc = AccessoriesCategoryViewController()
        vc.selectedGender = "Man"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
