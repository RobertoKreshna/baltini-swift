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
        let firstNameTextfield = stack.arrangedSubviews[2] as! UITextField
        let lastNameTextfield = stack.arrangedSubviews[5] as! UITextField
        let companyTextfield = stack.arrangedSubviews[8] as! UITextField
        let address1Textfield = stack.arrangedSubviews[11] as! UITextField
        let address2Textfield = stack.arrangedSubviews[14] as! UITextField
        let cityTextfield = stack.arrangedSubviews[17] as! UITextField
        let countryTextfield = stack.arrangedSubviews[20] as! UITextField
        let provinceTextfield = stack.arrangedSubviews[23] as! UITextField
        let zipCodeTextfield = stack.arrangedSubviews[26] as! UITextField
        let phoneNumberTextfield = stack.arrangedSubviews[29] as! UITextField
        
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
