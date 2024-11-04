//
//  AddCustomerViewController.swift
//  Brycen Code Test
//
//  Created by Win Htun Oo on 04/11/2024.
//

import Foundation
import UIKit

class AddCustomerViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    var firstName, lastName, phoneNumber, email, address: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.phoneNumberTextField.delegate = self
        self.emailTextField.delegate = self
        self.addressTextField.delegate = self
        
        self.firstNameTextField.text = self.firstName
        self.lastNameTextField.text = self.lastName
        self.phoneNumberTextField.text = self.phoneNumber
        self.emailTextField.text = self.email
        self.addressTextField.text = self.address
        
        self.firstNameTextField.autocorrectionType = .no
        self.lastNameTextField.autocorrectionType = .no
        self.emailTextField.autocorrectionType = .no
        self.addressTextField.autocorrectionType = .no
        
        self.phoneNumberTextField.keyboardType = .numberPad
    }
    
    @IBAction func goToAddCarView(_ sender: Any) {
        if firstNameTextField.text != "" && lastNameTextField.text != "" && phoneNumberTextField.text != "" {
            if !(ValidateCustomerData.isValidPhoneNumber(phone: phoneNumberTextField.text ?? "")) {
                AlertDialogBox.showAlertDialog(on: self, title: "Invalid Phone Number", message: "Please enter a valid phone number")
            } else if !(emailTextField == nil || emailTextField.text == "") {
                if !(ValidateCustomerData.isValidEmail(emailTextField.text ?? "")) {
                    AlertDialogBox.showAlertDialog(on: self, title: "Invalid Email", message: "Please enter a valid email")
                } else {
                    let vc = AddCarRouter.createModule(firstName: firstNameTextField.text ?? "", lastName: lastNameTextField.text ?? "", phoneNumber: phoneNumberTextField.text ?? "", email: emailTextField.text, address: addressTextField.text)
                    navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                let vc = AddCarRouter.createModule(firstName: firstNameTextField.text ?? "", lastName: lastNameTextField.text ?? "", phoneNumber: phoneNumberTextField.text ?? "", email: emailTextField.text, address: addressTextField.text)
                navigationController?.pushViewController(vc, animated: true)
            }
        } else if firstNameTextField.text == nil || firstNameTextField.text == "" {
            AlertDialogBox.showAlertDialog(on: self, title: "Enter First Name", message: "First name is required")
        } else if lastNameTextField.text == nil || lastNameTextField.text == "" {
            AlertDialogBox.showAlertDialog(on: self, title: "Enter Last Name", message: "Last name is required")
        } else if phoneNumberTextField.text == nil || phoneNumberTextField.text == "" {
            AlertDialogBox.showAlertDialog(on: self, title: "Enter Phone Number", message: "Phone number is required")
        }
    }
}

extension AddCustomerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneNumberTextField {
            let maxLength = 11
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            return newString.count <= maxLength
        } else {
            return true
        }
    }
}
