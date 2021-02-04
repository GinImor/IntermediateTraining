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
  
  var titleSegmentedControl: UISegmentedControl = {
    let segmentedControl = UISegmentedControl(items: EmployeeTitle.allNames)
    
    segmentedControl.disableTAMIC()
    segmentedControl.selectedSegmentIndex = 0
    segmentedControl.selectedSegmentTintColor = .darkBlue
    segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    
    return segmentedControl
  }()
  
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
    title: titleSegmentedControl.titleForSegment(at: titleSegmentedControl.selectedSegmentIndex)!,
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
    backgroundView.addSubview(titleSegmentedControl)
    
    NSLayoutConstraint.activate([
      nameStackView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
      nameStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: backgroundView.leadingAnchor, multiplier: 2.0),
      backgroundView.trailingAnchor.constraint(equalToSystemSpacingAfter: nameStackView.trailingAnchor, multiplier: 2.0),
      nameStackView.heightAnchor.constraint(equalToConstant: 50),
      
      birthdayStackView.topAnchor.constraint(equalTo: nameStackView.bottomAnchor),
      birthdayStackView.leftAnchor.constraint(equalTo: nameStackView.leftAnchor),
      birthdayStackView.rightAnchor.constraint(equalTo: nameStackView.rightAnchor),
      birthdayStackView.heightAnchor.constraint(equalToConstant: 50),
      
      titleSegmentedControl.topAnchor.constraint(equalTo: birthdayStackView.bottomAnchor),
      titleSegmentedControl.leftAnchor.constraint(equalTo: birthdayStackView.leftAnchor),
      titleSegmentedControl.rightAnchor.constraint(equalTo: birthdayStackView.rightAnchor),
      
      backgroundView.bottomAnchor.constraint(equalToSystemSpacingBelow: titleSegmentedControl.bottomAnchor, multiplier: 1.0),
    ])
    
  }
  
}

extension AddEmployeeController: LightBlueBackgroundColorProtocol {}
