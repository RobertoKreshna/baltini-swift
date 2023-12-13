//
//  AuthenticityViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 10/11/23.
//

import UIKit

class AuthenticityViewController : UIViewController {
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

extension AuthenticityViewController {
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
        
        let backButton = BackButton.createBackButton(title: "Authenticity Guarantee" , icName: "icBack", usePadding: true, tapped: UIAction(handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        let image = UIImageView(image: UIImage(named: "authentic"))
        let overview = createSection(sectionDesc: "Customer trust is a priority for us at Baltini, which is why we pride ourselves in working with authentic brands you can trust. We guarantee that the items you pay for at Baltini are genuine, authentic, and in the best condition.")
        let overview2 = createSection(
            sectionTitle: "It’s Easier Than Ever to Shop with Confidence",
            sectionDesc: "We understand that buying luxury online can be overwhelming as it may be difficult to tell whether the items are authentic."
        )
        let overview3 = createSection(sectionDesc: "But here is one thing Baltini makes sure of: Quality.")
        let overview4 = createSection(sectionDesc: "Our Authenticity Process allows customers to shop with confidence and with the assurance that they will get 100% quality goods. We offer 3 layers of processes to ensure authenticity for our customers:")
        let overview5 = createSectionWithDot(
            sectionTitle: "Strict Screening of Partners",
            sectionDesc: "We work directly with high-end luxury boutiques across Italy that are 100% authentic and authorized to sell. Baltini has a strict screening process to ensure every partner boutique is reviewed and up to our high standards of quality and service. We require each boutique partner to sign a contract affirming that merchandise sent to customers will be authentic and in great condition. We also review our contracts with designer boutiques to verify that they are still in good standing with manufacturers according to our contract requirements.We do not condone the selling of counterfeit products, and our boutique partners are subjected to immediate removal from our platform and are heavily fined if they ship products that do not meet our requirements."
        )
        
        stackView.addArrangedSubview(backButton)
        stackView.setCustomSpacing(18, after: backButton)
        stackView.addArrangedSubview(image)
        stackView.setCustomSpacing(24, after: image)
        stackView.addArrangedSubview(overview)
        stackView.setCustomSpacing(24, after: overview)
        stackView.addArrangedSubview(overview2)
        stackView.setCustomSpacing(8, after: overview2)
        stackView.addArrangedSubview(overview3)
        stackView.setCustomSpacing(8, after: overview3)
        stackView.addArrangedSubview(overview4)
        stackView.setCustomSpacing(24, after: overview4)
        stackView.addArrangedSubview(overview5)
        
        backButton.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        image.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        image.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
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
    }
    
    func createSectionWithDot(sectionTitle: String? = nil, sectionDesc: String) -> UIStackView {
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
