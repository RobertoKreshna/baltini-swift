//
//  CustomBottomSheet.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 03/11/23.
//

import UIKit

class CustomBottomSheet {
    
    static func getFilterPopup(keys: [String], values: [[String]], tapped: [UITapGestureRecognizer], owner: UIViewController){
        let popupBackgroundView = createBackgroundView(width: Int(owner.view.frame.size.width), height: Int(owner.view.frame.size.height))
        
        let contentView = createFilterContent(keys: keys, values: values, tapped: tapped, close: {
            popupBackgroundView.removeFromSuperview()
        })
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(
            UIAction(handler: { action in popupBackgroundView.removeFromSuperview() }),
            for: .touchUpInside
        )
        
        popupBackgroundView.addSubview(button)
        popupBackgroundView.addSubview(contentView)

        contentView.widthAnchor.constraint(equalTo: popupBackgroundView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: popupBackgroundView.heightAnchor, multiplier: 0.56).isActive = true
        contentView.bottomAnchor.constraint(equalTo: popupBackgroundView.bottomAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: popupBackgroundView.widthAnchor).isActive = true
        button.heightAnchor.constraint(equalTo: popupBackgroundView.heightAnchor).isActive = true
        
        owner.view.addSubview(popupBackgroundView)
    }
    
    static func getSortPopup(selected: String, tapped: @escaping (String) -> Void, owner: UIViewController){
        let popupBackgroundView = createBackgroundView(width: Int(owner.view.frame.size.width), height: Int(owner.view.frame.size.height))
        
        let contentView = createSortContent(selected: selected, tapped: tapped, close: {
            popupBackgroundView.removeFromSuperview()
        })
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(
            UIAction(handler: { action in popupBackgroundView.removeFromSuperview() }),
            for: .touchUpInside
        )
        
        popupBackgroundView.addSubview(button)
        popupBackgroundView.addSubview(contentView)

        contentView.widthAnchor.constraint(equalTo: popupBackgroundView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: popupBackgroundView.heightAnchor, multiplier: 0.6).isActive = true
        contentView.bottomAnchor.constraint(equalTo: popupBackgroundView.bottomAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: popupBackgroundView.widthAnchor).isActive = true
        button.heightAnchor.constraint(equalTo: popupBackgroundView.heightAnchor).isActive = true
        
        owner.view.addSubview(popupBackgroundView)
    }
    
    static private func createBackgroundView(width: Int, height: Int) -> UIView {
        let backgroundFrame = CGRect(x: 0, y: 0, width: width, height: height)
        let popupBackgroundView = UIView(frame: backgroundFrame)
        popupBackgroundView.backgroundColor = .black.withAlphaComponent(0.2)
        
        return popupBackgroundView
    }
    
    static private func createGrayIndicator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.brandGray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }
    
    static private func createDescription(string: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedLabelText = NSAttributedString(
            string: string,
            attributes: [.font : UIFont(name: "Futura-Medium", size: 18)!, .foregroundColor : UIColor.black]
        )
        label.attributedText = attributedLabelText
        label.textAlignment = .left
        return label
    }
    
    static private func createSortRadioButton(title: String, selected: Bool, pressed: UIAction) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedTitle = NSAttributedString(
            string: title,
            attributes: [.font : UIFont(name: "Futura-Medium", size: 14)!, .foregroundColor : UIColor.black]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.setImage(UIImage(named: selected ? "icRadioSelected" : "icRadio")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentHorizontalAlignment = .left
        
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 0)
        configuration.imagePadding = 12
        button.configuration = configuration
        
        button.addAction(pressed, for: .touchUpInside)
        
        return button
    }
    
    static private func createSortContent(selected: String, tapped: @escaping (String) -> Void , close: @escaping () -> Void) -> UIView {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        
        let indicator = createGrayIndicator()
        let description = createDescription(string: "SORT PRODUCTS")
        let bestButton = createSortRadioButton(
            title: "Best Selling",
            selected: selected == "Best Selling" ? true : false,
            pressed: UIAction(handler: { action in tapped("Best Selling") })
        )
        let featuredButton = createSortRadioButton(
            title: "Featured",
            selected: selected == "Featured" ? true : false,
            pressed: UIAction(handler: { action in tapped("Featured") })
        )
        let lowPriceButton = createSortRadioButton(
            title: "Lowest Price", 
            selected: selected == "Lowest Price" ? true : false,
            pressed: UIAction(handler: { action in tapped("Lowest Price") })
        )
        let highPriceButton = createSortRadioButton(
            title: "Highest Price", 
            selected: selected == "Highest Price" ? true : false,
            pressed: UIAction(handler: { action in tapped("Highest Price") })
        )
        let aToZButton = createSortRadioButton(
            title: "Alphabetically, A-Z", 
            selected: selected == "Alphabetically, A-Z" ? true : false,
            pressed: UIAction(handler: { action in tapped("Alphabetically, A-Z") })
        )
        let zToAButton = createSortRadioButton(
            title: "Alphabetically, Z-A",
            selected: selected == "Alphabetically, Z-A" ? true : false,
            pressed: UIAction(handler: { action in tapped("Alphabetically, Z-A") })
        )
        let newToOldButton = createSortRadioButton(
            title: "Date, New to Old", 
            selected: selected == "Date, New to Old" ? true : false,
            pressed: UIAction(handler: { action in tapped("Date, New to Old") })
        )
        let oldToNewButton = createSortRadioButton(
            title: "Date, Old to New", 
            selected: selected == "Date, Old to New" ? true : false,
            pressed: UIAction(handler: { action in tapped("Date, Old to New") })
        )
        
        contentView.addSubview(indicator)
        contentView.addSubview(description)
        contentView.addSubview(bestButton)
        contentView.addSubview(featuredButton)
        contentView.addSubview(lowPriceButton)
        contentView.addSubview(highPriceButton)
        contentView.addSubview(aToZButton)
        contentView.addSubview(zToAButton)
        contentView.addSubview(newToOldButton)
        contentView.addSubview(oldToNewButton)
        
        indicator.widthAnchor.constraint(equalToConstant: 35).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 4).isActive = true
        indicator.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        indicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        description.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32).isActive = true
        description.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        description.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        description.topAnchor.constraint(equalTo: indicator.bottomAnchor, constant: 17).isActive = true
        
        bestButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        bestButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        bestButton.topAnchor.constraint(equalTo: description.bottomAnchor, constant: 4).isActive = true
        
        featuredButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        featuredButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        featuredButton.topAnchor.constraint(equalTo: bestButton.bottomAnchor).isActive = true
        
        lowPriceButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        lowPriceButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        lowPriceButton.topAnchor.constraint(equalTo: featuredButton.bottomAnchor).isActive = true
        
        highPriceButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        highPriceButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        highPriceButton.topAnchor.constraint(equalTo: lowPriceButton.bottomAnchor).isActive = true
        
        aToZButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        aToZButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        aToZButton.topAnchor.constraint(equalTo: highPriceButton.bottomAnchor).isActive = true
        
        zToAButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        zToAButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        zToAButton.topAnchor.constraint(equalTo: aToZButton.bottomAnchor).isActive = true
        
        newToOldButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        newToOldButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        newToOldButton.topAnchor.constraint(equalTo: zToAButton.bottomAnchor).isActive = true
        
        oldToNewButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        oldToNewButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        oldToNewButton.topAnchor.constraint(equalTo: newToOldButton.bottomAnchor).isActive = true
        
        return contentView
    }
    
    static private func createFilterTile(title: String, value: [String], tapped: UITapGestureRecognizer) -> UIView {
        let attributedTitle = NSAttributedString(
            string: title,
            attributes: [.font : UIFont(name: "Futura-Medium", size: 14)!, .foregroundColor : UIColor.black]
        )
        let attributedSubtitle = NSAttributedString(
            string: value.joined(separator: ","),
            attributes: [.font: UIFont(name: "Futura-Medium", size: 10)!, .foregroundColor : UIColor.black.withAlphaComponent(0.5)]
        )
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.attributedText = attributedTitle
        
        let valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.attributedText = attributedSubtitle
        
        let tileStack = UIStackView()
        tileStack.axis = .horizontal
        tileStack.translatesAutoresizingMaskIntoConstraints = false
        
        let checkBox = UIImageView(image: UIImage(named: value.isEmpty ? "icCheck" : "icCheckSelected"))
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        
        let labelStack = UIStackView(arrangedSubviews: value.isEmpty ? [titleLabel] : [titleLabel, valueLabel])
        labelStack.axis = .vertical
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        
        let rightArrow = UIImageView(image: UIImage(named: "icRight"))
        rightArrow.translatesAutoresizingMaskIntoConstraints = false
        
        tileStack.addArrangedSubview(checkBox)
        tileStack.setCustomSpacing(12, after: checkBox)
        tileStack.addArrangedSubview(labelStack)
        tileStack.addArrangedSubview(rightArrow)
        
        checkBox.widthAnchor.constraint(equalToConstant: 24).isActive = true
        checkBox.heightAnchor.constraint(equalToConstant: 24).isActive = true
        labelStack.heightAnchor.constraint(greaterThanOrEqualToConstant: 24).isActive = true
        rightArrow.widthAnchor.constraint(equalToConstant: 24).isActive = true
        rightArrow.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        tileStack.isLayoutMarginsRelativeArrangement = true
        tileStack.layoutMargins = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        
        tileStack.addGestureRecognizer(tapped)
        
        return tileStack
    }
    
    static private func createFilterContent(keys: [String], values:[[String]], tapped: [UITapGestureRecognizer], close: @escaping () -> Void) -> UIView {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        
        let indicator = createGrayIndicator()
        let description = createDescription(string: "FILTER")
        let gender = createFilterTile(title: keys[0], value: values[0], tapped: tapped[0])
        let category = createFilterTile(title: keys[1], value: values[1], tapped: tapped[1])
        let productType = createFilterTile(title: keys[2], value: values[2], tapped: tapped[2])
        let designer = createFilterTile(title: keys[3], value: values[3], tapped: tapped[3])
        let size = createFilterTile(title: keys[4], value: values[4], tapped: tapped[4])
        let price = createFilterTile(title: keys[5], value: values[5], tapped: tapped[5])
        let button = CustomButton.createBlackButton(title: "FILTER", action: UIAction(handler: { action in close() }))
        button.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(indicator)
        contentView.addSubview(description)
        contentView.addSubview(gender)
        contentView.addSubview(category)
        contentView.addSubview(productType)
        contentView.addSubview(designer)
        contentView.addSubview(size)
        contentView.addSubview(price)
        contentView.addSubview(button)
        
        indicator.widthAnchor.constraint(equalToConstant: 35).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 4).isActive = true
        indicator.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        indicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        description.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32).isActive = true
        description.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        description.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        description.topAnchor.constraint(equalTo: indicator.bottomAnchor, constant: 17).isActive = true
        
        gender.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        gender.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        gender.topAnchor.constraint(equalTo: description.bottomAnchor, constant: 4).isActive = true
        
        category.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        category.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        category.topAnchor.constraint(equalTo: gender.bottomAnchor).isActive = true
        
        productType.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        productType.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        productType.topAnchor.constraint(equalTo: category.bottomAnchor).isActive = true
        
        designer.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        designer.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        designer.topAnchor.constraint(equalTo: productType.bottomAnchor).isActive = true
        
        size.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        size.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        size.topAnchor.constraint(equalTo: designer.bottomAnchor).isActive = true
        
        price.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        price.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        price.topAnchor.constraint(equalTo: size.bottomAnchor).isActive = true
        
        button.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        button.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        button.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 24).isActive = true
        
        return contentView
    }
}
