//
//  AddCarViewController.swift
//  Brycen Code Test
//
//  Created by Win Htun Oo on 04/11/2024.
//

import Foundation
import UIKit

class AddCarViewController: UIViewController {
    
    @IBOutlet weak var carNumberTextField: UITextField!
    @IBOutlet weak var carTypeTextField: UITextField!
    @IBOutlet weak var manufacturerTextField: UITextField!
    
    var interactor: AddCarInteractorProtocol?
    let context = CoreDataStack.shared.persistentContainer.viewContext
    var firstName: String = ""
    var lastName: String = ""
    var phoneNumber: String = ""
    var email: String?
    var address: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.carNumberTextField.keyboardType = .numberPad
    }
    
    @IBAction func addAction(_ sender: Any) {
        if carNumberTextField.text != "" && carTypeTextField.text != "" && manufacturerTextField.text != "" {
            self.interactor?.saveCustomer(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: email ?? "", address: address ?? "", carData: [(carNumberTextField.text ?? "", carTypeTextField.text ?? "", manufacturerTextField.text ?? "")])
        } else {
            AlertDialogBox.showAlertDialog(on: self, title: "All Fields Are Required", message: "Please Insert All Information About Car")
        }
    }
    
    func goBackToCustomerListView() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
