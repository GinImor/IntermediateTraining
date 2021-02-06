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
  
  func newPrivateContext() -> NSManagedObjectContext {
    let privateContext =
      NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    privateContext.parent = mainContext
    return privateContext
  }
  
  func saveContext() {
    saveContext(context: mainContext)
  }
  
  func saveContext(context: NSManagedObjectContext) {
    if context != mainContext {
      savePrivateContext(context: context)
    }
    
    context.perform {
      do {
        try context.save()
      } catch let nserror as NSError {
        fatalError("\(nserror), \(nserror.userInfo)")
      }
    }
  }
  
  func savePrivateContext(context: NSManagedObjectContext) {
    context.perform {
      if context.hasChanges {
        do {
          try context.save()
        } catch let error as NSError {
          print("can't save context", error)
        }
      }
      
      self.saveContext(context: self.mainContext)
    }
  }
  
}
