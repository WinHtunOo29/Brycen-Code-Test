//
//  ValidateCustomerData.swift
//  Brycen Code Test
//
//  Created by Win Htun Oo on 04/11/2024.
//

import Foundation

class ValidateCustomerData {
    static func isValidPhoneNumber(phone: String) -> Bool {
        let phoneRegex = "^[09][0-9]{7,10}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "^(?!.*\\.{2,})[a-zA-Z0-9][a-zA-Z0-9._-]*[a-zA-Z0-9]@[a-zA-Z0-9.-]+[a-zA-Z0-9]+\\.[a-zA-Z]{2,6}$"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
