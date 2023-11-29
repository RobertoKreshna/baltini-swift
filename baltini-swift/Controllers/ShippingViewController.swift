//
//  ShippingViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 24/11/23.
//

import UIKit

class ShippingViewController: UIViewController {
    var userEmail: String?
    var address: AddressArgs?
    
    var selectedShippingIndex = 0
    
    var subtotalLabel: UILabel = {
        let label = UILabel()
        label.text = String(format: "$%.2f", (CommonStore.shared.calculateSubtotal() as NSString).doubleValue)
        label.font = UIFont(name: "Futura-Medium", size: 14)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    var shippingLabel: UILabel = {
        let label = UILabel()
        label.text = String(format: "$%.2f", Constants.shippingCost[0])
        label.font = UIFont(name: "Futura-Medium", size: 14)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    var importDutyLabel: UILabel = {
        let label = UILabel()
        label.text = String(format: "$%.2f", Constants.importTaxesCost[0])
        label.font = UIFont(name: "Futura-Medium", size: 14)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    var estimatedTaxesLabel: UILabel = {
        let label = UILabel()
        label.text = String(format: "$%.2f", Constants.estTaxesCost[0])
        label.font = UIFont(name: "Futura-Medium", size: 14)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    var totalLabel: UILabel = {
        let label = UILabel()
        label.text = String(format: "$%.2f", Double(CommonStore.shared.calculateSubtotal())! + Constants.shippingTotalCost[0])
        label.font = UIFont(name: "Futura-Medium", size: 14)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    var totalBoldLabel: UILabel = {
        let label = UILabel()
        label.text = String(format: "$%.2f", Double(CommonStore.shared.calculateSubtotal())! + Constants.shippingTotalCost[0])
        label.font = UIFont(name: "Futura-Bold", size: 14)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    var shippingChoiceButtons: [UIButton] = [UIButton]()
    
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
extension ShippingViewController {
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
        
        let backButton = BackButton.createBackButton(title: "Shipping", icName: "icBack", usePadding: true, tapped: UIAction(handler: { action in
            self.popBackToCheckout()
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
        
        let contactShippingSeparator = CustomSeparator.createHorizontalLine(width: 2, color: UIColor.brandGray)
        stackView.addArrangedSubview(contactShippingSeparator)
        stackView.setCustomSpacing(24, after: contactShippingSeparator)
        contactShippingSeparator.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        contactShippingSeparator.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        
        let shippingChoiceStack = createShippingChoiceStack()
        stackView.addArrangedSubview(shippingChoiceStack)
        stackView.setCustomSpacing(24, after: shippingChoiceStack)
        shippingChoiceStack.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        shippingChoiceStack.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        
        let shippingButtonSeparator = CustomSeparator.createHorizontalLine(width: 2, color: UIColor.brandGray)
        stackView.addArrangedSubview(shippingButtonSeparator)
        stackView.setCustomSpacing(24, after: shippingButtonSeparator)
        shippingButtonSeparator.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
        shippingButtonSeparator.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        
        let buttonStack = CustomCheckoutComponent.createTotalCheckoutStack(
            leftTop: "Total Price",
            leftBotLabel: totalBoldLabel,
            buttonTitle: "SHIPPING",
            buttonTapped: UIAction(handler: { action in
                let vc = PaymentViewController()
                vc.userEmail = self.userEmail
                vc.address = self.address
                vc.selectedShippingIndex = self.selectedShippingIndex
                self.navigationController?.pushViewController(vc, animated: true)
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
        
        let subtotalRow = createDescRow(leftTitle: "Subtotal", rightLabel: subtotalLabel)
        let shippingRow = createDescRow(leftTitle: "Shipping", rightLabel: shippingLabel)
        let importDutyRow = createDescRow(leftTitle: "Import Duty/Taxes", rightLabel: importDutyLabel)
        let estTaxRow = createDescRow(leftTitle: "Estimated Taxes", rightLabel: estimatedTaxesLabel)
        let totalRow = createTotalRow(rightLabel: totalLabel)
        column.addArrangedSubview(subtotalRow)
        column.addArrangedSubview(shippingRow)
        column.addArrangedSubview(importDutyRow)
        column.addArrangedSubview(estTaxRow)
        column.addArrangedSubview(totalRow)
        
        return column
    }
    
    func createDescRow(leftTitle: String, rightLabel: UILabel) -> UIStackView{
        let row = UIStackView()
        row.translatesAutoresizingMaskIntoConstraints = false
        row.axis = .horizontal
        row.alignment = .center
        
        let leftLabel = createLabel(title: leftTitle, fontsize: 14, color: .black, textAlign: .left)
        
        row.addArrangedSubview(leftLabel)
        row.addArrangedSubview(rightLabel)
        
        return row
    }
    
    func createTotalRow(rightLabel: UILabel) -> UIStackView {
        let row = UIStackView()
        row.translatesAutoresizingMaskIntoConstraints = false
        row.axis = .horizontal
        row.alignment = .center
        
        let leftLabel = createLabel(title: "Total", fontsize: 14, color: .black, textAlign: .left)
        let currencyLabel = createLabel(title: "USD", fontsize: 12, color: .black.withAlphaComponent(0.5), textAlign: .left)
        currencyLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        currencyLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
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
        let emailSection = createContantSection(title: "Contact", subtitle: userEmail!)
        let addressString = address!.address2!.isEmpty
        ? "\(address!.address1), \(address!.city), \(address!.province), \(address!.country)"
        : "\(address!.address1), \(address!.address2!), \(address!.city), \(address!.province), \(address!.country)"
        let addressSection = createContantSection(title: "Ship To", subtitle: addressString)
        
        contactStack.addArrangedSubview(titleLabel)
        contactStack.setCustomSpacing(16, after: titleLabel)
        contactStack.addArrangedSubview(emailSection)
        contactStack.setCustomSpacing(24, after: emailSection)
        contactStack.addArrangedSubview(addressSection)
        
        return contactStack
    }
    
    func createContantSection(title: String, subtitle: String) -> UIStackView {
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
        
        let button = CustomButton.createUnderlinedButton(title: "CHANGE", action: UIAction(handler: { action in
            self.popBackToCheckout()
        }))
        
        titleAndButtonStack.addArrangedSubview(titleLabel)
        titleAndButtonStack.addArrangedSubview(button)
        
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
    
    func createShippingChoiceStack() -> UIStackView{
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        
        for i in 0 ... Constants.shippingOptionsTitle.count - 1 {
            let option = createShippingOptionsRow(index: i)
            stack.addArrangedSubview(option)
        }
        return stack
    }
    
    func createShippingOptionsRow(index: Int) -> UIStackView {
        let row = UIStackView()
        row.axis = .horizontal
        row.alignment = .leading
        row.translatesAutoresizingMaskIntoConstraints = false
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: selectedShippingIndex == index ? "icRadioSelected" : "icRadio")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addAction(UIAction(handler: { action in
            self.selectedShippingIndex = index
            DispatchQueue.main.async {
                //update button
                for i in 0...self.shippingChoiceButtons.count - 1 {
                    let button = self.shippingChoiceButtons[i]
                    let currentImage = button.currentImage
                    //make all unselected
                    if currentImage == UIImage(named: "icRadioSelected")?.withRenderingMode(.alwaysOriginal) {
                        button.setImage(UIImage(named: "icRadio")?.withRenderingMode(.alwaysOriginal), for: .normal)
                    }
                    //select one
                    if i == self.selectedShippingIndex {
                        button.setImage(UIImage(named: "icRadioSelected")?.withRenderingMode(.alwaysOriginal), for: .normal)
                    }
                }
                //update all label
                self.shippingLabel.text = String(format: "$%.2f", Constants.shippingCost[self.selectedShippingIndex])
                self.importDutyLabel.text = String(format: "$%.2f", Constants.importTaxesCost[self.selectedShippingIndex])
                self.estimatedTaxesLabel.text = String(format: "$%.2f", Constants.estTaxesCost[self.selectedShippingIndex])
                self.totalLabel.text = self.calculateTotal(index: self.selectedShippingIndex)
                self.totalBoldLabel.text = self.calculateTotal(index: self.selectedShippingIndex)
            }
        }), for: .touchUpInside)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        shippingChoiceButtons.append(button)
        
        let titleDescStack = createShippingOptionDescStack(index: index)
        titleDescStack.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        let priceLabel = createLabel(
            title: String(format: "$%.2f", Constants.shippingTotalCost[index]),
            fontsize: 14,
            color: .black,
            textAlign: .right
        )
        
        row.addArrangedSubview(button)
        row.setCustomSpacing(8, after: button)
        row.addArrangedSubview(titleDescStack)
        row.addArrangedSubview(priceLabel)
        
        return row
    }
    
    func createShippingOptionDescStack(index: Int) -> UIStackView {
        let descStack = UIStackView()
        descStack.axis = .vertical
        descStack.alignment = .leading
        descStack.translatesAutoresizingMaskIntoConstraints = false
        
        let title = Constants.shippingOptionsTitle[index]
        let titleLabel = createShippingOptionsLabel(title: title, fontsize: 14, color: .black, textAlign: .left)
        let subtitle = Constants.shippingOptionsDesc[index]
        let subtitleLabel = createShippingOptionsLabel(title: subtitle, fontsize: 14, color: .black.withAlphaComponent(0.5), textAlign: .left)
        
        descStack.addArrangedSubview(titleLabel)
        descStack.setCustomSpacing(4, after: titleLabel)
        descStack.addArrangedSubview(subtitleLabel)
        
        return descStack
    }
    
    func createShippingOptionsLabel(title: String, fontsize: CGFloat, color: UIColor, textAlign: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont(name: "Futura-Medium", size: fontsize)
        label.textColor = color
        label.textAlignment = textAlign
        label.numberOfLines = 0
        return label
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
extension ShippingViewController : UITextFieldDelegate {
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
extension ShippingViewController {
    func popBackToCheckout(){
        let checkoutVC = self.navigationController?.viewControllers.first(where: { $0 is CheckoutViewController }) as! CheckoutViewController
        checkoutVC.userEmail = self.userEmail
        checkoutVC.address = self.address
        self.navigationController?.popViewController(animated: true)
    }
    
    func calculateTotal(index: Int) -> String{
        var res = 0.00
        let subtotal = Double(CommonStore.shared.calculateSubtotal())
        let shipping = Constants.shippingTotalCost[index]
        res = (subtotal ?? 0.00) + shipping
        
        return String(format: "$%.2f", res)
    }
}
