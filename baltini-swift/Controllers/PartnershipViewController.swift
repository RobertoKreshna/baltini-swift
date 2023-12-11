//
//  PartnershipViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 11/12/23.
//

import UIKit

class PartnershipViewController : UIViewController {
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

extension PartnershipViewController {
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

        let backButton = BackButton.createBackButton(title: "Partnerships" , icName: "icBack", usePadding: true, tapped: UIAction(handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        let overview = createSection(
            sectionDesc: "Baltini offers a Partnership Program to collaborate directly with other fashion companies and boutiques worldwide. We make selling your products super easy by giving you access to showcase your brand on our platform to worldwide customers."
        )
        let overview2 = createSection(
            sectionTitle: "What Do You Stand to Gain?",
            sectionDesc: "Becoming a partner lets you make more profit and reach your business goals by getting your products in the faces of our 20,000+ daily unique visitors and growing. Baltini is known for offering luxury fashion items, and our platform is designed to target potential buyers directly through our advanced marketing and technology system. For this reason, you can rest assured that you will find fashion-loving customers on our platform at no extra cost. All you have to do is sign up while we handle all the processing, order fulfillment, shipping, and customer service."
        )
        let overview3 = createSection(
            sectionTitle: "Product Criteria",
            sectionDesc: "Baltini takes great pride in offering the most exclusive, exquisite, and in-vogue luxury fashion items that let both men and women fully express themselves. Our partners share the same vision and mission as Baltini's values."
        )
        
        stackView.addArrangedSubview(backButton)
        stackView.setCustomSpacing(18, after: backButton)
        stackView.addArrangedSubview(overview)
        stackView.setCustomSpacing(24, after: overview)
        stackView.addArrangedSubview(overview2)
        stackView.setCustomSpacing(24, after: overview2)
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
