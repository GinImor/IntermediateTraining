//
//  AddEmployeeController.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 2/3/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit
import CoreData

extension NSNotification.Name {
  static let didAddEmployee = NSNotification.Name(rawValue: "didAddEmployee")
}

class AddEmployeeController: UIViewController {
  
  var company: Company!
  var employee: Employee?
  
  let nameStackView = TextInputStackView(for: "name")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAddItemEnvironment()
  }
  
  override func save() {
    presentingViewController?.dismiss(animated: true) {
      guard self.nameStackView.textInput != "" else { return }
      
      if self.employee == nil { self.addEmployee() }
      else { self.updateEmployee() }
    }
  }
  
  private func addEmployee() {
    CompanyEmployeeCoreDataStack.shared.addEmployee(name: nameStackView.textInput, company: company) { (employee) in
      NotificationCenter.default.post(name: .didAddEmployee, object: nil, userInfo: ["employee": employee])
    }
  }
  
  private func updateEmployee() {
    
  }
  
}

extension AddEmployeeController: AddItemProtocol {
  
  var navitationTitle: String { "Add Employee" }
  
  func setupViewsLayout() {
    let backgroundView = lightBlueBackgroundView()
    
    backgroundView.addSubview(nameStackView)
    NSLayoutConstraint.activate([
      nameStackView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
      nameStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: backgroundView.leadingAnchor, multiplier: 2.0),
      backgroundView.trailingAnchor.constraint(equalToSystemSpacingAfter: nameStackView.trailingAnchor, multiplier: 2.0),
      nameStackView.heightAnchor.constraint(equalToConstant: 50),
      
      backgroundView.bottomAnchor.constraint(equalTo: nameStackView.bottomAnchor),
    ])
    
  }
  
}

extension AddEmployeeController: LightBlueBackgroundColorProtocol {}
