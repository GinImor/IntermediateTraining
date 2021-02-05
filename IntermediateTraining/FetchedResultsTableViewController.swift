//
//  FetchedResultsTableViewController.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 2/5/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit
import CoreData

class FetchedResultsTableViewController<Object: NSManagedObject>: UITableViewController, NSFetchedResultsControllerDelegate {
  
  // MARK: - Properties and Functions Subclass must Override
  
  var cellID: String { "" }
  var sortKeys: [String] { [] }
  var sectionNameKeyPath: String? { nil }
  var predicate: NSPredicate? { nil }
  var sortDescriptors: [NSSortDescriptor] {
    sortKeys.map { NSSortDescriptor(key: $0, ascending: true) }
  }
  var managedObjectContext: NSManagedObjectContext {
    NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
  }
  func configure(cell: UITableViewCell, for indexPath: IndexPath) {}
  
  
  // MARK: - Fetched Results Controller Subclass Opt to Override
  
  lazy var fetchedResultsController: NSFetchedResultsController<Object>! = {
    let fetchRequest = NSFetchRequest<Object>(entityName: String(describing: Object.self))
    fetchRequest.sortDescriptors = self.sortDescriptors
    fetchRequest.predicate = self.predicate
    
    let frc = NSFetchedResultsController(
      fetchRequest: fetchRequest,
      managedObjectContext: self.managedObjectContext,
      sectionNameKeyPath: self.sectionNameKeyPath,
      cacheName: nil)
    frc.delegate = self
    
    return frc
  }()
  
  func loadData() {
    do {
      try fetchedResultsController.performFetch()
    } catch let error {
      print("can't fetch the companies", error)
    }
  }
  
  // MARK: - implementing Table View Data Source using Fetched Results Controller
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return fetchedResultsController?.sections?.count ?? 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fetchedResultsController?.sections?[section].numberOfObjects ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
    
    configure(cell: cell, for: indexPath)
    return cell
  }
  
  
  // MARK: - implementing Table View Delegate using Fetched Results Controller
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    fetchedResultsController?.sections?[section].name
  }
  
  // MARK: - Fetched Results Controller Delegate
  
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any,
                  at indexPath: IndexPath?,
                  for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    switch type {
    case .insert:
      tableView.insertRows(at: [newIndexPath!], with: .automatic)
      
    case .delete:
      tableView.deleteRows(at: [indexPath!], with: .automatic)
    case .update:
      let cell = tableView.cellForRow(at: indexPath!)!
      configure(cell: cell, for: indexPath!)
    case .move:
      tableView.deleteRows(at: [indexPath!], with: .automatic)
      tableView.insertRows(at: [newIndexPath!], with: .automatic)
    @unknown default:
      print("Unexpected NSFetchedResultsChangeType")
    }
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int,
                  for type: NSFetchedResultsChangeType) {
    let indexSet = IndexSet(integer: sectionIndex)
    switch type {
    case .insert:
      tableView.insertSections(indexSet, with: .automatic)
    case .delete:
      tableView.deleteSections(indexSet, with: .automatic)
    default: break
    }
  }
  
}
