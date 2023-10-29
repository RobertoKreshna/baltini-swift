//
//  CategoryViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 25/10/23.
//

import UIKit

class CategoryViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        view.backgroundColor = .systemRed
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
