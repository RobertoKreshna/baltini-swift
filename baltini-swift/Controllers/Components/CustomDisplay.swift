//
//  CustomDisplay.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 30/10/23.
//

import UIKit

class CustomDisplay {
    
    func createDivider(color: UIColor, width: CGFloat) -> UIView{
        let view = UIView()
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-32, height: width)
        view.layer.addSublayer(border)
        return view
    }
    
    static func getAddressDisplay(address: Address, deletePressed: UIAction, editPressed: UIAction) -> UIView {
        let blueprint = CustomDisplay()
        
        let addressDisplayStack = UIStackView()
        addressDisplayStack.axis = .vertical
        
        let nameAndDeleteRow = blueprint.createNameAndDeleteAddressRow(
            firstName: address.firstName!,
            lastName: address.lastName!,
            deletePressed: deletePressed
        )
        let addressDetailRow = blueprint.createAddressDetailRow(
            address1: address.address1!, 
            address2: address.address2!,
            city: address.city!, 
            province: address.province!,
            country: address.country!
        )
        let editButton = blueprint.createEditAddressButton(editPressed: editPressed)
        
        let divider = blueprint.createDivider(color: .brandGray, width: 2)
        
        addressDisplayStack.addArrangedSubview(nameAndDeleteRow)
        addressDisplayStack.setCustomSpacing(4, after: nameAndDeleteRow)
        addressDisplayStack.addArrangedSubview(addressDetailRow)
        addressDisplayStack.setCustomSpacing(16, after: addressDetailRow)
        addressDisplayStack.addArrangedSubview(editButton)
        addressDisplayStack.setCustomSpacing(24, after: editButton)
        addressDisplayStack.addArrangedSubview(divider)
        addressDisplayStack.setCustomSpacing(24, after: divider)
        
        nameAndDeleteRow.widthAnchor.constraint(equalTo: addressDisplayStack.widthAnchor).isActive = true
        addressDetailRow.widthAnchor.constraint(equalTo: addressDisplayStack.widthAnchor).isActive = true
        
        return addressDisplayStack
    }
    
    func createNameAndDeleteAddressRow(firstName: String, lastName: String, deletePressed: UIAction) -> UIStackView {
        let nameAndDeleteRow = UIStackView()
        nameAndDeleteRow.axis = .horizontal
        
        let name = NSAttributedString(
            string: "\(firstName) \(lastName)".uppercased(),
            attributes: [.font : UIFont(name: "Futura-Medium", size: 14)!]
        )
        let nameLabel = UILabel()
        nameLabel.attributedText = name
        
        let deleteButton = UIButton(type: .system)
        deleteButton.setImage(UIImage(named: "icDelete"), for: .normal)
        deleteButton.addAction(deletePressed, for: .touchUpInside)
        deleteButton.tintColor = .systemRed
        
        nameAndDeleteRow.addArrangedSubview(nameLabel)
        nameAndDeleteRow.addArrangedSubview(deleteButton)
        
        return nameAndDeleteRow
    }
    
    func createAddressDetailRow(address1: String, address2: String, city: String, province: String, country: String) -> UIStackView {
        let addressDetailRow = UIStackView()
        addressDetailRow.axis = .horizontal
        
        let string = constructAddressDetailString(address1, address2, city, province, country)
        let addressDetail = NSAttributedString(
            string: string,
            attributes: [.font : UIFont(name: "Futura-Medium", size: 13)!]
        )
        
        let addressDetailLabel = UILabel()
        addressDetailLabel.attributedText = addressDetail
        addressDetailLabel.numberOfLines = 0
        
        addressDetailRow.addArrangedSubview(addressDetailLabel)
        
        return addressDetailRow
    }
    
    func constructAddressDetailString( _ address1: String, _ address2: String, _ city: String, _ province: String, _ country : String) -> String {
        return address2.isEmpty ? "\(address1), \(city), \(province), \(country)" : "\(address1), \(address2), \(city), \(province), \(country)"
    }
    
    func createEditAddressButton(editPressed: UIAction) -> UIButton{
        let button = CustomButton.createWhiteButton(
            title: "EDIT ADDRESS",
            action: editPressed
        )
        return button
    }
  
}
