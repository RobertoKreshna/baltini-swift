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
