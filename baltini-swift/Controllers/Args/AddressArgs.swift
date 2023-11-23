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
    
    init(from stack: UIStackView){
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
        
        //assign value
        self.firstName = firstNameTextfield.text!
        self.lastName = lastNameTextfield.text!
        self.company = companyTextfield.text
        self.address1 = address1Textfield.text!
        self.address2 = address2Textfield.text
        self.city = cityTextfield.text!
        self.country = countryTextfield.text!
        self.province = provinceTextfield.text!
        self.zipCode = zipCodeTextfield.text!
        self.phoneNumber = phoneNumberTextfield.text!
    }
}
