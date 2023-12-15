//
//  ShippingPoliciesViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 15/12/23.
//

import Foundation
import UIKit

class ShippingPoliciesViewController: UIViewController {
    let titles = ["Lost Items Policies", "Stolen Items Policies", "Damaged Items Policies", "General Policies"]
    let descs = [
        "Lost Items Policies" : "we cover the subtotal of the order. Shipping costs, taxes, and the premium are not included. In some circumstances, we will only issue a store credit instead of refund, depending on the situation.",
        "Stolen Items Policies" : "we cover the subtotal of the order. Shipping costs, taxes, and the premium are not included. In some circumstances, we will only issue a store credit instead of refund, depending on the situation.",
        "Damaged Items Policies" : "we cover the subtotal of the order. Shipping costs, taxes, and the premium are not included. In some circumstances, we will only issue a store credit instead of refund, depending on the situation.",
        "General Policies" : "we cover the subtotal of the order. Shipping costs, taxes, and the premium are not included. In some circumstances, we will only issue a store credit instead of refund, depending on the situation.",
    ]
    var showDesc = [
        "Lost Items Policies" : true,
        "Stolen Items Policies" : false,
        "Damaged Items Policies" : false,
        "General Policies" : false,
    ]
    
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
extension ShippingPoliciesViewController {
    
    func createUI(){
        view.backgroundColor = .white
        
        //create scroll view
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        let pageStackView = UIStackView()
        pageStackView.translatesAutoresizingMaskIntoConstraints = false
        pageStackView.axis = .vertical
        scrollView.addSubview(pageStackView)
        
        pageStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        pageStackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16).isActive = true
        pageStackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16).isActive = true
        pageStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        pageStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32).isActive = true
        
        let backButton = BackButton.createBackButton(title: "Shipping Insurance Policies" , icName: "icBack", usePadding: false, tapped: UIAction(handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        
        let overview = createLabel(normalString: "Only eligible if shipping protection is selected. By deselecting shipping protection, BALTINI CORPORATION is Not Liable for lost, damaged or stolen items.")
        let overview2 = createLabel(
            boldString: "When Refunding An Item",
            normalString: "we cover the subtotal of the order. Shipping costs, taxes, and the premium are not included. In some circumstances, we will only issue a store credit instead of refund, depending on the situation."
        )
        let overview3 = createLabel(
            boldString: "When Replacing An Item",
            normalString: "we cover the subtotal of the order, the premium, shipping costs, and taxes. We do not pay custom/duty fees."
        )
    
        pageStackView.addArrangedSubview(backButton)
        pageStackView.setCustomSpacing(18, after: backButton)
        pageStackView.addArrangedSubview(overview)
        pageStackView.setCustomSpacing(16, after: overview)
        pageStackView.addArrangedSubview(overview2)
        pageStackView.setCustomSpacing(16, after: overview2)
        pageStackView.addArrangedSubview(overview3)
        pageStackView.setCustomSpacing(16, after: overview3)
        
        titles.forEach { title in
            let row = createRow(title: title , showDesc: showDesc[title]!)
            pageStackView.addArrangedSubview(row)
        }
    }
    
    func createRow(title: String, showDesc: Bool) -> UIStackView{
        let contentStack = UIStackView()
        contentStack.axis = .vertical
        
        let titleRow = createTitleRow(title: title, showDesc: showDesc)
        contentStack.addArrangedSubview(titleRow)
        contentStack.setCustomSpacing(14, after: titleRow)
        
        if(showDesc == true){
            let chart = createLabel(boldString: title, normalString: descs[title]!)
            contentStack.addArrangedSubview(chart)
            contentStack.setCustomSpacing(16, after: chart)
        }
        
        contentStack.isLayoutMarginsRelativeArrangement = true
        contentStack.layoutMargins = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)
        
        return contentStack
    }
    
    func createTitleRow(title: String, showDesc: Bool) -> UIStackView{
        let titleRow = UIStackView()
        titleRow.axis = .horizontal
        titleRow.distribution = .equalCentering
        titleRow.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedTitle = NSAttributedString(
            string: title,
            attributes: [.font : UIFont(name: "Futura-Medium", size: 14)!, .foregroundColor : UIColor.black]
        )
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.attributedText = attributedTitle
        
        let toggleButton = UIButton(type: .system)
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        toggleButton.setImage(UIImage(named: showDesc ? "icUp" : "icDown")?.withRenderingMode(.alwaysOriginal), for: .normal)
        toggleButton.addAction(UIAction(handler: { pressed in self.iconPressed(title: title) }), for: .touchUpInside)
        
        titleRow.addArrangedSubview(titleLabel)
        titleRow.addArrangedSubview(toggleButton)
        
        return titleRow
    }
    
    func createLabel(boldString: String? = nil, normalString: String) -> UILabel{
        let label = UILabel()
        label.attributedText = createString(boldString: boldString, normalString: normalString)
        label.numberOfLines = 0
        label.textAlignment = .justified
        
        return label
    }
    
    func createString(boldString: String?, normalString: String) -> NSAttributedString {
        let myMutableString = NSMutableAttributedString(
            string: boldString == nil ? normalString : "\(boldString!), \(normalString)",
            attributes: [NSAttributedString.Key.font: UIFont(name: "Futura-Medium", size: 14)!]
        )
        myMutableString.addAttribute(.font, value: UIFont(name: "Futura-Bold", size: 14)!, range: NSRange(location: 0, length: boldString?.count ?? 0))
        return myMutableString
    }
    
    func iconPressed(title: String){
        showDesc[title]!.toggle()
        removeUI()
        createUI()
    }
}
