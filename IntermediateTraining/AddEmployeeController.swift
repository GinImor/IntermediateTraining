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
  let birthdayStackView = TextInputStackView(for: "birthday", placeholder: "MM/dd/yyyy")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAddItemEnvironment()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    nameStackView.readyForInput()
  }
  
  override func save() {
    guard validateInputs() else { return }
    presentingViewController?.dismiss(animated: true) {
      if self.employee == nil { self.addEmployee() }
      else { self.updateEmployee() }
    }
  }
  
  private func validateInputs() -> Bool {
    guard self.nameStackView.textInput != "" else {
      showAlert(title: "Empty Name", message: "Please Enter an Employee Name")
      return false
    }
    
    guard self.birthdayStackView.textInput != "" else {
      showAlert(title: "Empty Birthday", message: "Please Enter a Correct Formmated Date")
      return false
    }
    
    guard DateFormatter.m2sD2sY4.date(from: self.birthdayStackView.textInput) != nil else {
      showAlert(title: "Invalid Birthday", message: "Please Enter a Correct Formmated Date")
      return false
    }
    
    return true
  }
  
  private func showAlert(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "ok", style: .default) { [unowned self] (action) in
      if self.nameStackView.textInput == "" {
        self.nameStackView.readyForInput()
      } else {
        self.birthdayStackView.readyForInput()
      }
    }
    
    alert.addAction(action)
    present(alert, animated: true)
  }
  
  private func addEmployee() {
    CompanyEmployeeCoreDataStack.shared.addEmployee(
    name: nameStackView.textInput,
    birthday: DateFormatter.m2sD2sY4.date(from: self.birthdayStackView.textInput)!,
    company: company) { (employee) in
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
    backgroundView.addSubview(birthdayStackView)
    
    NSLayoutConstraint.activate([
      nameStackView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
      nameStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: backgroundView.leadingAnchor, multiplier: 2.0),
      backgroundView.trailingAnchor.constraint(equalToSystemSpacingAfter: nameStackView.trailingAnchor, multiplier: 2.0),
      nameStackView.heightAnchor.constraint(equalToConstant: 50),
      
      birthdayStackView.topAnchor.constraint(equalTo: nameStackView.bottomAnchor),
      birthdayStackView.leftAnchor.constraint(equalTo: nameStackView.leftAnchor),
      birthdayStackView.rightAnchor.constraint(equalTo: nameStackView.rightAnchor),
      birthdayStackView.heightAnchor.constraint(equalToConstant: 50),
      
      backgroundView.bottomAnchor.constraint(equalTo: birthdayStackView.bottomAnchor),
    ])
    
  }
  
}

extension AddEmployeeController: LightBlueBackgroundColorProtocol {}
