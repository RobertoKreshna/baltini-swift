//
//  ProductCareViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 15/12/23.
//

import Foundation
import UIKit

class ProductCareViewController : UIViewController {
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

extension ProductCareViewController {
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

        let backButton = BackButton.createBackButton(title: "Product Care" , icName: "icBack", usePadding: true, tapped: UIAction(handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        let overview = createSection(
            sectionTitle: "General",
            sectionDesc: "Access to any company’s website can be challenging for persons having certain disabilities. A person’s disability is often unique. What may work well for one person, may cause difficulties for another person. Our company has made efforts to accommodate as many of our customers and potential customers as is reasonable given our size, resources, and knowledge of our customers, and potential customer’s needs. To that end we have engaged the services of professionals to assist and advise us in these matters."
        )
        let overview2 = createSection(
            sectionTitle: "Accessibility on this Website",
            sectionDesc: "Our website provides several methods, features, and policies that can help with access to our website and/or to products or services provided or referred to on our website or by our business."
        )
        let overview3 = createSection(
            sectionDesc: "There are also various aids available by third parties and which are provided by most browsers."
        )
        let overview4 = createSection(
            sectionDesc: "If you are having difficulty with access to our website even after utilizing any access features within this website and/or any third party or browser features, we invite you to contact us for further assistance. Contact information is set forth below."
        )
        
        stackView.addArrangedSubview(backButton)
        stackView.setCustomSpacing(18, after: backButton)
        stackView.addArrangedSubview(overview)
        stackView.setCustomSpacing(24, after: overview)
        stackView.addArrangedSubview(overview2)
        stackView.setCustomSpacing(8, after: overview2)
        stackView.addArrangedSubview(overview3)
        stackView.setCustomSpacing(8, after: overview3)
        stackView.addArrangedSubview(overview4)
        
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
