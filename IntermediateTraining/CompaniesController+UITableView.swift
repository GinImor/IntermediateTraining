//
//  CompanyController+UITableView.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 2/3/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit

extension CompaniesViewController {
  
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
    return fetchedResultsController.fetchedObjects?.count == 0 ? 150 : 0
   }
  
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     let employeesController = EmployeesController()
    
     employeesController.company = fetchedResultsController.fetchedObjects?[indexPath.row]
     navigationController?.pushViewController(employeesController, animated: true)
   }
   
   override func tableView(
     _ tableView: UITableView,
     trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
   ) -> UISwipeActionsConfiguration? {
    let company = self.fetchedResultsController.object(at: indexPath)
     
     let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
       (_, _, completion) in
      
       CompanyEmployeeCoreDataStack.shared.mainContext.delete(company)
       CompanyEmployeeCoreDataStack.shared.saveContext()
       
       completion(true)
     }
     
     let editAction = UIContextualAction(style: .normal, title: "Edit") {
       [unowned self] (_, _, completion) in
       let editCompanyController = AddCompanyController()
       editCompanyController.company = company
//       editCompanyController.delegate = self
       
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
 
}
