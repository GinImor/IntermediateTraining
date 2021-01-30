//
//  ViewController.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 1/30/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit

class CompanyViewController: UITableViewController {

  enum ID {
    static let cell = "CellID"
  }
  
  let companies: [Company] = [
    Company(name: "Apple", founded: Date()),
    Company(name: "Google", founded: Date()),
    Company(name: "Fackbook", founded: Date()),
  ]
  
  
  // MARK: - View Controller Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    setupTableView()
    configureNavigationBar()
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
    let addCompanyNavigationController = UINavigationController(rootViewController: AddCompanyController())
    present(addCompanyNavigationController, animated: true)
  }
  
  private func configureBarAppearanceForNavigationController() {
    let navigationBar = navigationController?.navigationBar
    let standardAppearance = navigationBar?.standardAppearance
    
    navigationBar?.prefersLargeTitles = true
    
    standardAppearance?.backgroundColor = .lightRed
    standardAppearance?.titleTextAttributes = [.foregroundColor: UIColor.white]
    standardAppearance?.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    
    // doesn't need navigationBar?.compactAppearance = standardAppearance
    navigationBar?.scrollEdgeAppearance = standardAppearance
  }

  private func configureBarAppearanceForChildController() {
    // specific to this item
    let navigationBar = navigationController?.navigationBar
    let standardAppearance = navigationBar?.standardAppearance.copy()
    // customize the appearance
    navigationItem.standardAppearance = standardAppearance
    navigationItem.compactAppearance = standardAppearance
    navigationItem.scrollEdgeAppearance = standardAppearance
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

