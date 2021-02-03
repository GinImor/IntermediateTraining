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
       
       CompanyCoreDataStack.shared.mainContext.delete(company)
       CompanyCoreDataStack.shared.saveContext()
       
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
   
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let employeesController = EmployeesController()
    
    employeesController.company = companies[indexPath.row]
    navigationController?.pushViewController(employeesController, animated: true)
  }
  
  
   // MARK: - Table View Data Source
   
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return companies.count
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: ID.cell, for: indexPath) as! CompanyCell
     cell.company = companies[indexPath.row]
     return cell
   }
  
}
