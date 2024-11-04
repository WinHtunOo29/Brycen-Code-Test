//
//  CustomerViewController.swift
//  Brycen Code Test
//
//  Created by Win Htun Oo on 01/11/2024.
//

import Foundation
import UIKit
import CoreData

class CustomerViewController: UIViewController {
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cancelSearchBtn: UIButton!
    @IBOutlet weak var addCustomerBtn: UIButton!
    @IBOutlet weak var customerListTableView: UITableView!
    
    var customers : [Customer] = []
    var isCellExpanded = false
    var interactor: CustomerInteractorProtocol?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupVIP()
        self.interactor?.fetchCustomers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIs()
    }
    
    private func setupUIs() {
        self.customerListTableView.dataSource = self
        self.customerListTableView.delegate = self
        
        self.customerListTableView.register(UINib(nibName: "CustomerTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomerTableViewCell")

        searchView.layer.cornerRadius = 8
        searchView.clipsToBounds = true
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                  for: .editingChanged)
        cancelSearchBtn.isHidden = true
        cancelSearchBtn.addTarget(self, action: #selector(clearTextField), for: .touchUpInside)
    }
    
    @IBAction func addNewCustomer(_ sender: Any) {
        let vc = AddCustomerRouter.createModule(firstName: "", lastName: "", phoneNumber: "", email: "", address: "")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func clearTextField(_ sender: UIButton) {
        searchTextField.text = ""
        searchTextField.endEditing(true)
        cancelSearchBtn.isHidden = true
        self.interactor?.fetchCustomers()
    }
    
    @objc func editBtnTapped(_ sender: UIButton) {
        let index = sender.tag
        let customer = customers[index]
        let vc = AddCustomerRouter.createModule(firstName: customer.firstName ?? "", lastName: customer.lastName ?? "", phoneNumber: customer.phoneNumber ?? "", email: customer.email ?? "", address: customer.address ?? "")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func customersFetched(_ customers: [Customer]) {
        self.customers = customers
        self.customerListTableView.reloadData()
    }
    
    private func setupVIP() {
        let interactor = CustomerInteractor()
        let presenter = CustomerPresenter()
        
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.view = self
    }
}

extension CustomerViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text == nil || textField.text == "" {
            self.interactor?.fetchCustomers()
            cancelSearchBtn.isHidden = true
        } else {
            self.interactor?.searchCustomerByNameOrCarNumber(searchText: textField.text ?? "")
            cancelSearchBtn.isHidden = false
        }
    }
}

extension CustomerViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerTableViewCell", for: indexPath) as! CustomerTableViewCell
        cell.selectionStyle = .none
        cell.customerNameLabel.text = (customers[indexPath.row].firstName ?? "") + " " + (customers[indexPath.row].lastName ?? "")
        cell.editBtn.tag = indexPath.row
        cell.editBtn.addTarget(self, action: #selector(editBtnTapped), for: .touchUpInside)
        if let cars = customers[indexPath.row].cars as? Set<Car> {
            cell.car = Array(cars)
        }
        cell.isExpanded = isCellExpanded
        if !cell.isExpanded || cell.car.isEmpty {
            cell.carTableViewHeightConstraint.constant = 0
        } else {
            cell.carTableViewHeightConstraint.constant = CGFloat(cell.car.count * 65)
        }
        cell.carTableView.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let context = CoreDataStack.shared.context
            context.delete(customers[indexPath.row])
            customers.remove(at: indexPath.row)
            do {
                try context.save()
            } catch {
                print("Failed to save customer: \(error)")
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
                    
        default: return
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isCellExpanded.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
