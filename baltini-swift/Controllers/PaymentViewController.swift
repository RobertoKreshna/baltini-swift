//
//  PaymentViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 27/11/23.
//

import UIKit
import DropDown

class PaymentViewController: UIViewController {
    var userEmail: String?
    var address: AddressArgs?
    var selectedShippingIndex: Int?
    var selectedPaymentIndex = 0
    var sameBillingAddressIndex = 0
    
    var paymentOptionButtons : [UIButton] = [UIButton]()
    var billingAddressOptionButtons: [UIButton] = [UIButton]()
    var addressTextfieldStack: UIStackView?
    
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
extension PaymentViewController {
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
        
        let backButton = BackButton.createBackButton(title: "Payment", icName: "icBack", usePadding: true, tapped: UIAction(handler: { action in
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
        
        CustomCheckoutComponent.createAllProductCard(addTo: stackView)
        
        if CommonStore.shared.cartGetProtect() == true{
            let card = CustomCheckoutComponent.createProtectCard()
            stackView.addArrangedSubview(card)
            card.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
            card.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        }
        
        stackView.setCustomSpacing(50, after: stackView.subviews.last!)
        
        let couponStack = CustomCheckoutComponent.createCouponStack(owner: self)
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
        
        let contactPaymentSeparator = CustomSeparator.createHorizontalLine(width: 2, color: UIColor.brandGray)
        stackView.addArrangedSubview(contactPaymentSeparator)
        stackView.setCustomSpacing(24, after: contactPaymentSeparator)
        contactPaymentSeparator.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        contactPaymentSeparator.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        
        let paymentStack = creeatePaymentStack()
        stackView.addArrangedSubview(paymentStack)
        stackView.setCustomSpacing(24, after: paymentStack)
        paymentStack.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        paymentStack.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        
        let paymentAddressSeparator = CustomSeparator.createHorizontalLine(width: 2, color: UIColor.brandGray)
        stackView.addArrangedSubview(paymentAddressSeparator)
        stackView.setCustomSpacing(24, after: paymentAddressSeparator)
        paymentAddressSeparator.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        paymentAddressSeparator.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        
        addressTextfieldStack = createAddressStack()
        let billingAddressSrack = createBillingAddressStack(addressInputStack: addressTextfieldStack!)
        stackView.addArrangedSubview(billingAddressSrack)
        stackView.setCustomSpacing(24, after: billingAddressSrack)
        billingAddressSrack.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        billingAddressSrack.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        
        let addressButtonSeparator = CustomSeparator.createHorizontalLine(width: 2, color: UIColor.brandGray)
        stackView.addArrangedSubview(addressButtonSeparator)
        stackView.setCustomSpacing(12, after: addressButtonSeparator)
        addressButtonSeparator.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        addressButtonSeparator.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        
        let buttonStack = CustomCheckoutComponent.createTotalCheckoutStack(
            leftTop: "Total Price",
            leftBot: String(format: "$%.2f", Double(CommonStore.shared.calculateSubtotal())! + Constants.shippingTotalCost[selectedShippingIndex!]),
            buttonTitle: "PAY NOW",
            buttonTapped: UIAction(handler: { action in
                print("tapped")
            })
        )
        stackView.addArrangedSubview(buttonStack)
        stackView.setCustomSpacing(20, after: buttonStack)
        buttonStack.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        buttonStack.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
    }
    
    func createDescStack() -> UIStackView {
        let column = UIStackView()
        column.translatesAutoresizingMaskIntoConstraints = false
        column.axis = .vertical
        column.spacing = 8
        
        let subtotalRow = createDescRow(leftTitle: "Subtotal", rightTitle: CommonStore.shared.calculateSubtotal())
        let shippingRow = createDescRow(leftTitle: "Shipping", rightTitle: String(format: "$%.2f", Constants.shippingCost[selectedShippingIndex!]))
        let importDutyRow = createDescRow(leftTitle: "Import Duty/Taxes", rightTitle: String(format: "$%.2f", Constants.importTaxesCost[selectedShippingIndex!]))
        let estTaxRow = createDescRow(leftTitle: "Estimated Taxes", rightTitle: String(format: "$%.2f", Constants.estTaxesCost[selectedShippingIndex!]))
        let totalRow = createTotalRow(rightTitle: String(format: "$%.2f", Double(CommonStore.shared.calculateSubtotal())! + Constants.shippingTotalCost[selectedShippingIndex!]))
        column.addArrangedSubview(subtotalRow)
        column.addArrangedSubview(shippingRow)
        column.addArrangedSubview(importDutyRow)
        column.addArrangedSubview(estTaxRow)
        column.addArrangedSubview(totalRow)
        
        return column
    }
    
    func createDescRow(leftTitle: String, rightTitle: String) -> UIStackView{
        let row = UIStackView()
        row.translatesAutoresizingMaskIntoConstraints = false
        row.axis = .horizontal
        row.alignment = .center
        
        let leftLabel = createLabel(title: leftTitle, fontsize: 14, color: .black, textAlign: .left)
        let rightLabel = createLabel(title: rightTitle, fontsize: 14, color: .black, textAlign: .right)
        
        row.addArrangedSubview(leftLabel)
        row.addArrangedSubview(rightLabel)
        
        return row
    }
    
    func createTotalRow(rightTitle: String) -> UIStackView {
        let row = UIStackView()
        row.translatesAutoresizingMaskIntoConstraints = false
        row.axis = .horizontal
        row.alignment = .center
        
        let leftLabel = createLabel(title: "Total", fontsize: 14, color: .black, textAlign: .left)
        let currencyLabel = createLabel(title: "USD", fontsize: 12, color: .black.withAlphaComponent(0.5), textAlign: .left)
        currencyLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        currencyLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        let rightLabel = createLabel(title: rightTitle, fontsize: 18, color: .black, textAlign: .right)
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
        let emailSection = createSection(title: "Contact", subtitle: userEmail!, useButton: true)
        let addressString = address!.address2!.isEmpty
        ? "\(address!.address1), \(address!.city), \(address!.province), \(address!.country)"
        : "\(address!.address1), \(address!.address2!), \(address!.city), \(address!.province), \(address!.country)"
        let addressSection = createSection(title: "Ship To", subtitle: addressString, useButton: true)
        let shippingString = "\(Constants.shippingOptionsTitle[selectedShippingIndex!]) - \(String(format: "$%.2f", Constants.shippingCost[selectedShippingIndex!]))"
        let shippingSection = createSection(title: "Method", subtitle: shippingString, useButton: false)
        
        contactStack.addArrangedSubview(titleLabel)
        contactStack.setCustomSpacing(16, after: titleLabel)
        contactStack.addArrangedSubview(emailSection)
        contactStack.setCustomSpacing(24, after: emailSection)
        contactStack.addArrangedSubview(addressSection)
        contactStack.setCustomSpacing(24, after: addressSection)
        contactStack.addArrangedSubview(shippingSection)
        
        return contactStack
    }
    
    func createSection(title: String, subtitle: String, useButton: Bool) -> UIStackView {
        let section = UIStackView()
        section.translatesAutoresizingMaskIntoConstraints = false
        section.axis = .vertical
        
        let titleAndButtonStack = UIStackView()
        titleAndButtonStack.translatesAutoresizingMaskIntoConstraints = false
        titleAndButtonStack.axis = .horizontal
        
        let titleLabel = UILabel()
        titleLabel.text = title.uppercased()
        titleLabel.font = UIFont(name: "Futura-Medium", size: 10)
        titleLabel.textColor = .black.withAlphaComponent(0.5)
        
        titleAndButtonStack.addArrangedSubview(titleLabel)
        if useButton {
           let button = CustomButton.createUnderlinedButton(title: "CHANGE", action: UIAction(handler: { action in
               self.popBackToCheckout()
           }))
           titleAndButtonStack.addArrangedSubview(button)
        }
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = UIFont(name: "Futura-Medium", size: 16)
        subtitleLabel.textColor = .black
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .left
        
        section.addArrangedSubview(titleAndButtonStack)
        section.setCustomSpacing(4, after: titleAndButtonStack)
        section.addArrangedSubview(subtitleLabel)
        
        return section
    }
    
    func creeatePaymentStack() -> UIStackView {
        let paymentStack = UIStackView()
        paymentStack.translatesAutoresizingMaskIntoConstraints = false
        paymentStack.axis = .vertical
        
        let titleLabel = createLabel(title: "PAYMENT", fontsize: 14, color: .black, textAlign: .left)
        let descLabel = createLabel(title: "All transactions are secure and encrypted.", fontsize: 14, color: .black, textAlign: .left)
        let paymentOptionStack = createPaymentOptionsStack()
        
        paymentStack.addArrangedSubview(titleLabel)
        paymentStack.setCustomSpacing(16, after: titleLabel)
        paymentStack.addArrangedSubview(descLabel)
        paymentStack.setCustomSpacing(8, after: descLabel)
        paymentStack.addArrangedSubview(paymentOptionStack)
        
        return paymentStack
    }
    
    func createPaymentOptionsStack() -> UIStackView {
        let column = UIStackView()
        column.translatesAutoresizingMaskIntoConstraints = false
        column.axis = .vertical
        
        for i in 0 ... Constants.paymentOptions.count - 1 {
            let row = createPaymentOptionsRow(index: i)
            column.addArrangedSubview(row)
        }
        
        return column
    }
    
    func createPaymentOptionsRow(index: Int) -> UIStackView {
        let row = UIStackView()
        row.axis = .horizontal
        row.alignment = .leading
        row.translatesAutoresizingMaskIntoConstraints = false
        row.isLayoutMarginsRelativeArrangement = true
        row.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: selectedPaymentIndex == index ? "icRadioSelected" : "icRadio")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addAction(UIAction(handler: { action in
            self.selectedPaymentIndex = index
            DispatchQueue.main.async {
                //update button
                for i in 0...self.paymentOptionButtons.count - 1 {
                    let button = self.paymentOptionButtons[i]
                    let currentImage = button.currentImage
                    //make all unselected
                    if currentImage == UIImage(named: "icRadioSelected")?.withRenderingMode(.alwaysOriginal) {
                        button.setImage(UIImage(named: "icRadio")?.withRenderingMode(.alwaysOriginal), for: .normal)
                    }
                    //select one
                    if i == self.selectedPaymentIndex {
                        button.setImage(UIImage(named: "icRadioSelected")?.withRenderingMode(.alwaysOriginal), for: .normal)
                    }
                }
            }
        }), for: .touchUpInside)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        paymentOptionButtons.append(button)
        
        let titleLogoStack = createPaymentOptionsTitleLogoStack(index: index)
        
        row.addArrangedSubview(button)
        row.setCustomSpacing(8, after: button)
        row.addArrangedSubview(titleLogoStack)
        
        return row
    }
    
    func createPaymentOptionsTitleLogoStack(index: Int) -> UIStackView {
        let titleLogoStack = UIStackView()
        titleLogoStack.axis = .vertical
        titleLogoStack.alignment = .leading
        titleLogoStack.translatesAutoresizingMaskIntoConstraints = false
        
        let title = Constants.paymentOptions[index]
        let titleLabel = createLabel(title: title, fontsize: 14, color: .black, textAlign: .left)
        let logos = Constants.paymentOptionsLogo[index]
        let logoStack = UIStackView()
        logoStack.axis = .horizontal
        logoStack.spacing = 8
        logoStack.translatesAutoresizingMaskIntoConstraints = false
        
        logos.forEach { logoName in
            let imageView = UIImageView(image: UIImage(named: logoName))
            logoStack.addArrangedSubview(imageView)
        }
        
        titleLogoStack.addArrangedSubview(titleLabel)
        titleLogoStack.setCustomSpacing(4, after: titleLabel)
        titleLogoStack.addArrangedSubview(logoStack)
        
        return titleLogoStack
    }
    
    func createBillingAddressStack(addressInputStack: UIStackView) -> UIStackView {
        let addressStack = UIStackView()
        addressStack.translatesAutoresizingMaskIntoConstraints = false
        addressStack.axis = .vertical
        
        let titleLabel = createLabel(title: "BILLING ADDRESS", fontsize: 14, color: .black, textAlign: .left)
        let descLabel = createLabel(title: "Select the address that matches your card or payment method.", fontsize: 14, color: .black, textAlign: .left)
        let sameRow = createBillingAddressOption(index: 0, title: "Same as shipping address")
        let diffRow = createBillingAddressOption(index: 1, title: "Use a different billing address")
        
        addressStack.addArrangedSubview(titleLabel)
        addressStack.setCustomSpacing(16, after: titleLabel)
        addressStack.addArrangedSubview(descLabel)
        addressStack.setCustomSpacing(8, after: descLabel)
        addressStack.addArrangedSubview(sameRow)
        addressStack.addArrangedSubview(diffRow)
        addressStack.setCustomSpacing(24, after: diffRow)
        addressStack.addArrangedSubview(addressInputStack)
        
        return addressStack
    }
    
    func createBillingAddressOption(index: Int, title: String) -> UIStackView {
        let row = UIStackView()
        row.translatesAutoresizingMaskIntoConstraints = false
        row.axis = .horizontal
        row.isLayoutMarginsRelativeArrangement = true
        row.layoutMargins = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)

        let button = UIButton(type: .system)
        button.setImage(UIImage(named: sameBillingAddressIndex == index ? "icRadioSelected" : "icRadio")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addAction(UIAction(handler: { action in
            self.sameBillingAddressIndex = index
            DispatchQueue.main.async {
                //update button
                for i in 0...self.billingAddressOptionButtons.count - 1 {
                    let button = self.billingAddressOptionButtons[i]
                    let currentImage = button.currentImage
                    //make all unselected
                    if currentImage == UIImage(named: "icRadioSelected")?.withRenderingMode(.alwaysOriginal) {
                        button.setImage(UIImage(named: "icRadio")?.withRenderingMode(.alwaysOriginal), for: .normal)
                    }
                    //select one
                    if i == self.sameBillingAddressIndex {
                        button.setImage(UIImage(named: "icRadioSelected")?.withRenderingMode(.alwaysOriginal), for: .normal)
                    }
                }
                //make address visible
                self.addressTextfieldStack!.isHidden = self.sameBillingAddressIndex == 0 ? true : false
            }
        }), for: .touchUpInside)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        billingAddressOptionButtons.append(button)
        
        let title = createLabel(title: title, fontsize: 14, color: .black, textAlign: .left)
        
        row.addArrangedSubview(button)
        row.setCustomSpacing(8, after: button)
        row.addArrangedSubview(title)
        
        return row
    }
    
    func createAddressStack() -> UIStackView {
        let addressStack = UIStackView()
        addressStack.translatesAutoresizingMaskIntoConstraints = false
        addressStack.axis = .vertical
        addressStack.isHidden = true
        
        let values = ["First Name", "Last Name", "Company (Optional)", "Address 1", "Address 2", "City", "Country", "Province / State", "ZIP Code", "Phone Number"]
        for i in 0 ... values.count - 1 {
            let textfield = CustomTextfield.createTextfield(placeholder: values[i], isPassword: false, owner: self)
            addressStack.addArrangedSubview(textfield)
            addressStack.setCustomSpacing(i == values.count - 1 ? 4 : 32, after: textfield)
            textfield.leftAnchor.constraint(equalTo: addressStack.leftAnchor).isActive = true
            textfield.rightAnchor.constraint(equalTo: addressStack.rightAnchor).isActive = true
        }
        
        let attributedTitle = NSAttributedString(
            string: "Incase we need to contact you about your order.",
            attributes: [.font : UIFont(name: "Futura-Medium", size: 12)!]
        )
        let label = UILabel()
        label.attributedText = attributedTitle
        addressStack.addArrangedSubview(label)
        
        return addressStack
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
extension PaymentViewController : UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}

//MARK: Button Pressed Logic
extension PaymentViewController {
    func popBackToCheckout(){
        let checkoutVC = self.navigationController?.viewControllers.first(where: { $0 is CheckoutViewController }) as! CheckoutViewController
        checkoutVC.userEmail = self.userEmail
        checkoutVC.address = self.address
        self.navigationController?.popViewController(animated: true)
    }
}
