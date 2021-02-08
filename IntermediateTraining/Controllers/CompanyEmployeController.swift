//
//  CompanyEmployeController.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 2/8/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit
import CoreData

class CompanyEmployeeController<Object: NSManagedObject>: FetchedResultsTableViewController<Object> {
  
  override var managedObjectContext: NSManagedObjectContext {
    CompanyEmployeeCoreDataStack.shared.mainContext
  }
  
  
  // MAR: - Properties Intended To Be Override By Subclass
  
  var navigationTitle: String? { "" }
  var cellClass: AnyClass? { nil }
  
  private var isCompany: Bool { cellID == ID.companyCell }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    populateContentToNavigationBar()
    setupTableView()
  }
  
  func setupTableView() {
    tableView.backgroundColor = .darkBlue
    tableView.separatorColor = .white
    tableView.rowHeight = 50
    tableView.sectionHeaderHeight = 50
    // void the table footer view so that no line appear at the bottom
    tableView.tableFooterView = UIView()
    tableView.register(cellClass, forCellReuseIdentifier: cellID)
  }
  
  func populateContentToNavigationBar() {
    navigationItem.title = navigationTitle
    if isCompany { setupResetBarButton() }
    setupAddBarButton()
  }
  
  
  // MARK: - Table View Delegate
  
  override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let label = UILabel()
    
    // or set another property intended to be overrided by subclass
    label.text = isCompany ? "No Company" : "No Employee"
    label.textColor = .white
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 16)
    
    return label
  }
  
  override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return fetchedResultsController.fetchedObjects?.count == 0 ? 150 : 0
  }
  
  
  override func tableView(
    _ tableView: UITableView,
    trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
  ) -> UISwipeActionsConfiguration? {
    let item = self.fetchedResultsController.object(at: indexPath)
    var actions = [UIContextualAction]()
    
    let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
      (_, _, completion) in
      
      CompanyEmployeeCoreDataStack.shared.mainContext.delete(item)
      CompanyEmployeeCoreDataStack.shared.saveContext()
      
      completion(true)
    }
    deleteAction.backgroundColor = .lightRed
    actions.append(deleteAction)
    
    if isCompany {
      let editAction = UIContextualAction(style: .normal, title: "Edit") {
        [unowned self] (action, _, completion) in
        self.editedIndexPath = indexPath
        let editCompanyController = AddCompanyController()
        editCompanyController.company = item as? Company
        
        let editCompanyNavigationController =
          lightStatusBarNavigationController(rootViewController: editCompanyController)
        
        self.present(editCompanyNavigationController, animated: true) {
          completion(true)
        }
      }
      editAction.backgroundColor = .darkBlue
      actions.append(editAction)
    }
    
    return UISwipeActionsConfiguration(actions: actions)
  }

}
