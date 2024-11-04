//
//  AddCarInteractor.swift
//  Brycen Code Test
//
//  Created by Win Htun Oo on 04/11/2024.
//

import Foundation
import CoreData

protocol AddCarInteractorProtocol {
    var presenter: AddCarPresenterProtocol? { get set }
    func saveCustomer(firstName: String, lastName: String, phoneNumber: String, email: String?, address: String?, carData: [(String, String, String)])
}

class AddCarInteractor: AddCarInteractorProtocol {
    let coreDataStackContext = CoreDataStack.shared.context
    var presenter: AddCarPresenterProtocol?

    func saveCustomer(firstName: String, lastName: String, phoneNumber: String, email: String?, address: String?, carData: [(String, String, String)]) {
        let fetchRequest: NSFetchRequest<Customer> = Customer.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "firstName == %@ AND lastName == %@", firstName, lastName)
        
        do {
            let results = try coreDataStackContext.fetch(fetchRequest)
            var customer: Customer
            
            if let existingCustomer = results.first {
                customer = existingCustomer
            } else {
                customer = Customer(context: coreDataStackContext)
                customer.firstName = firstName
                customer.lastName = lastName
                customer.phoneNumber = phoneNumber
                customer.email = email
                customer.address = address
            }

            for (carNumber, carType, manufacturer) in carData {
                let car = Car(context: coreDataStackContext)
                car.carNumber = carNumber
                car.carType = carType
                car.manufacturer = manufacturer
                car.customer = customer
                customer.mutableSetValue(forKey: "cars").add(car)
            }

            try coreDataStackContext.save()
            self.presenter?.presentDoneAdd()
        } catch {
            print("Failed to save customer: \(error)")
        }
    }
}
