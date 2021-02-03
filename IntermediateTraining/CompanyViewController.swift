//
//  ViewController.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 1/30/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit
import CoreData

class CompanyViewController: UITableViewController {

  enum ID {
    static let cell = "CellID"
  }
  
  var companies: [Company] = []
  
  // MARK: - View Controller Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureNavigationBar()
    setupTableView()
    loadData()
  }

  
  // MARK: - Load Data
  
  private func loadData() {
    CompanyCoreDataStack.shared.loadComapnies { (result) in
      switch result {
      case .success(let companies):
        self.companies = companies
        self.tableView.reloadData()
      case .failure(let error):
        print("can't load companies", error)
      }
    }
  }
  
  // MARK: - Configure Navigation Bar
  
  private func configureNavigationBar() {
    populateContentToNavigationBar()
  }
  
  private func populateContentToNavigationBar() {
    navigationItem.title = "Companies"
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(reset))
    // withRenderingMode(.alwaysOriginal) prevent default coloring, eg blue for bar button
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal),
                                                        style: .plain, target: self, action: #selector(addCompany))

  }
  
  @objc private func reset() {
    CompanyCoreDataStack.shared.removeAllCompanies { (result) in
      switch result {
      case .success:
        let indexPathsToRemove = (0..<companies.count).map { IndexPath(row: $0, section: 0) }
        companies.removeAll()
        tableView.deleteRows(at: indexPathsToRemove, with: .top)
      case .failure(let error):
        print("can't reset companies", error)
      }
    }
  }
  
  @objc private func addCompany() {
    let addCompanyController = AddCompanyController()
    addCompanyController.delegate = self
    
    let addCompanyNavigationController =
      lightStatusBarNavigationController(rootViewController: addCompanyController)
    present(addCompanyNavigationController, animated: true)
  }
  
  
  // MARK: - Set Up Table View
  
  private func setupTableView() {
    tableView.backgroundColor = .darkBlue
    tableView.separatorColor = .white
    // void the table footer view so that no line appear at the bottom
    tableView.tableFooterView = UIView()
//    tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    tableView.register(CompanyCell.self, forCellReuseIdentifier: ID.cell)
  }
  
}

