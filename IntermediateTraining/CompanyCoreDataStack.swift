//
//  CompanyCoreDataStack.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 2/3/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import CoreData

class CompanyCoreDataStack: CoreDataStack {
  
  static let shared = CompanyCoreDataStack(modalName: "Model")
  
  func loadComapnies(completion: (Result<[Company], Error>) -> Void) {
    let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
    
    do {
      completion(.success(try mainContext.fetch(fetchRequest)))
    } catch {
      completion(.failure(error))
    }
  }
  
  func removeAllCompanies(completion: (Result<Any?, Error>) -> Void) {
    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
    
    do {
      try mainContext.execute(batchDeleteRequest)
      completion(.success(nil))
    } catch {
      completion(.failure(error))
    }
  }
  
}
