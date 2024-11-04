//
//  CustomerInteractor.swift
//  Brycen Code Test
//
//  Created by Win Htun Oo on 04/11/2024.
//

import Foundation
import CoreData

protocol CustomerInteractorProtocol {
    var presenter: CustomerPresenterProtocol? { get set }
    func fetchCustomers()
    func searchCustomerByNameOrCarNumber(searchText: String)
}

class CustomerInteractor: CustomerInteractorProtocol {
    var presenter: CustomerPresenterProtocol?
    let context = CoreDataStack.shared.context

    func fetchCustomers() {
        let fetchRequest: NSFetchRequest<Customer> = Customer.fetchRequest()
        do {
            let customers = try context.fetch(fetchRequest)
            self.presenter?.presentCustomer(customers: customers)
        } catch {
            print("Failed to fetch customers: \(error)")
        }
    }
    
    func searchCustomerByNameOrCarNumber(searchText: String) {
        let fetchRequest: NSFetchRequest<Customer> = Customer.fetchRequest()

        let namePredicate = NSPredicate(format: "firstName CONTAINS[cd] %@ OR lastName CONTAINS[cd] %@", searchText, searchText)
        let carPredicate = NSPredicate(format: "ANY cars.carNumber CONTAINS[cd] %@", searchText)

        fetchRequest.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [namePredicate, carPredicate])
        
        do {
            let customers = try context.fetch(fetchRequest)
            self.presenter?.presentCustomer(customers: customers)
        } catch {
            print("Failed to fetch customers: \(error)")
        }
    }
}
