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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    populateContentToNavigationBar()
    setupTableView()
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
  }
  
  @objc override func add() {
    let addEmployeeController = AddEmployeeController()
    let addEmployeeNavigationController =
      UINavigationController(rootViewController: addEmployeeController)
    present(addEmployeeNavigationController, animated: true)
  }
  
}
