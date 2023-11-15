//
//  CategoryViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 25/10/23.
//

import UIKit
import LZViewPager

class CategoryViewController: UIViewController {
    
    private var subControllers:[UIViewController] = {
        let womanVC = WomanCategoryViewController()
        womanVC.title = "WOMAN"
        let manVC = ManCategoryViewController()
        manVC.title = "MAN"
        return [womanVC, manVC]
    }()
    
    private var contentViewPager = LZViewPager()
        
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
extension CategoryViewController {
    func createUI(){
        view.backgroundColor = .white
        
        //create stack view
        let stackView = UIStackView()
        view.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.isUserInteractionEnabled = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let backButton = BackButton.createBackButton(title: "Woman" , icName: "icBack", usePadding: true, tapped: UIAction(handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        stackView.addArrangedSubview(backButton)
        backButton.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        
        contentViewPager.dataSource = self
        contentViewPager.delegate = self
        contentViewPager.hostController = self
        
        stackView.addArrangedSubview(contentViewPager)
        
        contentViewPager.reload()
    }
}

//MARK: View Pager Methods
extension CategoryViewController: LZViewPagerDelegate, LZViewPagerDataSource {
    func numberOfItems() -> Int {
        return subControllers.count
    }
    
    func controller(at index: Int) -> UIViewController {
        return subControllers[index]
    }
    
    func leftMarginForHeader() -> CGFloat {
        return CGFloat(16)
    }
    
    func rightMarginForHeader() -> CGFloat {
        return CGFloat(16)
    }
    
    func colorForIndicator(at index: Int) -> UIColor {
        return UIColor.black
    }
    
    func button(at index: Int) -> UIButton {
        let button = UIButton()
        button.setAttributedTitle(
            NSAttributedString(
                string: subControllers[index].title!,
                attributes: [.font : UIFont(name: "Futura-Medium", size: 14)!, .foregroundColor : UIColor.black]
            ),
            for: .normal
        )
        button.setAttributedTitle(
            NSAttributedString(
                string: subControllers[index].title!,
                attributes: [.font : UIFont(name: "Futura-Bold", size: 14)!, .foregroundColor : UIColor.black]
            ),
            for: .selected
        )
        button.backgroundColor = .white
        return button
    }
    
    
}
