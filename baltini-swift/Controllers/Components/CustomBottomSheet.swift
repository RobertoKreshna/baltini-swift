//
//  CustomBottomSheet.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 03/11/23.
//

import UIKit

class CustomBottomSheet {
    
    static func getFilterPopup(owner: UIViewController){
        let popupBackgroundView = createBackgroundView(width: Int(owner.view.frame.size.width), height: Int(owner.view.frame.size.height))
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        
        let successImage = UIImageView(image: UIImage(named: "icSuccess"))
        successImage.translatesAutoresizingMaskIntoConstraints = false
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        let attributedLabelText = NSAttributedString(
            string: "FILTER",
            attributes: [.font : UIFont(name: "Futura-Medium", size: 18)!, .foregroundColor : UIColor.black]
        )
        description.attributedText = attributedLabelText
        
        contentView.addSubview(successImage)
        contentView.addSubview(description)
        
        successImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60).isActive = true
        successImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        description.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -60).isActive = true
        description.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(
            UIAction(handler: { action in popupBackgroundView.removeFromSuperview() }),
            for: .touchUpInside
        )
        button.layer.borderWidth = 1
        
        popupBackgroundView.addSubview(button)
        popupBackgroundView.addSubview(contentView)

        contentView.widthAnchor.constraint(equalTo: popupBackgroundView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: popupBackgroundView.heightAnchor, multiplier: 0.3).isActive = true
        contentView.bottomAnchor.constraint(equalTo: popupBackgroundView.bottomAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: popupBackgroundView.widthAnchor).isActive = true
        button.heightAnchor.constraint(equalTo: popupBackgroundView.heightAnchor).isActive = true
        
        owner.view.addSubview(popupBackgroundView)
    }
    
    static func getSortPopup(owner: ProductListViewController){
        let popupBackgroundView = createBackgroundView(width: Int(owner.view.frame.size.width), height: Int(owner.view.frame.size.height))
        
        let contentView = createSortContent(owner: owner, close: {
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
    
    static private func createSortContent(owner: ProductListViewController, close: @escaping () -> Void) -> UIView {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        
        let indicator = createGrayIndicator()
        let description = createDescription(string: "SORT PRODUCTS")
        let bestButton = createSortRadioButton(
            title: "Best Selling",
            selected: owner.sortValue == "Best Selling" ? true : false,
            pressed: sortPressed(owner: owner, newValue: "Best Selling", close: close)
        )
        let featuredButton = createSortRadioButton(
            title: "Featured",
            selected: owner.sortValue == "Featured" ? true : false,
            pressed: sortPressed(owner: owner, newValue: "Featured", close: close)
        )
        let lowPriceButton = createSortRadioButton(
            title: "Lowest Price", 
            selected: owner.sortValue == "Lowest Price" ? true : false,
            pressed: sortPressed(owner: owner, newValue: "Lowest Price", close: close)
        )
        let highPriceButton = createSortRadioButton(
            title: "Highest Price", 
            selected: owner.sortValue == "Highest Price" ? true : false,
            pressed: sortPressed(owner: owner, newValue: "Highest Price", close: close)
        )
        let aToZButton = createSortRadioButton(
            title: "Alphabetically, A-Z", 
            selected: owner.sortValue == "Alphabetically, A-Z" ? true : false,
            pressed: sortPressed(owner: owner, newValue: "Alphabetically, A-Z", close: close)
        )
        let zToAButton = createSortRadioButton(
            title: "Alphabetically, Z-A",
            selected: owner.sortValue == "Alphabetically, Z-A" ? true : false,
            pressed: sortPressed(owner: owner, newValue: "Alphabetically, Z-A", close: close)
        )
        let newToOldButton = createSortRadioButton(
            title: "Date, New to Old", 
            selected: owner.sortValue == "Date, New to Old" ? true : false,
            pressed: sortPressed(owner: owner, newValue: "Date, New to Old", close: close)
        )
        let oldToNewButton = createSortRadioButton(
            title: "Date, Old to New", 
            selected: owner.sortValue == "Date, Old to New" ? true : false,
            pressed: sortPressed(owner: owner, newValue: "Date, Old to New", close: close)
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
    
    static private func sortPressed(owner: ProductListViewController, newValue: String, close: @escaping () -> Void) -> UIAction{
        return UIAction { action in
            owner.sortValue = newValue
            close()
        }
    }
}