//
//  CustomerPresenter.swift
//  Brycen Code Test
//
//  Created by Win Htun Oo on 04/11/2024.
//

import Foundation

protocol CustomerPresenterProtocol {
    var view: CustomerViewController? { get }
    func presentCustomer(customers: [Customer])
}

class CustomerPresenter: CustomerPresenterProtocol {
    var view: CustomerViewController?
    
    func presentCustomer(customers: [Customer]) {
        self.view?.customersFetched(customers)
    }
}
