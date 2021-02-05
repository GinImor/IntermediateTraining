//
//  EmployeesController.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 2/3/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit
import CoreData

class EmployeesController: FetchedResultsTableViewController<Employee> {
  
  // MARK: - Override Superclass Properties and Functions
  
  override var cellID: String { ID.employeeCell }
  override var sortKeys: [String] { [#keyPath(Employee.title), #keyPath(Employee.name)] }
  override var sectionNameKeyPath: String? { sortKeys[0] }
  override var predicate: NSPredicate? { NSPredicate(format: "company = %@", company) }
  override var managedObjectContext: NSManagedObjectContext {
    CompanyEmployeeCoreDataStack.shared.mainContext
  }
  override func configure(cell: UITableViewCell, for indexPath: IndexPath) {
    let employee = fetchedResultsController.object(at: indexPath)
    
    if let birthday = employee.info?.birthday {
      let birthdayString = DateFormatter.m3D2Y4.string(from: birthday)
      cell.textLabel?.text = "\(employee.name ?? "")    \(birthdayString)"
    }  else {
      cell.textLabel?.text = employee.name
    }
    
    cell.backgroundColor = .tealColor
  }
  
  var company: Company!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    populateContentToNavigationBar()
    setupTableView()
    loadData()
  }
  
  private func populateContentToNavigationBar() {
    navigationItem.title = company.name
    setupAddBarButton()
  }
  
  private func setupTableView() {
    tableView.backgroundColor = .darkBlue
    tableView.separatorColor = .white
    tableView.rowHeight = 50
    tableView.sectionHeaderHeight = 50
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
  
}

extension EmployeesController {
  
  // MARK: - Table View Delegate
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let label = IndentedLabel()
    label.backgroundColor = .lightBlue
    
    if let sectionIndexString = fetchedResultsController.sections?[section].name,
      let sectionIndex = Int(sectionIndexString),
      sectionIndex < EmployeeTitle.allNames.count {
      label.text = EmployeeTitle.allNames[sectionIndex]
    } else {
      label.text = "Unknow Title"
    }
    
    return label
  }

}
