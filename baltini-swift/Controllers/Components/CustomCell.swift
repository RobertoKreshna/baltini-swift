//
//  CustomCell.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 07/11/23.
//

import UIKit

class ImageCarouselCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * 0.7, height: 390))
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        imageView.center = contentView.center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomCell {
    static func createCategoryCell(title: String, useIcon: Bool, tapped: UITapGestureRecognizer) -> UIStackView{
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        
        let attributedTitle = NSAttributedString(
            string: title,
            attributes: [.font : UIFont(name: "Futura-Medium", size: 14)!, .foregroundColor : UIColor.black]
        )
        
        let label = UILabel()
        label.attributedText = attributedTitle
        
        stack.addArrangedSubview(label)
        if(useIcon){
            let icon = UIImageView(image: UIImage(named: "icRight"))
            stack.addArrangedSubview(icon)
        }
        
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24)
        
        stack.addGestureRecognizer(tapped)
        
        return stack
    }
}
