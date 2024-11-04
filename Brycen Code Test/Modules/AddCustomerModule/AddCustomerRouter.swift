//
//  AddCustomerRouter.swift
//  Brycen Code Test
//
//  Created by Win Htun Oo on 04/11/2024.
//

import UIKit

protocol AddCustomerRouterProtocol {
    static func createModule(firstName: String?, lastName: String?, phoneNumber: String?, email:String?, address: String?) -> UIViewController
}

class AddCustomerRouter: AddCustomerRouterProtocol {
    static func createModule(firstName: String?, lastName: String?, phoneNumber: String?, email:String?, address: String?) -> UIViewController {
        let view = AddCustomerViewController(nibName: "AddCustomerViewController", bundle: nil)
        view.firstName = firstName
        view.lastName = lastName
        view.phoneNumber = phoneNumber
        view.email = email
        view.address = address
        return view
    }
}
