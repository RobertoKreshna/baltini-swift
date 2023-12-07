//
//  ClothingTypeFilterViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 06/12/23.
//

import UIKit

class ProductTypeFilterViewController : UIViewController {
    let types = [
        "T-Shirt", "Sweatshirt", "Trousers", "Shorts", "Shirt", "Jacket", "Jeans", "Briefs", "Shoes", "Blazer", "Jumper", "Swim shorts", "Bag",
        "Coat", "Cardigan", "Leggings", "Skirt", "Blouse", "Bodysuit", "Pyjamas", "Bustier", "Socks", "Jumpsuit"
    ]
    
    var contentView: UIStackView? = nil
    
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
extension ProductTypeFilterViewController {
    func createUI(){
        self.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.66)
        view.backgroundColor = .white
        
        
        let button = CustomButton.createBlackButton(title: "FILTER", action: UIAction(handler: { action in
            var res = [String]()
            let allTiles = self.getAllTilesFromPage()
            allTiles.forEach { tile in
                let imageView = tile.arrangedSubviews[0] as! UIImageView
                let label = tile.arrangedSubviews[1] as! UILabel
                if imageView.image == UIImage(named: "icCheckSelected") { res.append(label.text!) }
            }
            SortFilterValue.shared.addFilterTo(key: "Product Type", value: res)
            self.navigationController?.popViewController(animated: true)
        }))
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
       
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -12).isActive = true
        
        contentView = CustomBottomSheet.createCheckboxListFilterContent(
            title: "FILTER - CLOTHING TYPE",
            key: "Product Type",
            data: types,
            selectedData: SortFilterValue.shared.getFilterDictValues()[2],
            close: { self.navigationController?.popViewController(animated: true) }
        )
        
        scrollView.addSubview(contentView!)
        
        contentView!.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView!.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        contentView!.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        contentView!.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
}

//MARK: Logic
extension ProductTypeFilterViewController {
    func getAllTilesFromPage() -> [UIStackView] {
        let subviews = contentView?.arrangedSubviews
        var res: [UIStackView] = [UIStackView]()
        for i in 2 ..< subviews!.count {
            res.append(subviews![i] as! UIStackView)
        }
        return res
    }
}
