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
    let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
    
    do {
      companies = try CoreDataStack.shared.mainContext.fetch(fetchRequest)
      tableView.reloadData()
    } catch let nserror as NSError {
      fatalError("\(nserror), \(nserror.userInfo)")
    }
  }
  
  // MARK: - Configure Navigation Bar
  
  private func configureNavigationBar() {
    populateContentToNavigationBar()
  }
  
  private func populateContentToNavigationBar() {
    navigationItem.title = "Companies"
    // withRenderingMode(.alwaysOriginal) prevent default coloring, eg blue for bar button
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal),
                                                        style: .plain, target: self, action: #selector(addCompany))
  }
  
  @objc func addCompany() {
    let addCompanyController = AddCompanyController()
    addCompanyController.delegate = self
    
    let addCompanyNavigationController = UINavigationController(rootViewController: addCompanyController)
    present(addCompanyNavigationController, animated: true)
  }
  
  
  // MARK: - Set Up Table View
  
  private func setupTableView() {
    tableView.backgroundColor = .darkBlue
    tableView.separatorColor = .white
    // void the table footer view so that no line appear at the bottom
    tableView.tableFooterView = UIView()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: ID.cell)
  }
  
  // MARK: - Table View Delegate
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView()
    headerView.backgroundColor = .lightBlue
    return headerView
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
  override func tableView(
    _ tableView: UITableView,
    trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
  ) -> UISwipeActionsConfiguration? {
    let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] (_, _, completion) in
      let company = self.companies[indexPath.row]
      self.companies.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
      
      CoreDataStack.shared.mainContext.delete(company)
      CoreDataStack.shared.saveContext()
      
      completion(true)
    }
    
    let editAction = UIContextualAction(style: .normal, title: "Edit") { [unowned self] (_, _, completion) in
      
      
      
      
      
      completion(true)
    }
    
    
    return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
  }
  
  // MARK: - Table View Data Source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return companies.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ID.cell, for: indexPath)
    let company = companies[indexPath.row]
    
    cell.textLabel?.text = company.name
    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    cell.textLabel?.textColor = .white
    cell.backgroundColor = .tealColor
    return cell
  }
  
}

extension CompanyViewController: AddCompanyDelegate {
  
  func didAdd(company: Company) {
    let indexPath = IndexPath(row: companies.count, section: 0)
    
    companies.append(company)
    tableView.insertRows(at: [indexPath], with: .automatic)
  }
  
}
