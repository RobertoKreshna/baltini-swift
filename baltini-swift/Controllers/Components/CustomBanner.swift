//
//  CustomBanner.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 02/11/23.
//

import UIKit

class CustomBanner {
    static func addPromotionBanner(to stack: UIStackView){
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 36))
        view.backgroundColor = .black
        
        let attributedTitle = NSAttributedString(
            string: "Free worldwide express shipping on all orders over $200",
            attributes: [.font: UIFont(name: "Futura-Medium", size: 12)!, .foregroundColor : UIColor.white]
        )
        let attributedTitle1 = NSAttributedString(
            string: "Subscribe to get our latest and hottest deals",
            attributes: [.font: UIFont(name: "Futura-Medium", size: 12)!, .foregroundColor : UIColor.white]
        )
        let attributedTitle2 = NSAttributedString(
            string: "Celebrate our 3rd birthday with us and save up to 60% this week",
            attributes: [.font: UIFont(name: "Futura-Medium", size: 12)!, .foregroundColor : UIColor.white]
        )
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 36))
        label.textAlignment = .center
        label.attributedText = attributedTitle
        
        //updating text every 5 secs
        var index = 0
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) {_ in
            if index == 0 {
                UIView.animate(withDuration: 1) {
                    label.alpha = 0
                    label.attributedText = attributedTitle1
                    label.alpha = 1
                    index += 1
                }
            } else if index == 1{
                UIView.animate(withDuration: 1) {
                    label.alpha = 0
                    label.attributedText = attributedTitle2
                    label.alpha = 1
                    index += 1
                }
            } else if index == 2{
                UIView.animate(withDuration: 1) {
                    label.alpha = 0
                    label.attributedText = attributedTitle
                    label.alpha = 1
                    index = 0
                }
            }
        }
        
        view.addSubview(label)
        
        stack.addArrangedSubview(view)
        stack.setCustomSpacing(0, after: view)
        
        view.heightAnchor.constraint(equalToConstant: 36).isActive = true
        view.leftAnchor.constraint(equalTo: stack.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: stack.rightAnchor).isActive = true
    }
    
    static func addCollectionBanner(to stack: UIStackView, tap: UITapGestureRecognizer){
        let imageView = UIImageView()
        imageView.image = UIImage(named: "collectionBanner")
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.addGestureRecognizer(tap)
        
        stack.addArrangedSubview(imageView)
        imageView.leftAnchor.constraint(equalTo: stack.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: stack.rightAnchor).isActive = true
    }
    
    static func addGenderBanner(to stack: UIStackView){
        let genderStack = UIStackView()
        genderStack.axis = .horizontal
        genderStack.spacing = 16
        genderStack.translatesAutoresizingMaskIntoConstraints = false
        genderStack.distribution = .fillEqually
        
        let menBannerView = UIImageView()
        menBannerView.image = UIImage(named: "menBanner")
        let womenBannerView = UIImageView()
        womenBannerView.image = UIImage(named: "womenBanner")
        
        genderStack.addArrangedSubview(menBannerView)
        genderStack.addArrangedSubview(womenBannerView)
        
        stack.addArrangedSubview(genderStack)
        stack.setCustomSpacing(24, after: genderStack)
        
        genderStack.leftAnchor.constraint(equalTo: stack.leftAnchor, constant: 16).isActive = true
        genderStack.rightAnchor.constraint(equalTo: stack.rightAnchor, constant: -16).isActive = true
    }
    
    static func addSpotlightBanner(to stack: UIStackView, using imageName: String){
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        
        stack.addArrangedSubview(imageView)
        
        imageView.leftAnchor.constraint(equalTo: stack.leftAnchor, constant: 16).isActive = true
        imageView.rightAnchor.constraint(equalTo: stack.rightAnchor, constant: -16).isActive = true
    }
}
