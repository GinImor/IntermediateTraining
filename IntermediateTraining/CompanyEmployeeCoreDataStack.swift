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
    completion: (Employee) -> Void)
  {
    let employee = NSEntityDescription.insertNewObject(
      forEntityName: "Employee",
      into: mainContext
    )
    
    employee.setValue(name, forKey: "name")
    
    saveContext()
    completion(employee as! Employee)
  }
  
}
