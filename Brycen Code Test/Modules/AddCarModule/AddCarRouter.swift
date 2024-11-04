//
//  AddCarRouter.swift
//  Brycen Code Test
//
//  Created by Win Htun Oo on 04/11/2024.
//

import UIKit

protocol AddCarRouterProtocol {
    static func createModule(firstName: String, lastName: String, phoneNumber: String, email: String?, address: String?) -> UIViewController
}

class AddCarRouter: AddCarRouterProtocol {
    static func createModule(firstName: String, lastName: String, phoneNumber: String, email: String?, address: String?) -> UIViewController {
        let view = AddCarViewController(nibName: "AddCarViewController", bundle: nil)
        let presenter = AddCarPresenter()
        let interactor = AddCarInteractor()
        view.interactor = interactor
        presenter.view = view
        interactor.presenter = presenter
        view.firstName = firstName
        view.lastName = lastName
        view.phoneNumber = phoneNumber
        view.email = email
        view.address = address
        return view
    }
}
