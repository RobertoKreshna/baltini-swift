//
//  CartViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 11/11/23.
//

import Foundation
import UIKit
import BadgeSwift

class CartViewController: UIViewController {

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


//MARK: Create UI Methods
extension CartViewController {
    func createUI(){
        //change view bg color
        view.backgroundColor = .white
        
        //create scroll view
        let scrollView = UIScrollView()
        scrollView.isUserInteractionEnabled = true
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //create stack view
        let stackView = UIStackView()
        scrollView.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.isUserInteractionEnabled = true
        stackView.spacing = 16
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let backButton = BackButton.createBackButton(title: "Cart (\(CommonStore.shared.getCartProductCount()))", icName: "icBack", usePadding: true, tapped: UIAction(handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        stackView.addArrangedSubview(backButton)
        backButton.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        
        stackView.setCustomSpacing(12, after: backButton)
        if(CommonStore.shared.getCartProductCount() > 0) {
            for i in 0 ... CommonStore.shared.getCartProductCount() - 1 {
                let card = CustomCard.createCartItemCard(
                    product: CommonStore.shared.getCartProductsAtIndex(index: i),
                    qty: CommonStore.shared.getQtyAtIndex(index: i),
                    variant: CommonStore.shared.getVariantsAtIndex(index: i),
                    deletePressed: UIAction(handler: { action in
                        CommonStore.shared.removeProductFromCart(index: i)
                        CustomToast.showGrayUndoToast(
                            msg: "Item deleted to cart.",
                            undoPressed: {
                                CommonStore.shared.undoRemove()
                                UIView.animate(
                                    withDuration: 0.0,
                                    animations: { self.view.alpha = 0.5 },
                                    completion: {(value: Bool) in
                                        self.removeUI()
                                    }
                                )
                                UIView.animate(
                                    withDuration: 0.0,
                                    animations: { self.view.alpha = 1.0 },
                                    completion: {(value: Bool) in
                                        self.createUI()
                                    }
                                )
                            },
                            sender: self
                        )
                        self.removeUI()
                        self.createUI()
                    })
                )
                
                stackView.addArrangedSubview(card)
                
                card.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
                card.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
            }
        }
    }
}
