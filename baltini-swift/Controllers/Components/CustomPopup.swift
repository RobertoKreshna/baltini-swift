//
//  CustomPopup.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 27/10/23.
//

import UIKit

class CustomPopup {
    static func displayRegisterPopup(sender: UIViewController){

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
            string: "Account Created",
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
            UIAction(handler: { action in sender.navigationController?.popToRootViewController(animated: true) }),
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
}
