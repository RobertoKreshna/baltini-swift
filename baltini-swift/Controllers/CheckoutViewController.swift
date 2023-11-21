//
//  CheckoutViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 21/11/23.
//

import UIKit

class CheckoutViewController: UIViewController {
    var itemList : [ProductDetail]?
    var qtyList : [Int]?
    var varIndexList : [Int]?
    var useProtect: Bool?
    
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
extension CheckoutViewController {
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

        let backButton = BackButton.createBackButton(title: "Checkout", icName: "icBack", usePadding: true, tapped: UIAction(handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        
        stackView.addArrangedSubview(backButton)
        backButton.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        
        let orderTitleLabel = UILabel()
        orderTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        orderTitleLabel.text = "ORDER SUMMARY"
        orderTitleLabel.textColor = .black
        orderTitleLabel.font = UIFont(name: "Futura-Medium", size: 14)
        
        stackView.addArrangedSubview(orderTitleLabel)
        orderTitleLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        orderTitleLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        
        createAllProductCard(addTo: stackView)
        createProtectCard(addTo: stackView)
    }
    
    func createAllProductCard(addTo stackView: UIStackView){
        for i in 0 ... itemList!.count - 1 {
            let card = CustomCard.createCheckoutItemCard(item: itemList![i], qty: qtyList![i], variantIndex: varIndexList![i])
            
            stackView.addArrangedSubview(card)
            stackView.setCustomSpacing(i == CommonStore.shared.getCartProductCount() - 1 ? 40 : 24, after: card)
            
            card.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
            card.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        }
    }
    
    func createProtectCard(addTo stackView: UIStackView) {
        print(useProtect)
    }
}
