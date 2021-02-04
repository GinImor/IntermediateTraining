//
//  EmployeesController.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 2/3/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit

class EmployeesController: UITableViewController {
  
  var company: Company?
  
  var employees: [Employee] = []
  
  var observerAddOrUpdate: NSObjectProtocol?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    populateContentToNavigationBar()
    setupTableView()
    loadData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    registerNotification()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    unregisterNOtification()
  }
  
  private func loadData() {
    CompanyEmployeeCoreDataStack.shared.loadEmployees { (result) in
      switch result {
      case .success(let employees):
        self.employees = employees
        self.tableView.reloadData()
      case .failure(let error):
        print("can't load employees", error)
      }
    }
  }
  
  private func populateContentToNavigationBar() {
    navigationItem.title = company?.name
    setupAddBarButton()
  }
  
  private func setupTableView() {
    tableView.backgroundColor = .darkBlue
    tableView.separatorColor = .white
    // void the table footer view so that no line appear at the bottom
    tableView.tableFooterView = UIView()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: ID.employeeCell)
  }
  
  @objc override func add() {
    let addEmployeeController = AddEmployeeController()
    let addEmployeeNavigationController =
      UINavigationController(rootViewController: addEmployeeController)
    present(addEmployeeNavigationController, animated: true)
  }
  
  private func registerNotification() {
    observerAddOrUpdate = NotificationCenter.default.addObserver(forName: .didAddEmployee, object: nil, queue: nil) { (notification) in
      if let employee = notification.userInfo?["employee"] as? Employee {
        self.employees.append(employee)
        self.tableView.reloadData()
      }
    }
  }
  
  private func unregisterNOtification() {
    observerAddOrUpdate = nil
  }
  
}

extension EmployeesController {
  
  // MARK: - Table View Delegate
  
  
  // MARK: - Table View Data Source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return employees.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ID.employeeCell, for: indexPath)
    let employee = employees[indexPath.row]
    
    cell.textLabel?.text = employee.name
    return cell
  }
}
