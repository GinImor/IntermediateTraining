//
//  CoreDataStack.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 1/31/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import CoreData

class CoreDataStack {
  
  let modelName: String
  
  var mainContext: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: modelName)
    container.loadPersistentStores { (storeDescription, error) in
      if let error = error as NSError? {
        print("\(error), \(error.userInfo)")
      }
    }
    return container
  }()
  
  internal init(modelName: String) {
    self.modelName = modelName
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
