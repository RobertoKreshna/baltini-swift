//
//  CustomPopup.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 27/10/23.
//

import UIKit

class CustomPopup {
    static func displayPopup(sender: UIViewController, title: String, toRoot: Bool){
        let backgroundFrame = CGRect(x: 0, y: 0, width: Int(sender.view.frame.size.width), height: Int(sender.view.frame.size.height))
        let popupBackgroundView = UIView(frame: backgroundFrame)
        popupBackgroundView.backgroundColor = .black.withAlphaComponent(0.2)
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        
        let successImage = UIImageView(image: UIImage(named: "icSuccess"))
        successImage.translatesAutoresizingMaskIntoConstraints = false
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        let attributedLabelText = NSAttributedString(
            string: title,
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
            UIAction(handler: { action in
                if toRoot {
                    sender.navigationController?.popToRootViewController(animated: true)
                } else {
                    sender.navigationController?.popViewController(animated: true)
                }
            }),
            for: .touchUpInside
        )
        button.layer.borderWidth = 1
        
        popupBackgroundView.addSubview(button)
        popupBackgroundView.addSubview(contentView)

        contentView.widthAnchor.constraint(equalTo: popupBackgroundView.widthAnchor, multiplier: 0.65).isActive = true
        contentView.heightAnchor.constraint(equalTo: popupBackgroundView.heightAnchor, multiplier: 0.3).isActive = true
        contentView.centerXAnchor.constraint(equalTo: popupBackgroundView.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: popupBackgroundView.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: popupBackgroundView.widthAnchor).isActive = true
        button.heightAnchor.constraint(equalTo: popupBackgroundView.heightAnchor).isActive = true
        
        sender.view.addSubview(popupBackgroundView)
    }
    
    static func displayLoading(sender: UIViewController) -> UIView{
        let backgroundFrame = CGRect(x: 0, y: 0, width: Int(sender.view.frame.size.width), height: Int(sender.view.frame.size.height))
        let popupBackgroundView = UIView(frame: backgroundFrame)
        popupBackgroundView.backgroundColor = .white
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        
        let activityView = UIImageView(image: UIImage(named: "loading"))
        activityView.translatesAutoresizingMaskIntoConstraints = false
        animateLoading(view: activityView)
        
        contentView.addSubview(activityView)
        
        activityView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        //shadow
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowRadius = 10
        contentView.layer.shadowOpacity = 0.5
        
        popupBackgroundView.addSubview(contentView)
        contentView.widthAnchor.constraint(equalTo: popupBackgroundView.widthAnchor, multiplier: 0.4).isActive = true
        contentView.heightAnchor.constraint(equalTo: popupBackgroundView.heightAnchor, multiplier: 0.2).isActive = true
        contentView.centerXAnchor.constraint(equalTo: popupBackgroundView.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: popupBackgroundView.centerYAnchor).isActive = true
        
        return popupBackgroundView
    }
    
    static private func animateLoading(view: UIView){
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            view.transform = CGAffineTransform.identity
            view.transform = CGAffineTransform(rotationAngle: .pi)
        }){ (true) in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
                view.transform = CGAffineTransform.identity
                view.transform = CGAffineTransform(rotationAngle: .pi * 2)
            }){ (true) in
                animateLoading(view: view)
            }
        }
    }
    
    static func displayAddressConfirmationPopup(sender: UIViewController, address: AddressArgs){
        let backgroundFrame = CGRect(x: 0, y: 0, width: Int(sender.view.frame.size.width), height: Int(sender.view.frame.size.height))
        let popupBackgroundView = UIView(frame: backgroundFrame)
        popupBackgroundView.backgroundColor = .black.withAlphaComponent(0.2)
        
        let contentView = UIStackView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.axis = .vertical
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 1
        
        let label = UILabel()
        label.text = "Is the shipping address correct ?"
        label.font = UIFont(name: "Futura-Medium", size: 18)
        label.textAlignment = .center
        let addressDetails = createAddressDetails(address: address)
        let modifyButton = CustomButton.createBlackButton(
            title: "MODIFY ADDRESS",
            action: UIAction(handler: { action in popupBackgroundView.removeFromSuperview() })
        )
        let yesButton = CustomButton.createBlackButton(
            title: "YES, CONFIRM",
            action: UIAction(handler: { action in
                print("yes pressed")
            })
        )
        
        contentView.addArrangedSubview(label)
        contentView.setCustomSpacing(16, after: label)
        contentView.addArrangedSubview(addressDetails)
        contentView.setCustomSpacing(32, after: addressDetails)
        contentView.addArrangedSubview(modifyButton)
        contentView.setCustomSpacing(8, after: modifyButton)
        contentView.addArrangedSubview(yesButton)
        
        contentView.isLayoutMarginsRelativeArrangement = true
        contentView.layoutMargins = UIEdgeInsets(top: 40, left: 16, bottom: 32, right: 16)
        
        popupBackgroundView.addSubview(contentView)
        contentView.rightAnchor.constraint(equalTo: popupBackgroundView.rightAnchor, constant: -40).isActive = true
        contentView.leftAnchor.constraint(equalTo: popupBackgroundView.leftAnchor, constant: 40).isActive = true
        contentView.centerXAnchor.constraint(equalTo: popupBackgroundView.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: popupBackgroundView.centerYAnchor).isActive = true
        
        sender.view.addSubview(popupBackgroundView)
    }
    
    static private func createAddressDetails(address: AddressArgs) -> UILabel {
        let label = UILabel()
        label.text = address.address2!.isEmpty
        ? "\(address.address1)\n\(address.city)\n\(address.province)\n\(address.zipCode)"
        : "\(address.address1), \(address.address2!)\n\(address.city)\n\(address.province)\n\(address.zipCode)"
        label.font = UIFont(name: "Futura-Medium", size: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }
}
