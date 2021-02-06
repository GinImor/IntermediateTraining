//
//  FetchedResultsTableViewController.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 2/5/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit
import CoreData

class FetchedResultsTableViewController<Section: Hashable, Object: NSManagedObject>: UITableViewController, NSFetchedResultsControllerDelegate {
  
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
  
  
  // MARK: - Diffable Data Source
  
  var dataSource: EditableRowsDiffableDataSource<String, NSManagedObjectID>?
  
  func setupDataSource() -> EditableRowsDiffableDataSource<String, NSManagedObjectID> {
    return EditableRowsDiffableDataSource(tableView: tableView) { [unowned self]
      (tableView, indexPath, _) -> UITableViewCell? in
      let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath)
      
      self.configure(cell: cell, for: indexPath)
      return cell
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    dataSource = setupDataSource()
  }
   
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    fetchData()
  }
  
  func fetchData() {
    do {
      try fetchedResultsController.performFetch()
    } catch let error {
      print("can't fetch the items", error)
    }
  }
  
  
  // MARK: - Fetched Results Controller Delegate
  
  func controller(
    _ controller: NSFetchedResultsController<NSFetchRequestResult>,
    didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
    dataSource?.apply(snapshot as  NSDiffableDataSourceSnapshot<String, NSManagedObjectID>, animatingDifferences: true)
  }

}
