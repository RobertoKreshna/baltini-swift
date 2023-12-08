//
//  ItemTapped.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 07/11/23.
//

import UIKit
import DropDown

class ItemTapped: UITapGestureRecognizer {
    let id: String
    
    init(target: Any?, action: Selector?, id: String) {
        self.id = id
        super.init(target: target, action: action)
    }
}

class OrderTapped: UITapGestureRecognizer {
    let currentOrder: Order
    
    init(target: Any?, action: Selector?, currentOrder: Order) {
        self.currentOrder = currentOrder
        super.init(target: target, action: action)
    }
}

class sortTapped: UITapGestureRecognizer {
    let sortDropdown: DropDown
    
    init(target: Any?, action: Selector?, dropdown: DropDown) {
        self.sortDropdown = dropdown
        super.init(target: target, action: action)
    }
}

class FilterRowTapped: UITapGestureRecognizer {
    let imageView: UIImageView
    
    init(target: Any?, action: Selector?, imageView: UIImageView) {
        self.imageView = imageView
        super.init(target: target, action: action)
    }
}

class MagazineTapped: UITapGestureRecognizer {
    let magazine: Magazine
    
    init(target: Any?, action: Selector?, magazine: Magazine) {
        self.magazine = magazine
        super.init(target: target, action: action)
    }
}
