//
//  OrderDetailViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 29/11/23.
//

import UIKit

class OrderDetailViewController: UIViewController {
    
    var currentOrder: Order?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
        removeUI()
        createUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func removeUI() {
       let subviews = view.subviews
       subviews.forEach { subview in
           subview.removeFromSuperview()
       }
   }
}

//MARK: Create UI Methods
extension OrderDetailViewController {
    func createUI(){
        //change view bg color
        view.backgroundColor = .white
        
        //create scroll view
        let scrollView = UIScrollView()
        scrollView.isUserInteractionEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 22).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //create stack view
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        scrollView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let backButton = BackButton.createBackButton(title: "Order \(currentOrder!.id!)" , icName: "icBack", usePadding: false, tapped: UIAction(handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        stackView.addArrangedSubview(backButton)
        stackView.setCustomSpacing(30, after: backButton)
        backButton.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        
        let orderIdSection = createSection(title: "Order Id", subtitle: currentOrder!.id!)
        stackView.addArrangedSubview(orderIdSection)
        stackView.setCustomSpacing(16, after: orderIdSection)
        
        let orderDateSection = createSection(title: "Order Date", subtitle: getStringFromDate(date: currentOrder!.orderDate!))
        stackView.addArrangedSubview(orderDateSection)
        stackView.setCustomSpacing(16, after: orderDateSection)
        
        let status = createStatusStack()
        stackView.addArrangedSubview(status)
        stackView.setCustomSpacing(24, after: status)
        
        let headerContentSeparator = CustomSeparator.createHorizontalLine(width: 2, color: .brandGray)
        stackView.addArrangedSubview(headerContentSeparator)
        stackView.setCustomSpacing(24, after: headerContentSeparator)
        
        let orderSummaryStack = createOrderSummaryStack()
        stackView.addArrangedSubview(orderSummaryStack)
        stackView.setCustomSpacing(24, after: orderSummaryStack)
        
        let contentContantSeparator = CustomSeparator.createHorizontalLine(width: 2, color: .brandGray)
        stackView.addArrangedSubview(contentContantSeparator)
        stackView.setCustomSpacing(24, after: contentContantSeparator)
        
        let contactInfoStack = createContactInfoStack()
        stackView.addArrangedSubview(contactInfoStack)
        stackView.setCustomSpacing(24, after: contactInfoStack)
        
        let contantPaymentSeparator = CustomSeparator.createHorizontalLine(width: 2, color: .brandGray)
        stackView.addArrangedSubview(contantPaymentSeparator)
        stackView.setCustomSpacing(24, after: contantPaymentSeparator)
        
        let paymentInfoStack = createPaymentInfoStack()
        stackView.addArrangedSubview(paymentInfoStack)
        stackView.setCustomSpacing(24, after: paymentInfoStack)
        
        let paymentButtonSeparator = CustomSeparator.createHorizontalLine(width: 2, color: .brandGray)
        stackView.addArrangedSubview(paymentButtonSeparator)
        stackView.setCustomSpacing(24, after: paymentButtonSeparator)
        
        let button = CustomButton.createWhiteButton(title: "CANCEL ORDER", action: UIAction(handler: { action in
            print("tapped")
        }))
        stackView.addArrangedSubview(button)
        stackView.setCustomSpacing(24, after: button)
        
        stackView.addArrangedSubview(UIView())
    }
    
    func createSection(title: String, subtitle: String) -> UIStackView {
        let section = UIStackView()
        section.translatesAutoresizingMaskIntoConstraints = false
        section.axis = .vertical
        
        let titleLabel = UILabel()
        titleLabel.text = title.uppercased()
        titleLabel.font = UIFont(name: "Futura-Medium", size: 10)
        titleLabel.textColor = .black.withAlphaComponent(0.5)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = UIFont(name: "Futura-Medium", size: 16)
        subtitleLabel.textColor = .black
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .left
        
        section.addArrangedSubview(titleLabel)
        section.setCustomSpacing(4, after: titleLabel)
        section.addArrangedSubview(subtitleLabel)
        
        return section
    }
    
    func createStatusStack() -> UIStackView {
        let row = UIStackView()
        row.translatesAutoresizingMaskIntoConstraints = false
        row.axis = .horizontal
        
        let randomStatus = createRandomStatus()
        randomStatus.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        let spacer = UIView()
        spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        row.addArrangedSubview(randomStatus)
        row.addArrangedSubview(spacer)
        
        return row
    }
    
    func createRandomStatus() -> UIStackView {
        let random = Int.random(in: 0...2)
        
        let status = UIStackView()
        status.translatesAutoresizingMaskIntoConstraints = false
        status.axis = .horizontal
        status.layer.cornerRadius = 14
        status.isLayoutMarginsRelativeArrangement = true
        status.layoutMargins = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 8)
        
        if random == 0 {
            let imageName =  "icUnfulfilled"
            let imageView = UIImageView(image: UIImage(named: imageName))
            let label = UILabel()
            label.font = UIFont(name: "Futura-Medium", size: 11)
            label.text = "Unfulfilled"
            
            imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            
            status.backgroundColor = .unfulfilledBg
            
            status.addArrangedSubview(imageView)
            status.setCustomSpacing(4, after: imageView)
            status.addArrangedSubview(label)
        } else if random == 1 {
            let imageName =  "icPartiallyFulfilled"
            let imageView = UIImageView(image: UIImage(named: imageName))
            let label = UILabel()
            label.font = UIFont(name: "Futura-Medium", size: 11)
            label.text = "Partially Fulfilled"
            
            imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            
            status.backgroundColor = .partiallyFulfilledBg
            
            status.addArrangedSubview(imageView)
            status.setCustomSpacing(4, after: imageView)
            status.addArrangedSubview(label)
        } else if random == 2 {
            let imageName =  "icFulfilled"
            let imageView = UIImageView(image: UIImage(named: imageName))
            let label = UILabel()
            label.font = UIFont(name: "Futura-Medium", size: 11)
            label.textColor = .fulfilledText
            label.text = "Fulfilled"
            
            imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            
            status.backgroundColor = .fulfilledBg
            
            status.addArrangedSubview(imageView)
            status.setCustomSpacing(4, after: imageView)
            status.addArrangedSubview(label)
        }
        
        return status
    }
    
    func createOrderSummaryStack() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        
        let title = UILabel()
        title.text = "ORDER SUMMARY"
        title.font = UIFont(name: "Futura-Medium", size: 14)
        stack.addArrangedSubview(title)
        stack.setCustomSpacing(16, after: title)
        
        let products = currentOrder!.has!.allObjects as! [OrderProduct]
        products.forEach { orderProduct in
            let card = createItemCard(item: orderProduct)
            stack.addArrangedSubview(card)
            stack.setCustomSpacing(16, after: card)
        }
        
        if currentOrder!.useProtect {
            let protectCard = CustomCheckoutComponent.createProtectCard()
            stack.addArrangedSubview(protectCard)
            stack.setCustomSpacing(16, after: protectCard)
        }
        
        let descStack = createDescStack()
        stack.addArrangedSubview(descStack)
        stack.setCustomSpacing(16, after: descStack)
        
        return stack
    }
    
    func createItemCard(item: OrderProduct) -> UIStackView {
        let row = UIStackView()
        row.translatesAutoresizingMaskIntoConstraints = false
        row.axis = .horizontal
        row.alignment = .leading
        
        let itemImageView = UIImageView()
        if(item.imageName == "http://placekitten.com/200/300"){
            itemImageView.image = UIImage(named: "productPlaceholder")
        } else {
            itemImageView.imageFromServerURL(item.imageName!, placeHolder: UIImage(named: "productPlaceholder"))
        }
        
        let itemDesc = createItemDesc(brand: item.brand!, name: item.name!, size: item.size!, price: item.price!, qty: item.quantity)
        
        row.addArrangedSubview(itemImageView)
        row.setCustomSpacing(8, after: itemImageView)
        row.addArrangedSubview(itemDesc)
        
        itemImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        itemImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        return row
    }
    
    func createItemDesc(brand: String, name: String, size: String, price: String, qty: Double) -> UIStackView {
        let labelStack = UIStackView()
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        labelStack.axis = .vertical
        labelStack.alignment = .leading
        
        let brandLabel = UILabel()
        brandLabel.text = brand
        brandLabel.font = UIFont(name: "Futura-Bold", size: 14)!
        
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.font = UIFont(name: "Futura-Medium", size: 14)!
        
        let variantLabel = UILabel()
        variantLabel.text = size
        variantLabel.font = UIFont(name: "Futura-Medium", size: 14)!
        variantLabel.textColor = .black.withAlphaComponent(0.5)
        
        let priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.text = "\(price) x \(qty)"
        priceLabel.font = UIFont(name: "Futura-Medium", size: 14)!
        
        let totalLabel = UILabel()
        totalLabel.textColor = .black
        totalLabel.font = UIFont(name: "Futura-Medium", size: 16)
        totalLabel.text = String(describing: "$\(Double(price)! * Double(qty))")
        
        let priceAndTotalStack = UIStackView(arrangedSubviews: [priceLabel, totalLabel])
        priceAndTotalStack.axis = .horizontal
        priceAndTotalStack.translatesAutoresizingMaskIntoConstraints = false
        priceAndTotalStack.distribution = .equalCentering
        
        labelStack.addArrangedSubview(brandLabel)
        labelStack.setCustomSpacing(4, after: brandLabel)
        labelStack.addArrangedSubview(nameLabel)
        labelStack.setCustomSpacing(4, after: nameLabel)
        labelStack.addArrangedSubview(variantLabel)
        labelStack.setCustomSpacing(8, after: variantLabel)
        labelStack.addArrangedSubview(priceAndTotalStack)
        priceAndTotalStack.leftAnchor.constraint(equalTo: labelStack.leftAnchor).isActive = true
        priceAndTotalStack.rightAnchor.constraint(equalTo: labelStack.rightAnchor).isActive = true
        
        return labelStack
    }
    
    func createDescStack() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        
        let subtotalRow = createDescRow(leftTitle: "Subtotal", rightTitle: calculateTotal(withShipping: false))
        let shippingRow = createDescRow(leftTitle: "Shipping", rightTitle: currentOrder!.shippingCost!)
        let importRow = createDescRow(leftTitle: "Import Duty/Taxes", rightTitle: currentOrder!.importCost!)
        let taxesRow = createDescRow(leftTitle: "Estimated Taxes", rightTitle: currentOrder!.estTaxCost!)
        let totalRow = createTotalRow()
        
        stack.addArrangedSubview(subtotalRow)
        stack.addArrangedSubview(shippingRow)
        stack.addArrangedSubview(importRow)
        stack.addArrangedSubview(taxesRow)
        stack.addArrangedSubview(totalRow)
        
        return stack
    }
    
    func createDescRow(leftTitle: String, rightTitle: String) -> UIStackView {
        let row = UIStackView()
        row.translatesAutoresizingMaskIntoConstraints = false
        row.axis = .horizontal
        row.alignment = .center
        
        let leftLabel = UILabel()
        leftLabel.text = leftTitle
        leftLabel.font = UIFont(name: "Futura-Medium", size: 14)
        leftLabel.textColor = .black
        leftLabel.textAlignment = .left
        let rightLabel = UILabel()
        rightLabel.text = rightTitle
        rightLabel.font = UIFont(name: "Futura-Medium", size: 14)
        rightLabel.textColor = .black
        rightLabel.textAlignment = .right
        
        row.addArrangedSubview(leftLabel)
        row.addArrangedSubview(rightLabel)
        
        return row
    }
    
    func createTotalRow() -> UIStackView {
        let row = UIStackView()
        row.translatesAutoresizingMaskIntoConstraints = false
        row.axis = .horizontal
        row.alignment = .center
        
        let leftLabel = UILabel()
        leftLabel.text = "Total"
        leftLabel.font = UIFont(name: "Futura-Medium", size: 14)
        leftLabel.textColor = .black
        leftLabel.textAlignment = .left
        let currencyLabel = UILabel()
        currencyLabel.text = "USD"
        currencyLabel.font = UIFont(name: "Futura-Medium", size: 12)
        currencyLabel.textColor = .black.withAlphaComponent(0.5)
        currencyLabel.textAlignment = .left
        currencyLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        currencyLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        let rightLabel = UILabel()
        rightLabel.text = calculateTotal(withShipping: true)
        rightLabel.font = UIFont(name: "Futura-Medium", size: 18)
        rightLabel.textColor = .black
        rightLabel.textAlignment = .right
        rightLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        row.addArrangedSubview(leftLabel)
        row.addArrangedSubview(currencyLabel)
        row.setCustomSpacing(8, after: currencyLabel)
        row.addArrangedSubview(rightLabel)
        
        return row
    }
    
    func createContactInfoStack() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        
        let title = UILabel()
        title.text = "CONTACT INFORMATION"
        title.font = UIFont(name: "Futura-Medium", size: 14)
        stack.addArrangedSubview(title)
        stack.setCustomSpacing(16, after: title)
        
        let emailSection = createSection(title: "Contact", subtitle: currentOrder!.contactEmail!)
        let addressSection = createSection(title: "Ship to", subtitle: currentOrder!.shippingAddress!)
        let shippingSection = createSection(title: "Method", subtitle: "\(currentOrder!.shippingMethod!) - \(currentOrder!.shippingCost!)")
        
        stack.addArrangedSubview(emailSection)
        stack.setCustomSpacing(24, after: emailSection)
        stack.addArrangedSubview(addressSection)
        stack.setCustomSpacing(24, after: addressSection)
        stack.addArrangedSubview(shippingSection)
        
        return stack
    }
    
    func createPaymentInfoStack() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        
        let title = UILabel()
        title.text = "CONTACT INFORMATION"
        title.font = UIFont(name: "Futura-Medium", size: 14)
        stack.addArrangedSubview(title)
        stack.setCustomSpacing(16, after: title)
        
        let emailSection = createSection(title: "Payment Method", subtitle: currentOrder!.paymentMethod!)
        let addressSection = createSection(title: "Payment Time", subtitle: getStringFromDate(date: currentOrder!.paymentDate!))
        let shippingSection = createSection(title: "Billing Address", subtitle: currentOrder!.paymentAddress!)
        
        stack.addArrangedSubview(emailSection)
        stack.setCustomSpacing(24, after: emailSection)
        stack.addArrangedSubview(addressSection)
        stack.setCustomSpacing(24, after: addressSection)
        stack.addArrangedSubview(shippingSection)
        
        return stack
    }
    
    func getStringFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM, yyyy HH:mm a"
        return dateFormatter.string(from: date)
    }
    
    func calculateTotal(withShipping: Bool) -> String {
        var res = 0.0
        let products = currentOrder!.has!.allObjects as! [OrderProduct]
        products.forEach { product in res = res + Double(product.price!)! * product.quantity }
        if currentOrder!.useProtect { res += 22.00  }
        if withShipping { res = res + (currentOrder!.shippingCost!.trimmingPrefix("$") as NSString).doubleValue}
        return String(format: "$%.2f", res)
    }
}
