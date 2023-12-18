//
//  ReturnRefundViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 17/12/23.
//

import Foundation
import UIKit

class ReturnRefundViewController: UIViewController {
    let titles = [
        "Do I need an account to place an order?", "How do I place an order on your site?", "Where can I find size & fit advice?",
        "Can I cancel my Baltini order or make changes to it?", "I have forgotten my password: what should I do?"
    ]
    let descs = [
        "Do I need an account to place an order?" : "No, all you need is an email address. We recommend you register for an account to add pieces to your Wishlist. However, you can also place and track orders as a guest and sign up at a time that suits you.",
        "How do I place an order on your site?" : "You need to checkout the items after adding those items to your cart.",
        "Where can I find size & fit advice?" : "You could see our size chart by going to the details of each product or if you're still don't know what size you are, you can send messages and our staff would be happy to help.",
        "Can I cancel my Baltini order or make changes to it?" : "Yes, you can cancel your Baltini orders but currently you can't make changes yet.",
        "I have forgotten my password: what should I do?" : "You can use the forgot password so that we can send a link to reset your password after verifying your identity."
    ]
    var showDesc = [
        "Do I need an account to place an order?" : true,
        "How do I place an order on your site?" : false,
        "Where can I find size & fit advice?" : false,
        "Can I cancel my Baltini order or make changes to it?" : false,
        "I have forgotten my password: what should I do?" : false,
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
extension ReturnRefundViewController {
    
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
        
        let backButton = BackButton.createBackButton(title: "Returns and Refunds" , icName: "icBack", usePadding: false, tapped: UIAction(handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        
        let overview = createLabel(
            text: "How To Shop At Baltini",
            fontSize: 16,
            color: .black,
            align: .left,
            isBold: true
        )
    
        pageStackView.addArrangedSubview(backButton)
        pageStackView.setCustomSpacing(18, after: backButton)
        pageStackView.addArrangedSubview(overview)
        pageStackView.setCustomSpacing(16, after: overview)
        
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
            let desc = createLabel(text: descs[title]! , fontSize: 14, color: .black, align: .left, isBold: false)
            contentStack.addArrangedSubview(desc)
            contentStack.setCustomSpacing(16, after: desc)
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
    
    func createLabel(text: String, fontSize: CGFloat, color: UIColor, align: NSTextAlignment, isBold: Bool) -> UILabel {
        let label = UILabel()
        label.text =  text
        label.font = UIFont(name: isBold ? "Futura-Bold" : "Futura-Medium", size: fontSize)
        label.textColor = color
        label.numberOfLines = 0
        label.textAlignment = align
        
        return label
    }
    
    func iconPressed(title: String){
        showDesc[title]!.toggle()
        removeUI()
        createUI()
    }
}
