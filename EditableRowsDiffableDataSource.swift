//
//  EditableRowsDiffableDataSource.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 2/6/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit

class EditableRowsDiffableDataSource<Section: Hashable, Item: Hashable>: UITableViewDiffableDataSource<Section, Item> {
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
}
