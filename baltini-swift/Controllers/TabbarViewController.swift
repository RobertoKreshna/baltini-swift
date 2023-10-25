//
//  TabbarViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 24/10/23.
//

import UIKit

class TabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    func setupTabs(){
        //init vc
        let homeVC = HomeViewController()
        let categoryVC = CategoryViewController()
        let orderVC = OrderViewController()
        let accountVC = AccountViewController()
        
        // give vc title
        homeVC.title = "HOME"
        categoryVC.title = "CATEGORY"
        orderVC.title = "ORDER"
        accountVC.title = "ACCOUNT"
        
        //add to tabbar
        self.setViewControllers( [ homeVC, categoryVC, orderVC, accountVC ] ,animated: false)
        
        //customize items
        guard let items = self.tabBar.items else { return }
        let images: [String] = [
            "icHomeInactive",
            "icCategoryInactive",
            "icOrderInactive",
            "icAccountInactive",
        ]
        for i in 0...3 {
            items[i].image = UIImage(named: images[i])
            
            let attributes = [NSAttributedString.Key.font:UIFont(name: "Futura-Medium", size: 10)]
            items[i].setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
            
            let attributesSelected = [NSAttributedString.Key.font:UIFont(name: "Futura-Bold", size: 10)]
            items[i].setTitleTextAttributes(attributesSelected as [NSAttributedString.Key : Any], for: .selected)
        }
        
        //customize tabbar
        self.tabBar.barTintColor = .black
        self.tabBar.backgroundColor = .black
        self.tabBar.tintColor = .white
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item.title)
    }
}
