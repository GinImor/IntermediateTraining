//
//  EmployeesController.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 2/3/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit

class EmployeesController: UITableViewController {
  
  var company: Company!
  var employees: [[Employee]] = []
  var observerAddOrUpdate: NSObjectProtocol?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    populateContentToNavigationBar()
    loadData() // load data need to precede set up table view
    setupTableView()
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
    guard let unsortedEmployees = company.employees?.allObjects as? [Employee] else { return }
    
    employees = []
    EmployeeTitle.allNames.forEach { title in
      employees.append(unsortedEmployees.filter {$0.title == title})
    }
  }
  
  private func populateContentToNavigationBar() {
    navigationItem.title = company.name
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
    addEmployeeController.company = company
    
    let addEmployeeNavigationController =
      UINavigationController(rootViewController: addEmployeeController)
    present(addEmployeeNavigationController, animated: true)
  }
  
  private func registerNotification() {
    observerAddOrUpdate = NotificationCenter.default.addObserver(forName: .didAddEmployee, object: nil, queue: nil) { (notification) in
      guard let employee = notification.userInfo?["employee"] as? Employee,
        let section = EmployeeTitle.allNames.firstIndex(of: employee.title!) else { return }
      
      let indexPath = IndexPath(row: self.employees[section].count, section: section)
      self.employees[section].append(employee)
      self.tableView.insertRows(at: [indexPath], with: .middle)
    }
  }
  
  private func unregisterNOtification() {
    observerAddOrUpdate = nil
  }
  
}

extension EmployeesController {
  
  // MARK: - Table View Delegate
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let label = IndentedLabel()
    
    label.backgroundColor = .lightBlue
    label.text = EmployeeTitle.allNames[section]
    return label
  }
  
  // MARK: - Table View Data Source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return EmployeeTitle.allNames.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return employees[section].count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ID.employeeCell, for: indexPath)
    let employee = employees[indexPath.section][indexPath.row]
    
    if let birthday = employee.info?.birthday {
       let birthdayString = DateFormatter.m3D2Y4.string(from: birthday)
       cell.textLabel?.text = "\(employee.name ?? "")    \(birthdayString)"
    }  else {
      cell.textLabel?.text = employee.name
    }
   
    cell.backgroundColor = .tealColor
    return cell
  }
}
