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
  
  // Batch deletes run faster than deleting the Core Data entities yourself in code because they operate
  // in the persistent store itself, at the SQL level. As part of this difference, the changes enacted
  // on the persistent store are not reflected in the objects that are currently in memory.
  // After a batch delete has been executed, remove any objects in memory that have been deleted from the persistent store.
  final func removeAllCompanies(completion: (Result<Any?, Error>) -> Void) {
    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
    batchDeleteRequest.resultType = .resultTypeObjectIDs
    
    do {
      if let deleteBatchResult = try mainContext.execute(batchDeleteRequest) as? NSBatchDeleteResult,
        let objectIDs = deleteBatchResult.result as? [NSManagedObjectID] {
        let changes = [NSDeletedObjectsKey: objectIDs]
        
        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [mainContext])
      }
      completion(.success(nil))
    } catch {
      completion(.failure(error))
    }
  }
  
}
