//
//  TermsConditionViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 21/11/23.
//

import UIKit

class TermsConditionViewController : UIViewController {
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

extension TermsConditionViewController {
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

        let backButton = BackButton.createBackButton(title: "Terms And Conditions" , icName: "icBack", usePadding: true, tapped: UIAction(handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        let overview = createSection(
            sectionTitle: "Overview",
            sectionDesc: "This website is operated by Baltini. Throughout the site, the terms “we”, “us,” and “our” refer to Baltini. Baltini offers this website, including all information, tools, and services available from this site to you, the user, conditioned upon your acceptance of all terms, conditions, policies, and notices stated here."
        )
        let overview2 = createSection(sectionDesc: "By visiting our site and/ or purchasing something from us, you engage in our “Service” and agree to be bound by the following terms and conditions (“Terms of Service”, “Terms”), including those additional terms and conditions and policies referenced herein and/or available by hyperlink. These Terms of Service apply to all site users, including, without limitation, users who are browsers, vendors, customers, merchants, and/ or contributors of content.")
        let overview3 = createSection(sectionDesc: "Please read these Terms of Service carefully before accessing or using our website. By accessing or using any part of the site, you agree to be bound by these Terms of Service. If you do not agree to all the terms and conditions of this agreement, then you may not access the website or use any services. If these Terms of Service are considered an offer, acceptance is expressly limited to these Terms of Service.")
        
        stackView.addArrangedSubview(backButton)
        stackView.setCustomSpacing(18, after: backButton)
        stackView.addArrangedSubview(overview)
        stackView.setCustomSpacing(8, after: overview)
        stackView.addArrangedSubview(overview2)
        stackView.setCustomSpacing(8, after: overview2)
        stackView.addArrangedSubview(overview3)
        
        backButton.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        overview.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        overview.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        overview2.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        overview2.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        overview3.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        overview3.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
    }
    
    func createSection(sectionTitle: String? = nil, sectionDesc: String) -> UIStackView {
        let section = UIStackView()
        section.axis = .vertical
        section.translatesAutoresizingMaskIntoConstraints = false
        
        if sectionTitle != nil {
            let titleLabel = createLabel(text: sectionTitle!, fontSize: 16, color: .black, align: .justified)
            section.addArrangedSubview(titleLabel)
            section.setCustomSpacing(8, after: titleLabel)
        }
        let descLabel = createLabel(text: sectionDesc, fontSize: 14, color: .black, align: .justified)
        section.addArrangedSubview(descLabel)
        
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
