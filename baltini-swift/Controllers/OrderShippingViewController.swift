//
//  OrderShippingViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 14/12/23.
//

import Foundation
import UIKit

class OrderShippingViewController : UIViewController {
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

extension OrderShippingViewController {
    func createUI(){
        view.backgroundColor = .white
        
        //create scroll view
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //create stack view
        let stackView = UIStackView()
        scrollView.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let backButton = BackButton.createBackButton(title: "Orders and Shipping" , icName: "icBack", usePadding: true, tapped: UIAction(handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        let overview = createSection(
            sectionTitle: "Purchases",
            sectionDesc: "Every purchase includes customs duties and free shipping (on all orders over $200), so you won’t need to pay additional fees upon receipt of your imported item. More details can be found below."
        )
        let overview2 = createSectionWithDot(sectionDesc: "Delivery duties are included and calculated at the time of checkout. The price you see is the price you pay.")
        let overview3 = createSectionWithDot(sectionDesc: "You will only be given one total payment amount if you purchase multiple items from various luxury boutiques.")
        let overview4 = createSectionWithDot(sectionDesc: "You will receive a confirmation email after placing an order and will receive another email with your tracking number once we’ve shipped your order.")
        let overview5 = createSectionWithDot(
            sectionDesc: "If any problems arise while processing your order, you will receive an email with a description of the issue or a request for further information.")
        let overview6 = createSectionWithDot(sectionDesc: "In some cases, we might occasionally need to check with your card issuer to confirm your order. We always do our best to keep delays to a minimum and ship your items as quickly as we can.")
        let overview7 = createSection(sectionTitle: "Please note, once an order has been placed, we are unable to make changes to the order details or delivery address. Please ensure all details are correct prior to purchasing.")
        
        stackView.addArrangedSubview(backButton)
        stackView.setCustomSpacing(18, after: backButton)
        stackView.addArrangedSubview(overview)
        stackView.setCustomSpacing(8, after: overview)
        stackView.addArrangedSubview(overview2)
        stackView.setCustomSpacing(8, after: overview2)
        stackView.addArrangedSubview(overview3)
        stackView.setCustomSpacing(8, after: overview3)
        stackView.addArrangedSubview(overview4)
        stackView.setCustomSpacing(8, after: overview4)
        stackView.addArrangedSubview(overview5)
        stackView.setCustomSpacing(8, after: overview5)
        stackView.addArrangedSubview(overview6)
        stackView.setCustomSpacing(16, after: overview6)
        stackView.addArrangedSubview(overview7)
        
        backButton.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        overview.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        overview.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        overview2.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        overview2.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        overview3.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        overview3.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        overview4.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        overview4.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        overview5.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        overview5.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        overview6.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        overview6.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        overview7.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        overview7.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
    }
    
    func createSectionWithDot(sectionTitle: String? = nil, sectionDesc: String? = nil) -> UIStackView {
        let row = UIStackView()
        row.axis = .horizontal
        row.alignment = .leading
        row.translatesAutoresizingMaskIntoConstraints = false
        
        let dot = UIImageView(image: UIImage(named: "icDot"))
        let section = createSection(sectionTitle: sectionTitle, sectionDesc: sectionDesc)
        
        row.addArrangedSubview(dot)
        row.setCustomSpacing(8, after: dot)
        row.addArrangedSubview(section)
        
        return row
    }
    
    func createSection(sectionTitle: String? = nil, sectionDesc: String? = nil) -> UIStackView {
        let section = UIStackView()
        section.axis = .vertical
        section.translatesAutoresizingMaskIntoConstraints = false
        
        if sectionTitle != nil {
            let titleLabel = createLabel(text: sectionTitle!, fontSize: 16, color: .black, align: .justified)
            section.addArrangedSubview(titleLabel)
            section.setCustomSpacing(8, after: titleLabel)
        }
        if sectionDesc != nil {
            let descLabel = createLabel(text: sectionDesc!, fontSize: 14, color: .black, align: .justified)
            section.addArrangedSubview(descLabel)
        }
        
        return section
    }
    
    func createLabel(text: String, fontSize: CGFloat, color: UIColor, align: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.text =  text
        label.font = UIFont(name: "Futura-Medium", size: fontSize)
        label.textColor = color
        label.numberOfLines = 0
        label.textAlignment = align
        
        return label
    }
}
