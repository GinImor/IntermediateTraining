//
//  CompanyCoreDataStack.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 2/3/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import CoreData

class CompanyCoreDataStack: CoreDataStack {
  
  final func addCompany(
    imageData: Data?, name: String, founded: Date,
    completion: (Company) -> Void)
  {
    let company = NSEntityDescription.insertNewObject(
      forEntityName: "Company",
      into: mainContext
    )
    
    company.setValue(imageData, forKey: "imageData")
    company.setValue(name, forKey: "name")
    company.setValue(founded, forKey: "founded")
    
    saveContext()
    completion(company as! Company)
  }
  
  final func loadComapnies(completion: (Result<[Company], Error>) -> Void) {
    let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
    
    do {
      completion(.success(try mainContext.fetch(fetchRequest)))
    } catch {
      completion(.failure(error))
    }
  }
  
  final func updateCompany(
    company: Company, imageData: Data?,
    name: String, founded: Date,
    completion: () -> Void)
  {
    company.name = name
    company.founded = founded
    company.imageData = imageData
    
    saveContext()
    completion()
  }
  
  final func removeAllCompanies(completion: (Result<Any?, Error>) -> Void) {
    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
    
    do {
      try mainContext.execute(batchDeleteRequest)
      completion(.success(nil))
    } catch {
      completion(.failure(error))
    }
  }
  
}
