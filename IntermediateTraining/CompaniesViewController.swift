//
//  ViewController.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 1/30/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit
import CoreData

class CompaniesViewController: CompanyEmployeeController<Company> {

  // MARK: - Override Superclass Properties and Functions
  
  override var cellID: String { ID.companyCell }
  override var sortKeys: [String] { [#keyPath(Company.name)] }
  
  override func configure(cell: UITableViewCell, for indexPath: IndexPath) {
    if let cell = cell as? CompanyCell {
      cell.company = fetchedResultsController?.object(at: indexPath)
    }
  }
  
  
  // MARK: - Override CompanyEmployeeController Properties and Functions
  
  override var navigationTitle: String? { "Companies" }
  override var cellClass: AnyClass? { CompanyCell.self }
  
  
  // MARK: - View Controller Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupRefreshControl()
  }

  private func setupRefreshControl() {
    refreshControl = UIRefreshControl()
    
    refreshControl?.tintColor = .white
    refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
  }
  
  @objc func refresh() {
    Service.downloadCompanies { self.refreshControl?.endRefreshing() }
  }
  
  @objc override func reset() {
    CompanyEmployeeCoreDataStack.shared.removeAllCompanies {result in}
  }
  
  @objc override func add() {
    let addCompanyController = AddCompanyController()
//    addCompanyController.delegate = self
    
    let addCompanyNavigationController =
      lightStatusBarNavigationController(rootViewController: addCompanyController)
    present(addCompanyNavigationController, animated: true)
  }
  
}


extension CompaniesViewController {
  
   // MARK: - Table View Delegate
   
   override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
     let headerView = UIView()
     headerView.backgroundColor = .lightBlue
     return headerView
   }
 
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     let employeesController = EmployeesController()
     employeesController.company = fetchedResultsController.fetchedObjects?[indexPath.row]
     navigationController?.pushViewController(employeesController, animated: true)
   }
}
