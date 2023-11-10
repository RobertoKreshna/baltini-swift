//
//  CustomSeparator.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 10/11/23.
//

import UIKit

class CustomSeparator {
    static func createHorizontalLine(width: CGFloat, color: UIColor) -> UIView{
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        view.heightAnchor.constraint(equalToConstant: width).isActive = true
        return view
    }
}
