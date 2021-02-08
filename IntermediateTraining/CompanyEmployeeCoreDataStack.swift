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
    birthday: Date?,
    company: Company,
    saveImmediately: Bool = true,
    into context: NSManagedObjectContext? = nil,
    completion: ((Employee) -> Void)? = nil)
  {
    let employee = Employee(context: context ?? mainContext)
    let employeeInfo = EmployeeInfo(context: context ?? mainContext)
    
    employeeInfo.birthday = birthday
    
    employee.setValue(name, forKey: "name")
    employee.title = title
    
    employee.info = employeeInfo
    employee.company = company
    
    if saveImmediately { saveContext() }
    completion?(employee)
  }
  
  final func addCompanies(jsonCompanies: [JSONCompany]) {
    let privateContext = newPrivateContext()
    
    jsonCompanies.forEach { (jsonCompany) in
      self.addCompany(
        name: jsonCompany.name,
        founded: DateFormatter.m2sD2sY4.date(from: jsonCompany.founded),
        saveImmediately: false,
        in: privateContext) { (company) in
          
          jsonCompany.employees?.forEach { (jsonEmployee) in
            self.addEmployee(
              name: jsonEmployee.name,
              title: Int32(EmployeeTitle.allNames.firstIndex(of: jsonEmployee.type)!),
              birthday: DateFormatter.m2sD2sY4.date(from: jsonEmployee.birthday),
              company: company,
              saveImmediately: false,
              into: privateContext
            )
          }
      }
    }
    saveContext(context: privateContext)
  }
  
}
