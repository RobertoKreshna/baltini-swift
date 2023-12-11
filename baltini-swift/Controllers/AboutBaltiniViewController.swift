//
//  AboutBaltiniViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 11/12/23.
//

import Foundation
import UIKit

class AboutBaltiniViewController: UIViewController {
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


//MARK: Create UI Methods
extension AboutBaltiniViewController {
    
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
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        //add all component to stack
        let backButton = BackButton.createBackButton(title: "We Are Baltini" , icName: "icBack", usePadding: true, tapped: UIAction(handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        let about = createSection(
            sectionTitle: "A luxury fashion brand that puts creativity and accessibility at the heart of its strategy.",
            sectionDesc: "We believe people should be able to make a statement without breaking the bank, and we capture this by making luxury fashion easy and affordable. Baltini offers a seamless shopping experience by partnering with high-end luxury boutiques across Italy. On our platform, you can browse apparel and fashion accessories from hundreds of luxury brands all in one place."
        )
        let story = createSection(
            sectionTitle: "Our Story",
            sectionDesc: "We understand that getting a luxury item is not just about receiving it but also the process that goes into purchasing it. The idea was to create a platform where shopping for luxury fashion is easy for customers worldwide.\nIn 2019, Baltini was launched in New York, USA, as a platform to provide a seamless shopping experience for fashion enthusiasts. After many years of research and experience, Baltini is now a go-to platform to discover luxury Italian fashion, in-season quality clothing, and fashion accessories at the best price. We have partnered with hundreds of the world's best high-end boutiques across Italy to bring luxury fashion items accessible to our customers."
        )
        
        stackView.addArrangedSubview(backButton)
        stackView.setCustomSpacing(18, after: backButton)
        stackView.addArrangedSubview(about)
        stackView.setCustomSpacing(24, after: about)
        stackView.addArrangedSubview(story)
        
        backButton.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        about.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        about.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        story.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        story.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
    }
    
    func createSection(sectionTitle: String, sectionDesc: String) -> UIStackView {
        let section = UIStackView()
        section.axis = .vertical
        section.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = createLabel(text: sectionTitle, fontSize: 16, color: .black, align: .justified)
        let descLabel = createLabel(text: sectionDesc, fontSize: 14, color: .black, align: .justified)
        
        section.addArrangedSubview(titleLabel)
        section.setCustomSpacing(8, after: titleLabel)
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
