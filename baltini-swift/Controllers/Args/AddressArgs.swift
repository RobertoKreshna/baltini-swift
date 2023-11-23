//
//  AddressArgs.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 30/10/23.
//

import Foundation
import UIKit

class AddressArgs {
    var firstName: String
    var lastName: String
    var company: String?
    var address1: String
    var address2: String?
    var city: String
    var country: String
    var province: String
    var zipCode: String
    var phoneNumber: String
    
    init(firstName: String, lastName: String, company: String? = nil, address1: String, address2: String? = nil, city: String, country: String, province: String, zipCode: String, phoneNumber: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.company = company
        self.address1 = address1
        self.address2 = address2
        self.city = city
        self.country = country
        self.province = province
        self.zipCode = zipCode
        self.phoneNumber = phoneNumber
    }
    
    static func initFromAddEditAddress(from stack: UIStackView) -> AddressArgs{
        //get all textfield
        let firstNameStack = stack.arrangedSubviews[1] as! UIStackView
        let firstNameTextfield = firstNameStack.arrangedSubviews[1] as! UITextField
        let lastNameStack = stack.arrangedSubviews[2] as! UIStackView
        let lastNameTextfield = lastNameStack.arrangedSubviews[1] as! UITextField
        let companyStack = stack.arrangedSubviews[3] as! UIStackView
        let companyTextfield = companyStack.arrangedSubviews[1] as! UITextField
        let address1Stack = stack.arrangedSubviews[4] as! UIStackView
        let address1Textfield = address1Stack.arrangedSubviews[1] as! UITextField
        let address2Stack = stack.arrangedSubviews[5] as! UIStackView
        let address2Textfield = address2Stack.arrangedSubviews[1] as! UITextField
        let cityStack = stack.arrangedSubviews[6] as! UIStackView
        let cityTextfield = cityStack.arrangedSubviews[1] as! UITextField
        let countryStack = stack.arrangedSubviews[7] as! UIStackView
        let countryTextfield = countryStack.arrangedSubviews[1] as! UITextField
        let provinceStack = stack.arrangedSubviews[8] as! UIStackView
        let provinceTextfield = provinceStack.arrangedSubviews[1] as! UITextField
        let zipStack = stack.arrangedSubviews[9] as! UIStackView
        let zipCodeTextfield = zipStack.arrangedSubviews[1] as! UITextField
        let phoneStack = stack.arrangedSubviews[10] as! UIStackView
        let phoneNumberTextfield = phoneStack.arrangedSubviews[1] as! UITextField
        
        let addressArgs = AddressArgs(
            firstName: firstNameTextfield.text!,
            lastName: lastNameTextfield.text!,
            company: companyTextfield.text,
            address1: address1Textfield.text!,
            address2: address2Textfield.text,
            city: cityTextfield.text!,
            country: countryTextfield.text!,
            province: provinceTextfield.text!,
            zipCode: zipCodeTextfield.text!,
            phoneNumber: phoneNumberTextfield.text!
        )
        
        return addressArgs
    }
    
    static func initFromCheckout(from stack: UIStackView, hasAccount: Bool) -> AddressArgs {
        let addressArgs: AddressArgs = hasAccount ? initCheckoutHasAccount(from: stack) : initCheckoutNoAccount(from: stack)
        return addressArgs
    }
        
    private static func initCheckoutHasAccount(from stack: UIStackView) -> AddressArgs {
        let firstNameStack = stack.arrangedSubviews[3] as! UIStackView
        let firstNameTextfield = firstNameStack.arrangedSubviews[1] as! UITextField
        let lastNameStack = stack.arrangedSubviews[4] as! UIStackView
        let lastNameTextfield = lastNameStack.arrangedSubviews[1] as! UITextField
        let companyStack = stack.arrangedSubviews[5] as! UIStackView
        let companyTextfield = companyStack.arrangedSubviews[1] as! UITextField
        let address1Stack = stack.arrangedSubviews[6] as! UIStackView
        let address1Textfield = address1Stack.arrangedSubviews[1] as! UITextField
        let address2Stack = stack.arrangedSubviews[7] as! UIStackView
        let address2Textfield = address2Stack.arrangedSubviews[1] as! UITextField
        let cityStack = stack.arrangedSubviews[8] as! UIStackView
        let cityTextfield = cityStack.arrangedSubviews[1] as! UITextField
        let countryStack = stack.arrangedSubviews[9] as! UIStackView
        let countryTextfield = countryStack.arrangedSubviews[1] as! UITextField
        let provinceStack = stack.arrangedSubviews[10] as! UIStackView
        let provinceTextfield = provinceStack.arrangedSubviews[1] as! UITextField
        let zipStack = stack.arrangedSubviews[11] as! UIStackView
        let zipCodeTextfield = zipStack.arrangedSubviews[1] as! UITextField
        let phoneStack = stack.arrangedSubviews[12] as! UIStackView
        let phoneNumberTextfield = phoneStack.arrangedSubviews[1] as! UITextField
        
        let addressArgs = AddressArgs(
            firstName: firstNameTextfield.text!,
            lastName: lastNameTextfield.text!,
            company: companyTextfield.text,
            address1: address1Textfield.text!,
            address2: address2Textfield.text,
            city: cityTextfield.text!,
            country: countryTextfield.text!,
            province: provinceTextfield.text!,
            zipCode: zipCodeTextfield.text!,
            phoneNumber: phoneNumberTextfield.text!
        )
        
        return addressArgs
    }
    
    private static func initCheckoutNoAccount(from stack: UIStackView) -> AddressArgs {
        let firstNameStack = stack.arrangedSubviews[2] as! UIStackView
        let firstNameTextfield = firstNameStack.arrangedSubviews[1] as! UITextField
        let lastNameStack = stack.arrangedSubviews[3] as! UIStackView
        let lastNameTextfield = lastNameStack.arrangedSubviews[1] as! UITextField
        let companyStack = stack.arrangedSubviews[4] as! UIStackView
        let companyTextfield = companyStack.arrangedSubviews[1] as! UITextField
        let address1Stack = stack.arrangedSubviews[5] as! UIStackView
        let address1Textfield = address1Stack.arrangedSubviews[1] as! UITextField
        let address2Stack = stack.arrangedSubviews[6] as! UIStackView
        let address2Textfield = address2Stack.arrangedSubviews[1] as! UITextField
        let cityStack = stack.arrangedSubviews[7] as! UIStackView
        let cityTextfield = cityStack.arrangedSubviews[1] as! UITextField
        let countryStack = stack.arrangedSubviews[8] as! UIStackView
        let countryTextfield = countryStack.arrangedSubviews[1] as! UITextField
        let provinceStack = stack.arrangedSubviews[9] as! UIStackView
        let provinceTextfield = provinceStack.arrangedSubviews[1] as! UITextField
        let zipStack = stack.arrangedSubviews[10] as! UIStackView
        let zipCodeTextfield = zipStack.arrangedSubviews[1] as! UITextField
        let phoneStack = stack.arrangedSubviews[11] as! UIStackView
        let phoneNumberTextfield = phoneStack.arrangedSubviews[1] as! UITextField
        
        let addressArgs = AddressArgs(
            firstName: firstNameTextfield.text!,
            lastName: lastNameTextfield.text!,
            company: companyTextfield.text,
            address1: address1Textfield.text!,
            address2: address2Textfield.text,
            city: cityTextfield.text!,
            country: countryTextfield.text!,
            province: provinceTextfield.text!,
            zipCode: zipCodeTextfield.text!,
            phoneNumber: phoneNumberTextfield.text!
        )
        
        return addressArgs
    }
}
