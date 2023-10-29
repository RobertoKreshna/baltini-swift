//
//  ForgotPasswordViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 27/10/23.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        view.backgroundColor = .green
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
