//
//  CoreDataStack.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 1/31/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import CoreData

class CoreDataStack {
  
  static let shared = CoreDataStack(modalName: "Model")
  
  let modalName: String
  
  var mainContext: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: modalName)
    container.loadPersistentStores { (storeDescription, error) in
      if let error = error as NSError? {
        print("\(error), \(error.userInfo)")
      }
    }
    return container
  }()
  
  private init(modalName: String) {
    self.modalName = modalName
  }
  
  func saveContext() {
    if mainContext.hasChanges {
      do {
        try mainContext.save()
      } catch let nserror as NSError {
        fatalError("\(nserror), \(nserror.userInfo)")
      }
    }
  }
  
}
