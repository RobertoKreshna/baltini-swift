//
//  HelpsViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 11/12/23.
//

import UIKit

class HelpsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
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
extension HelpsViewController {
    
    func createUI(){
        view.backgroundColor = .white
        
        let pageStackView = UIStackView()
        pageStackView.axis = .vertical
        view.addSubview(pageStackView)
        
        pageStackView.translatesAutoresizingMaskIntoConstraints = false
        pageStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pageStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        pageStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true

        let backButton = BackButton.createBackButton(title: "Helps" , icName: "icBack", usePadding: false, tapped: UIAction(handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        
        let contactRow = createBlackRow(title: "Contact Us", action: #selector(goToContactUs))
        let accessibilityRow = createBlackRow(title: "Accessibility Statement", action: #selector(goToAccessibility))
        let authenticRow = createBlackRow(title: "Authenticity Guarantee", action: #selector(goToAuthenticity))
        let orderShippingRow = createBlackRow(title: "Orders and Shipping", action: #selector(goToOrderShipping))
        let shippingInsuranceRow = createBlackRow(title: "Shipping Insurance Policies", action: #selector(tapped))
        let returnRefundRow = createBlackRow(title: "Returns and Refunds", action: #selector(tapped))
        let reqReturnRow = createBlackRow(title: "Request a Return", action: #selector(tapped))
        let prodCareRow = createBlackRow(title: "Product Care", action: #selector(tapped))
        let klarnaRow = createBlackRow(title: "Klarna Payment", action: #selector(tapped))
        let faqRow = createBlackRow(title: "FAQs", action: #selector(tapped))
        
        pageStackView.addArrangedSubview(backButton)
        pageStackView.setCustomSpacing(10, after: backButton)
        pageStackView.addArrangedSubview(contactRow)
        pageStackView.addArrangedSubview(accessibilityRow)
        pageStackView.addArrangedSubview(authenticRow)
        pageStackView.addArrangedSubview(orderShippingRow)
        pageStackView.addArrangedSubview(shippingInsuranceRow)
        pageStackView.addArrangedSubview(returnRefundRow)
        pageStackView.addArrangedSubview(reqReturnRow)
        pageStackView.addArrangedSubview(prodCareRow)
        pageStackView.addArrangedSubview(klarnaRow)
        pageStackView.addArrangedSubview(faqRow)
    }
    
    func createBlackRow(title: String, action: Selector) -> UIView {
        let row = UIStackView()
        row.axis = .horizontal
        
        let label = UILabel()
        label.text = title
        label.font = UIFont(name: "Futura-Medium", size: 14)!
        
        let image = UIImageView(image: UIImage(named: "icRight"))
        
        row.addArrangedSubview(label)
        row.addArrangedSubview(image)
        
        row.layoutMargins = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)
        row.isLayoutMarginsRelativeArrangement = true
        
        row.addGestureRecognizer(UITapGestureRecognizer(target: self, action: action))
        
        return row
    }
    
    @objc func tapped(){ print("abc") }
    
    @objc func goToContactUs(){
        self.navigationController?.pushViewController(ContactUsViewController(), animated: true)
    }
    
    @objc func goToAccessibility(){
        self.navigationController?.pushViewController(AccessibilityViewController(), animated: true)
    }
    
    @objc func goToAuthenticity(){
        self.navigationController?.pushViewController(AuthenticityViewController(), animated: true)
    }
    @objc func goToOrderShipping(){
        self.navigationController?.pushViewController(OrderShippingViewController(), animated: true)
    }
}
