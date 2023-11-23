//
//  CheckoutViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 21/11/23.
//

import UIKit

class CheckoutViewController: UIViewController {
    var itemList : [ProductDetail]?
    var qtyList : [Int]?
    var varIndexList : [Int]?
    var useProtect: Bool?
    var mailMe: Bool = false
    
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
extension CheckoutViewController {
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
        stackView.isUserInteractionEnabled = true
        stackView.spacing = 16
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let backButton = BackButton.createBackButton(title: "Checkout", icName: "icBack", usePadding: true, tapped: UIAction(handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        
        stackView.addArrangedSubview(backButton)
        backButton.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        
        let orderTitleLabel = UILabel()
        orderTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        orderTitleLabel.text = "ORDER SUMMARY"
        orderTitleLabel.textColor = .black
        orderTitleLabel.font = UIFont(name: "Futura-Medium", size: 14)
        
        stackView.addArrangedSubview(orderTitleLabel)
        orderTitleLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        orderTitleLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        
        createAllProductCard(addTo: stackView)
        
        if useProtect == true{
            let card = createProtectCard()
            stackView.addArrangedSubview(card)
            card.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
            card.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        }
        
        stackView.setCustomSpacing(50, after: stackView.subviews.last!)
        
        let couponStack = createCouponStack()
        stackView.addArrangedSubview(couponStack)
        couponStack.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        couponStack.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        
        stackView.setCustomSpacing(45, after: couponStack)
        
        let descStack = createDescStack()
        stackView.addArrangedSubview(descStack)
        descStack.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        descStack.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        
        stackView.setCustomSpacing(24, after: couponStack)
        
        let contentContactSeparator = CustomSeparator.createHorizontalLine(width: 2, color: UIColor.brandGray)
        stackView.addArrangedSubview(contentContactSeparator)
        stackView.setCustomSpacing(24, after: contentContactSeparator)
        contentContactSeparator.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        contentContactSeparator.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        
        let contactStack = createContactStack()
        stackView.addArrangedSubview(contactStack)
        stackView.setCustomSpacing(24, after: contactStack)
        contactStack.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        contactStack.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        
        let contactAddressSeparator = CustomSeparator.createHorizontalLine(width: 2, color: UIColor.brandGray)
        stackView.addArrangedSubview(contactAddressSeparator)
        stackView.setCustomSpacing(24, after: contactAddressSeparator)
        contactAddressSeparator.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        contactAddressSeparator.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        
        let addressStack = createAddressStack()
        stackView.addArrangedSubview(addressStack)
        stackView.setCustomSpacing(66, after: addressStack)
        addressStack.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        addressStack.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        
        let addressButtonSeparator = CustomSeparator.createHorizontalLine(width: 2, color: UIColor.brandGray)
        stackView.addArrangedSubview(addressButtonSeparator)
        addressButtonSeparator.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        addressButtonSeparator.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        
    }
    
    func createAllProductCard(addTo stackView: UIStackView){
        for i in 0 ... itemList!.count - 1 {
            let card = CustomCard.createCheckoutItemCard(item: itemList![i], qty: qtyList![i], variantIndex: varIndexList![i])
            
            stackView.addArrangedSubview(card)
            
            card.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
            card.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        }
    }
    
    func createProtectCard() -> UIStackView {
        let card = UIStackView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.axis = .horizontal
        card.alignment = .center
        
        let imageView = UIImageView(image: UIImage(named: "imageProtect"))
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Shipping Protection"
        titleLabel.font = UIFont(name: "Futura-Bold", size: 14)
        titleLabel.textColor = .black
        let priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.text = "$22.00"
        priceLabel.font = UIFont(name: "Futura-Medium", size: 16)
        priceLabel.textColor = .black
        priceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        card.addArrangedSubview(imageView)
        card.setCustomSpacing(8, after: imageView)
        card.addArrangedSubview(titleLabel)
        card.addArrangedSubview(priceLabel)
        
        imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        return card
    }
    
    func createCouponStack() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .trailing
        
        let textfield = CustomTextfield.createTextfield(
            placeholder: "Gift card or discount code",
            isPassword: false,
            owner: self,
            useDesc: false,
            lineLength: UIScreen.main.bounds.width * 287 / 375
        )
        
        let btn = CustomButton.createBlackImageButton(imageName: "icRight", tapped: UIAction(handler: { action in
            print("tapped")
        }))
        
        stack.addArrangedSubview(textfield)
        stack.setCustomSpacing(16, after: textfield)
        stack.addArrangedSubview(btn)
        
        return stack
    }
    
    func createDescStack() -> UIStackView {
        let column = UIStackView()
        column.translatesAutoresizingMaskIntoConstraints = false
        column.axis = .vertical
        column.spacing = 8
        
        let subtotalRow = createSubtotalRow()
        let shippingRow = createShippingRow()
        let importDutyRow = createImportDutyRow()
        let totalRow = createTotalRow()
        column.addArrangedSubview(subtotalRow)
        column.addArrangedSubview(shippingRow)
        column.addArrangedSubview(importDutyRow)
        column.addArrangedSubview(totalRow)
        
        return column
    }
    
    func createSubtotalRow() -> UIStackView{
        let row = UIStackView()
        row.translatesAutoresizingMaskIntoConstraints = false
        row.axis = .horizontal
        row.alignment = .center
        
        let leftLabel = createLabel(title: "Subtotal", fontsize: 14, color: .black, textAlign: .left)
        let rightLabel = createLabel(title: "$\(CommonStore.shared.calculateSubtotal())", fontsize: 14, color: .black, textAlign: .right)
        
        row.addArrangedSubview(leftLabel)
        row.addArrangedSubview(rightLabel)
        
        return row
    }
    
    func createShippingRow() -> UIStackView {
        let row = UIStackView()
        row.translatesAutoresizingMaskIntoConstraints = false
        row.axis = .horizontal
        row.alignment = .center
        
        let leftLabel = createLabel(title: "Shipping", fontsize: 14, color: .black, textAlign: .left)
        let rightLabel = createLabel(title: "$0.00", fontsize: 14, color: .black, textAlign: .right)
        
        row.addArrangedSubview(leftLabel)
        row.addArrangedSubview(rightLabel)
        
        return row
    }
    
    func createImportDutyRow() -> UIStackView {
        let row = UIStackView()
        row.translatesAutoresizingMaskIntoConstraints = false
        row.axis = .horizontal
        row.alignment = .center
        
        let leftLabel = createLabel(title: "Import Duty/Taxes", fontsize: 14, color: .black, textAlign: .left)
        leftLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        let button = CustomButton.createImageButton(imageName: "icInfo", tapped: UIAction(handler: { action in
            print("info tapped")
        }))
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        let rightLabel = createLabel(title: "Calculated at next step", fontsize: 12, color: .black.withAlphaComponent(0.5), textAlign: .right)
        
        row.addArrangedSubview(leftLabel)
        row.setCustomSpacing(4, after: leftLabel)
        row.addArrangedSubview(button)
        row.addArrangedSubview(rightLabel)
        
        return row
    }
    
    func createTotalRow() -> UIStackView {
        let row = UIStackView()
        row.translatesAutoresizingMaskIntoConstraints = false
        row.axis = .horizontal
        row.alignment = .center
        
        let leftLabel = createLabel(title: "Total", fontsize: 14, color: .black, textAlign: .left)
        let currencyLabel = createLabel(title: "USD", fontsize: 12, color: .black.withAlphaComponent(0.5), textAlign: .left)
        currencyLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        currencyLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        let rightLabel = createLabel(title: "$\(CommonStore.shared.calculateSubtotal())", fontsize: 18, color: .black, textAlign: .right)
        rightLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        row.addArrangedSubview(leftLabel)
        row.addArrangedSubview(currencyLabel)
        row.setCustomSpacing(8, after: currencyLabel)
        row.addArrangedSubview(rightLabel)
        
        return row
    }
    
    func createContactStack() -> UIStackView {
        let contactStack = UIStackView()
        contactStack.translatesAutoresizingMaskIntoConstraints = false
        contactStack.axis = .vertical
        
        let titleLabel = createLabel(title: "CONTACT INFORMATION", fontsize: 14, color: .black, textAlign: .left)
        
        contactStack.addArrangedSubview(titleLabel)
        contactStack.setCustomSpacing(16, after: titleLabel)
        
        if CommonStore.shared.getUser() != nil {
            let user = CommonStore.shared.getUser()
            let contactLabel = createLabel(
                title: "\(user!.firstName!) \(user!.lastName!) (\(user!.email!))",
                fontsize: 14, color: .black, textAlign: .left
            )
            contactStack.addArrangedSubview(contactLabel)
            contactStack.setCustomSpacing(16, after: contactLabel)
        } else {
            let descStack = createNotLoggedInDescStack()
            let textfield = CustomTextfield.createTextfield(placeholder: "Email", isPassword: false, owner: self, useDesc: false)
            contactStack.addArrangedSubview(descStack)
            contactStack.setCustomSpacing(38, after: descStack)
            contactStack.addArrangedSubview(textfield)
            contactStack.setCustomSpacing(30, after: textfield)
        }
        
        let mailStack = createMailStack()
        contactStack.addArrangedSubview(mailStack)
        contactStack.setCustomSpacing(24, after: mailStack)
        
        return contactStack
    }
    
    func createNotLoggedInDescStack() -> UIStackView {
        let descStack = UIStackView()
        descStack.translatesAutoresizingMaskIntoConstraints = false
        descStack.axis = .horizontal
        
        let descLabel = createLabel(title: "Already have an account ?", fontsize: 14, color: .black, textAlign: .left)
        descLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        let button = CustomButton.createUnderlinedButton(title: "LOG IN", action: UIAction(handler: { action in
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }))
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        let emptyLabel = createLabel(title: "", fontsize: 14, color: .clear, textAlign: .left)
        
        descStack.addArrangedSubview(descLabel)
        descStack.setCustomSpacing(8, after: descLabel)
        descStack.addArrangedSubview(button)
        descStack.addArrangedSubview(emptyLabel)
        return descStack
    }
    
    func createMailStack() -> UIStackView {
        let contentStack = UIStackView()
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .leading
        
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        
        let checkButton = UIButton(type: .system)
        checkButton.setImage(UIImage(named: mailMe ? "icCheckSelected" : "icCheck")!.withRenderingMode(.alwaysOriginal), for: .normal)
        checkButton.addAction(UIAction(handler: { action in
            self.mailMe = !self.mailMe
            checkButton.setImage(UIImage(named: self.mailMe ? "icCheckSelected" : "icCheck")!.withRenderingMode(.alwaysOriginal), for: .normal)
        }), for: .touchUpInside)
        
        let descLabel = UILabel()
        descLabel.text = "Email me with news and offers"
        descLabel.font = UIFont(name: "Futura-Medium", size: 14)!
        
        stack.addArrangedSubview(checkButton)
        stack.setCustomSpacing(8, after: checkButton)
        stack.addArrangedSubview(descLabel)
        
        contentStack.addArrangedSubview(stack)
        
        return contentStack
    }
    
    func createAddressStack() -> UIStackView {
        let addressStack = UIStackView()
        addressStack.translatesAutoresizingMaskIntoConstraints = false
        addressStack.axis = .vertical
        
        let titleLabel = createLabel(title: "SHIPPING ADDRESS", fontsize: 14, color: .black, textAlign: .left)
        addressStack.addArrangedSubview(titleLabel)
        addressStack.setCustomSpacing(16, after: titleLabel)
        
        let prompt = createAddressPrompt()
        addressStack.addArrangedSubview(prompt)
        addressStack.setCustomSpacing(16, after: prompt)
        
        let values = ["First Name", "Last Name", "Company (Optional)", "Address 1", "Address 2", "City", "Country", "Province / State", "ZIP Code", "Phone Number"]
        for i in 0 ... values.count - 1 {
            let textfield = CustomTextfield.createTextfield(placeholder: values[i], isPassword: false, owner: self)
            addressStack.addArrangedSubview(textfield)
            addressStack.setCustomSpacing(32, after: textfield)
            textfield.leftAnchor.constraint(equalTo: addressStack.leftAnchor).isActive = true
            textfield.rightAnchor.constraint(equalTo: addressStack.rightAnchor).isActive = true
        }
        
        return addressStack
    }
    
    func createAddressPrompt() -> UIView {
        let prompt = UIButton()
        prompt.isUserInteractionEnabled = false
        
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        prompt.configuration = configuration
        let title = NSAttributedString(
            string: "Please double check the shipping address to ensure prompt delivery",
            attributes: [.font : UIFont(name: "Futura-Medium", size: 14)!, .foregroundColor : UIColor.black]
        )
        prompt.setAttributedTitle(title, for: .normal)
        prompt.backgroundColor = .promptBg.withAlphaComponent(0.1)
        prompt.layer.cornerRadius = 4
        
        return prompt
    }
    
    func createLabel(title: String, fontsize: CGFloat, color: UIColor, textAlign: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont(name: "Futura-Medium", size: fontsize)
        label.textColor = color
        label.textAlignment = textAlign
        return label
    }
}

//MARK: Textfield Delegate Methods
extension CheckoutViewController : UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}

