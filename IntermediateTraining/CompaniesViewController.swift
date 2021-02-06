//
//  ViewController.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 1/30/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit
import CoreData

enum ID {
  static let companyCell = "companyCell"
  static let employeeCell = "employeeCell"
}

enum CompanySection {
  case Main
}

class CompaniesViewController: FetchedResultsTableViewController<String, Company> {

  // MARK: - Override Superclass Properties and Functions
  
  override var cellID: String { ID.companyCell }
  override var sortKeys: [String] { [#keyPath(Company.name)] }
//  override var sectionNameKeyPath: String? { sortKeys[0] }
  override var managedObjectContext: NSManagedObjectContext {
    CompanyEmployeeCoreDataStack.shared.mainContext
  }
  override func configure(cell: UITableViewCell, for indexPath: IndexPath) {
    if let cell = cell as? CompanyCell {
      cell.company = fetchedResultsController?.object(at: indexPath)
    }
  }
  
  
  // MARK: - View Controller Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureNavigationBar()
    setupTableView()
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
  
  // MARK: - Configure Navigation Bar
  
  private func configureNavigationBar() {
    populateContentToNavigationBar()
  }
  
  private func populateContentToNavigationBar() {
    navigationItem.title = "Companies"
    setupResetBarButton()
    setupAddBarButton()
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
  
  
  // MARK: - Set Up Table View
  
  private func setupTableView() {
    tableView.backgroundColor = .darkBlue
    tableView.separatorColor = .white
    tableView.rowHeight = 50
    // void the table footer view so that no line appear at the bottom
    tableView.tableFooterView = UIView()
//    tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    tableView.register(CompanyCell.self, forCellReuseIdentifier: ID.companyCell)
  }
  
}

