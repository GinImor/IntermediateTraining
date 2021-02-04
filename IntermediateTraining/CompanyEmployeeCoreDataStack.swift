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
    ) as! Employee
    let employeeInfo = NSEntityDescription.insertNewObject(
                         forEntityName: "EmployeeInfo",
                         into: mainContext
                       ) as! EmployeeInfo
    
    employeeInfo.taxID = "1634"
    
    employee.setValue(name, forKey: "name")
    employee.info = employeeInfo
    
    saveContext()
    completion(employee)
  }
  
  final func loadEmployees(completion: (Result<[Employee], Error>) -> Void) {
    let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")
    
    do {
      completion(.success(try mainContext.fetch(fetchRequest)))
    } catch {
      completion(.failure(error))
    }
  }
  
}
