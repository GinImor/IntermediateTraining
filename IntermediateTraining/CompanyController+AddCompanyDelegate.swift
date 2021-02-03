//
//  CompanyController+AddCompanyDelegate.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 2/3/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit

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
