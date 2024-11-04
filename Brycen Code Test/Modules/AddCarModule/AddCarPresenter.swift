//
//  AddCarPresenter.swift
//  Brycen Code Test
//
//  Created by Win Htun Oo on 04/11/2024.
//

import Foundation

protocol AddCarPresenterProtocol {
    var view: AddCarViewController? {get}
    
    func presentDoneAdd()
}

class AddCarPresenter: AddCarPresenterProtocol {
    var view: AddCarViewController?
    
    func presentDoneAdd() {
        self.view?.goBackToCustomerListView()
    }
}
