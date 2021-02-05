//
//  EmployeeCoreDataStack.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 2/4/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import CoreData

class CompanyEmployeeCoreDataStack: CompanyCoreDataStack {
  
  static let shared = CompanyEmployeeCoreDataStack(modelName: "Model")
  
  final func addEmployee(
    name: String,
    title: Int32,
    birthday: Date,
    company: Company,
    completion: (Employee) -> Void)
  {
    let employee = NSEntityDescription.insertNewObject(
      forEntityName: "Employee",
      into: mainContext
    ) as! Employee
    let employeeInfo = NSEntityDescription.insertNewObject(
                         forEntityName: "EmployeeInfo",
                         into: mainContext
                       ) as! EmployeeInfo
    
    employeeInfo.birthday = birthday
    
    employee.setValue(name, forKey: "name")
    employee.title = title
    
    employee.info = employeeInfo
    employee.company = company
    
    saveContext()
    completion(employee)
  }
  
}
