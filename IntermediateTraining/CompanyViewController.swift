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
  let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM dd, YYYY"
    return dateFormatter
  }()
  
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
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(reset))
    // withRenderingMode(.alwaysOriginal) prevent default coloring, eg blue for bar button
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal),
                                                        style: .plain, target: self, action: #selector(addCompany))

  }
  
  @objc private func reset() {
    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
    
    do {
      try CoreDataStack.shared.mainContext.execute(batchDeleteRequest)
      
      let indexPathsToRemove = (0..<companies.count).map { IndexPath(row: $0, section: 0) }
      companies.removeAll()
      tableView.deleteRows(at: indexPathsToRemove, with: .bottom)
    } catch {
      print("fail to reset", error)
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
  
  override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let label = UILabel()
    
    label.text = "no company"
    label.textColor = .white
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 16)
    
    return label
  }
  
  override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return companies.count == 0 ? 150 : 0
  }
  
  override func tableView(
    _ tableView: UITableView,
    trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
  ) -> UISwipeActionsConfiguration? {
    let company = self.companies[indexPath.row]
    
    let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
      [unowned self] (_, _, completion) in
      self.companies.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
      
      CoreDataStack.shared.mainContext.delete(company)
      CoreDataStack.shared.saveContext()
      
      completion(true)
    }
    
    let editAction = UIContextualAction(style: .normal, title: "Edit") {
      [unowned self] (_, _, completion) in
      let editCompanyController = AddCompanyController()
      editCompanyController.company = company
      editCompanyController.delegate = self
      
      let editCompanyNavigationController =
        lightStatusBarNavigationController(rootViewController: editCompanyController)
      
      self.present(editCompanyNavigationController, animated: true) {
        completion(true)
      }
    }
    
    deleteAction.backgroundColor = .lightRed
    editAction.backgroundColor = .darkBlue
    
    return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
  }
  
  // MARK: - Table View Data Source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return companies.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ID.cell, for: indexPath)
    let company = companies[indexPath.row]
    
    if let name = company.name, let founded = company.founded {
      cell.textLabel?.text = "\(name) - Founded: \(dateFormatter.string(from: founded))"
    } else {
      cell.textLabel?.text = company.name
    }
    
    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    cell.textLabel?.textColor = .white
    cell.backgroundColor = .tealColor
    
    if let imageData = company.imageData {
      cell.imageView?.image = UIImage(data: imageData)
    }
    
    return cell
  }
  
}

extension CompanyViewController: AddCompanyDelegate {
  
  func didAdd(company: Company) {
    let indexPath = IndexPath(row: companies.count, section: 0)
    
    companies.append(company)
    tableView.insertRows(at: [indexPath], with: .automatic)
  }
  
  func didEdit(company: Company) {
    guard let row = companies.firstIndex(of: company) else { return }
    
    let indexPath = IndexPath(row: row, section: 0)
    tableView.reloadRows(at: [indexPath], with: .middle)
  }
  
}
