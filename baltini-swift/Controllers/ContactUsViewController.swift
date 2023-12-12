//
//  ContactUsViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 12/12/23.
//

import Foundation
import UIKit

class ContactUsViewController: UIViewController {

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
extension ContactUsViewController {
    func createUI(){
        view.backgroundColor = .white
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let pageStackView = UIStackView()
        pageStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(pageStackView)
        
        pageStackView.axis = .vertical
        pageStackView.alignment = .center
        
        pageStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        pageStackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16).isActive = true
        pageStackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16).isActive = true
        pageStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        pageStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32).isActive = true
        
        let backButton = BackButton.createBackButton(title: "Contact Us" , icName: "icBack", usePadding: false, tapped: UIAction(handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        let hqSection = createBorderedSection(title: "Headquarters", desc: "2510 East Sunset Rd, #5-960, Las Vegas, NV, 89120")
        let getTouchSection = createBorderedSection(title: "Get in touch with us", desc: "info@baltini.com (General Inquiries)\nreturns@baltini.com (Returns and Refunds)\n+1 (833) 938-1182")
        let textSection1 = createLabel(text: "Please check our FAQ if you have general questions about our products and services. We might have an answer for you already.", fontSize: 14, color: .black, align: .left, isBold: false)
        let textSection2 = createLabel(text: "Still in need of immediate help regarding your orders and shipping? Kindly reach out to us via any of our contact details above.", fontSize: 14, color: .black, align: .left, isBold: false)
        let textSection3 = createLabel(text: "Alternatively, you can fill out the contact form, and one of our customer support will contact you shortly. Please, note that we are available Monday to Friday, from 10 AM to 5 PM EST, excluding holidays.", fontSize: 14, color: .black, align: .left, isBold: false)
        let nameField = CustomTextfield.createTextfield(placeholder: "Name", isPassword: false, owner: self, useDesc: false)
        let phoneField = CustomTextfield.createTextfield(placeholder: "Phone", isPassword: false, owner: self, useDesc: false)
        let emailField = CustomTextfield.createTextfield(placeholder: "Email", isPassword: false, owner: self, useDesc: false)
        let msgField = CustomTextfield.createTextfield(placeholder: "Message", isPassword: false, owner: self, useDesc: false)
        let sendMsgBtn = CustomButton.createBlackButton(title: "Send Message", action: UIAction(handler: { action in
            print("send tapped")
            self.navigationController?.popViewController(animated: true)
        }))
        
        pageStackView.addArrangedSubview(backButton)
        pageStackView.setCustomSpacing(18, after: backButton)
        pageStackView.addArrangedSubview(hqSection)
        pageStackView.setCustomSpacing(16, after: hqSection)
        pageStackView.addArrangedSubview(getTouchSection)
        pageStackView.setCustomSpacing(24, after: getTouchSection)
        pageStackView.addArrangedSubview(textSection1)
        pageStackView.setCustomSpacing(8, after: textSection1)
        pageStackView.addArrangedSubview(textSection2)
        pageStackView.setCustomSpacing(8, after: textSection2)
        pageStackView.addArrangedSubview(textSection3)
        pageStackView.setCustomSpacing(46, after: textSection3)
        pageStackView.addArrangedSubview(nameField)
        pageStackView.setCustomSpacing(46, after: nameField)
        pageStackView.addArrangedSubview(phoneField)
        pageStackView.setCustomSpacing(46, after: phoneField)
        pageStackView.addArrangedSubview(emailField)
        pageStackView.setCustomSpacing(46, after: emailField)
        pageStackView.addArrangedSubview(msgField)
        pageStackView.setCustomSpacing(46, after: msgField)
        pageStackView.addArrangedSubview(sendMsgBtn)
        pageStackView.setCustomSpacing(20, after: sendMsgBtn)
        pageStackView.addArrangedSubview(UIView())
        
        backButton.topAnchor.constraint(equalTo: pageStackView.topAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: pageStackView.leftAnchor).isActive = true
        hqSection.leftAnchor.constraint(equalTo: pageStackView.leftAnchor).isActive = true
        hqSection.rightAnchor.constraint(equalTo: pageStackView.rightAnchor).isActive = true
        getTouchSection.leftAnchor.constraint(equalTo: pageStackView.leftAnchor).isActive = true
        getTouchSection.rightAnchor.constraint(equalTo: pageStackView.rightAnchor).isActive = true
        textSection1.leftAnchor.constraint(equalTo: pageStackView.leftAnchor).isActive = true
        textSection1.rightAnchor.constraint(equalTo: pageStackView.rightAnchor).isActive = true
        textSection2.leftAnchor.constraint(equalTo: pageStackView.leftAnchor).isActive = true
        textSection2.rightAnchor.constraint(equalTo: pageStackView.rightAnchor).isActive = true
        textSection3.leftAnchor.constraint(equalTo: pageStackView.leftAnchor).isActive = true
        textSection3.rightAnchor.constraint(equalTo: pageStackView.rightAnchor).isActive = true
        nameField.leftAnchor.constraint(equalTo: pageStackView.leftAnchor).isActive = true
        nameField.rightAnchor.constraint(equalTo: pageStackView.rightAnchor).isActive = true
        phoneField.leftAnchor.constraint(equalTo: pageStackView.leftAnchor).isActive = true
        phoneField.rightAnchor.constraint(equalTo: pageStackView.rightAnchor).isActive = true
        emailField.leftAnchor.constraint(equalTo: pageStackView.leftAnchor).isActive = true
        emailField.rightAnchor.constraint(equalTo: pageStackView.rightAnchor).isActive = true
        msgField.leftAnchor.constraint(equalTo: pageStackView.leftAnchor).isActive = true
        msgField.rightAnchor.constraint(equalTo: pageStackView.rightAnchor).isActive = true
        sendMsgBtn.leftAnchor.constraint(equalTo: pageStackView.leftAnchor).isActive = true
        sendMsgBtn.rightAnchor.constraint(equalTo: pageStackView.rightAnchor).isActive = true
    }
    
    func createBorderedSection(title: String, desc: String) -> UIStackView {
        let section = UIStackView()
        section.translatesAutoresizingMaskIntoConstraints = false
        section.axis = .vertical
        section.spacing = 12
        
        let titleLabel = createLabel(text: title.uppercased(), fontSize: 14, color: .black, align: .center, isBold: true)
        let descLabel = createLabel(text: desc, fontSize: 14, color: .black, align: .center, isBold: false)
        
        section.addArrangedSubview(titleLabel)
        section.addArrangedSubview(descLabel)
        
        section.isLayoutMarginsRelativeArrangement = true
        section.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        section.layer.borderWidth = 1
        section.layer.borderColor = UIColor.lightGray.cgColor
        section.layer.cornerRadius = 4
        
        return section
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
}

//MARK: UI Textfield Delegate
extension ContactUsViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
