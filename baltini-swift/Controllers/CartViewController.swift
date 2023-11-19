//
//  CartViewController.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 11/11/23.
//

import Foundation
import UIKit
import BadgeSwift

class CartViewController: UIViewController {
    
    var totalLabel: UILabel = {
        let totalLabel = UILabel()
        totalLabel.text = "$\(CommonStore.shared.calculateSubtotal())"
        totalLabel.font = UIFont(name: "Futura-Bold", size: 14)!
        return totalLabel
    }()

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
extension CartViewController {
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
        
        let backButton = BackButton.createBackButton(title: "Cart (\(CommonStore.shared.getCartProductCount()))", icName: "icBack", usePadding: true, tapped: UIAction(handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        stackView.addArrangedSubview(backButton)
        backButton.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        
        stackView.setCustomSpacing(12, after: backButton)
        if(CommonStore.shared.getCartProductCount() > 0) {
            createAllProductCard(addTo: stackView)
            
            let notesStack = createOrderNotesStack()
            stackView.addArrangedSubview(notesStack)
            stackView.setCustomSpacing(40, after: notesStack)
            notesStack.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
            notesStack.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
            
            let clickProtectStack = createCreateProtectStack()
            stackView.addArrangedSubview(clickProtectStack)
            stackView.setCustomSpacing(40, after: clickProtectStack)
            clickProtectStack.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
            clickProtectStack.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
            
            let descLabel = createDescLabel()
            stackView.addArrangedSubview(descLabel)
            stackView.setCustomSpacing(17, after: descLabel)
            descLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
            descLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
            
            let agreeTCStack = createAgreeTCStack()
            stackView.addArrangedSubview(agreeTCStack)
            stackView.setCustomSpacing(35, after: agreeTCStack)
            agreeTCStack.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
            agreeTCStack.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
            
            let separator = CustomSeparator.createHorizontalLine(width: 1, color: UIColor.brandGray)
            stackView.addArrangedSubview(separator)
            stackView.setCustomSpacing(12, after: separator)
            separator.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
            separator.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
            
            let totalCheckoutStack = createTotalCheckoutStack()
            stackView.addArrangedSubview(totalCheckoutStack)
            stackView.setCustomSpacing(20, after: totalCheckoutStack)
            totalCheckoutStack.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
            totalCheckoutStack.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        }
    }
    
    func createAllProductCard(addTo stackView: UIStackView){
        for i in 0 ... CommonStore.shared.getCartProductCount() - 1 {
            let quantityLabel = PaddingLabel()
            
            let card = CustomCard.createCartItemCard(
                product: CommonStore.shared.getCartProductsAtIndex(index: i),
                qty: CommonStore.shared.getQtyAtIndex(index: i),
                variant: CommonStore.shared.getVariantsAtIndex(index: i),
                deletePressed: UIAction(handler: { action in self.deleteIconPressed(index: i) }),
                minPressed: UIAction(handler: { action in self.qtyButtonPressed(isAdd: false, label: quantityLabel, index: i) }),
                plusPressed: UIAction(handler: { action in self.qtyButtonPressed(isAdd: true, label: quantityLabel, index: i) }),
                qtyLabel: quantityLabel
            )
            
            stackView.addArrangedSubview(card)
            stackView.setCustomSpacing(i == CommonStore.shared.getCartProductCount() - 1 ? 40 : 24, after: card)
            
            card.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 16).isActive = true
            card.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -16).isActive = true
        }
    }
    
    func createOrderNotesStack() -> UIStackView{
        let contentStack = UIStackView()
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .leading
        
        let notesLabel = UILabel()
        notesLabel.translatesAutoresizingMaskIntoConstraints = false
        notesLabel.font = UIFont(name: "Futura-Medium", size: 14)!
        notesLabel.text = "ORDER NOTES"
        
        contentStack.addArrangedSubview(notesLabel)
        contentStack.setCustomSpacing(30, after: notesLabel)
        CustomTextfield.addTextfield(to: contentStack, placeholder: "Leave Notes", isPassword: false, owner: self, useDesc: false)
        
        return contentStack
    }
    
    func createCreateProtectStack() -> UIStackView {
        let contentStack = UIStackView()
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .horizontal
        contentStack.alignment = .leading
        
        let mainStack = createProtectMainContentStack()
        
        let switchButton = UISwitch()
        switchButton.isOn = CommonStore.shared.cartGetProtect()
        switchButton.offImage = UIImage(named: "switchOff")
        switchButton.onImage = UIImage(named: "switchOn")
        switchButton.addTarget(self, action: #selector(switchChanged(_:)), for: UIControl.Event.valueChanged)
        
        contentStack.addArrangedSubview(mainStack)
        contentStack.addArrangedSubview(switchButton)
        
        return contentStack
    }
    
    func createProtectMainContentStack() -> UIStackView {
        let mainStack = UIStackView()
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .vertical
        mainStack.alignment = .leading
        
        let priceStack = createProtectPriceStack()
        let descLabel = createProtectDescLabel()
        let learnMoreButton = CustomButton.createUnderlinedButton(title: "LEARN MORE", action: UIAction(handler: { action in
            print("learn more tapped")
        }))
        
        mainStack.addArrangedSubview(priceStack)
        mainStack.setCustomSpacing(8, after: priceStack)
        mainStack.addArrangedSubview(descLabel)
        mainStack.setCustomSpacing(4, after: descLabel)
        mainStack.addArrangedSubview(learnMoreButton)
        
        return mainStack
    }
    
    func createProtectPriceStack() -> UIStackView {
        let priceStack = UIStackView()
        priceStack.translatesAutoresizingMaskIntoConstraints = false
        priceStack.axis = .horizontal
        
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "1 CLICK PROTECT"
        nameLabel.font = UIFont(name: "Futura-Medium", size: 14)!
        
        let priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.text = "(USD 22.00)"
        priceLabel.font = UIFont(name: "Futura-Medium", size: 14)!
        priceLabel.textColor = UIColor.black.withAlphaComponent(0.5)
        
        priceStack.addArrangedSubview(nameLabel)
        priceStack.setCustomSpacing(8, after: nameLabel)
        priceStack.addArrangedSubview(priceLabel)
        
        return priceStack
    }
    
    func createProtectDescLabel() -> UILabel {
        let descLabel = UILabel()
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.text = "Instantly resolve shipping issues."
        descLabel.font = UIFont(name: "Futura-Medium", size: 14)!
        
        return descLabel
    }
    
    func createDescLabel() -> UILabel {
        let descLabel = UILabel()
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.text = "All orders are processed in USD at the most recent exchange rate available. Shipping, taxes, and discounts codes calculated at checkout. Please check the box below to agree with our Terms and Conditions."
        descLabel.font = UIFont(name: "Futura-Medium", size: 12)!
        descLabel.numberOfLines = 0
        descLabel.textAlignment = .justified
        descLabel.textColor = .black.withAlphaComponent(0.5)
        
        return descLabel
    }
    
    func createAgreeTCStack() -> UIStackView {
        let contentStack = UIStackView()
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .leading
        
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        
        let checkButton = UIButton(type: .system)
        checkButton.setImage(UIImage(named: CommonStore.shared.cartGetAgreeTC() ? "icCheckSelected" : "icCheck")!.withRenderingMode(.alwaysOriginal), for: .normal)
        checkButton.addAction(UIAction(handler: { action in self.tcPressed(checkButton) }), for: .touchUpInside)
        
        let descLabel = UILabel()
        descLabel.text = "I agree with the"
        descLabel.font = UIFont(name: "Futura-Medium", size: 14)!
        
        let tcButton = CustomButton.createUnderlinedButton(title: "TERMS AND CONDITION", action: UIAction(handler: { action in
            print("tc pressed")
        }))
        
        stack.addArrangedSubview(checkButton)
        stack.setCustomSpacing(8, after: checkButton)
        stack.addArrangedSubview(descLabel)
        stack.setCustomSpacing(2, after: descLabel)
        stack.addArrangedSubview(tcButton)
        
        contentStack.addArrangedSubview(stack)
        
        return contentStack
    }
    
    func createTotalCheckoutStack() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        
        let totalStack = createTotalStack()
        let checkoutButton = CustomButton.createBlackButton(title: "CHECK OUT", action: UIAction(handler: { action in
            print("checkout pressed")
        }))
        
        stack.addArrangedSubview(totalStack)
        stack.setCustomSpacing(17, after: totalStack)
        stack.addArrangedSubview(checkoutButton)
        
        checkoutButton.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 0.5).isActive = true
        
        return stack
    }
    
    func createTotalStack() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .trailing
        
        let titleLabel = UILabel()
        titleLabel.text = "Subtotal"
        titleLabel.font = UIFont(name: "Futura-Medium", size: 14)!
        
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(totalLabel)
        
        return stack
    }
}

//MARK: Button pressed functions
extension CartViewController {
    func deleteIconPressed(index i: Int){
        CommonStore.shared.removeProductFromCart(index: i)
        CustomToast.showGrayUndoToast(
            msg: "Item deleted to cart.",
            undoPressed: {
                CommonStore.shared.undoRemove()
                UIView.animate(
                    withDuration: 0.0,
                    animations: { self.view.alpha = 0.5 },
                    completion: {(value: Bool) in
                        self.removeUI()
                    }
                )
                UIView.animate(
                    withDuration: 0.0,
                    animations: { self.view.alpha = 1.0 },
                    completion: {(value: Bool) in
                        self.createUI()
                    }
                )
            },
            sender: self
        )
        self.removeUI()
        self.createUI()
    }
    
    func qtyButtonPressed(isAdd: Bool, label: PaddingLabel, index: Int){
        isAdd ? CommonStore.shared.plusQtyAtIndex(index: index) : CommonStore.shared.minQtyAtIndex(index: index)
        DispatchQueue.main.async {
            label.attributedText = NSAttributedString(
                string: String(describing: CommonStore.shared.getQtyAtIndex(index: index)),
                attributes: [.font : UIFont(name: "Futura-Medium", size: 14)!, .foregroundColor : UIColor.black]
            )
            self.totalLabel.text = "$\(CommonStore.shared.calculateSubtotal())"
        }
    }
    
    @objc func switchChanged(_ mySwitch: UISwitch) {
        mySwitch.isOn ? CommonStore.shared.cartSetProtect(value: false) : CommonStore.shared.cartSetProtect(value: true)
    }
    
    func tcPressed(_ sender: UIButton){
        CommonStore.shared.cartSetAgreeTC(value: CommonStore.shared.cartGetAgreeTC() ? false : true);
        sender.setImage(UIImage(named: CommonStore.shared.cartGetAgreeTC() ? "icCheckSelected" : "icCheck")!.withRenderingMode(.alwaysOriginal), for: .normal)
    }
}

extension CartViewController : UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
