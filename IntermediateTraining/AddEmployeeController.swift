//
//  AddEmployeeController.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 2/3/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit

class AddEmployeeController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAddItemEnvironment()
  }
  
}

extension AddEmployeeController: AddItemProtocol {
  
  var navitationTitle: String { "Add Employee" }
  
  func setupViewsLayout() {
    
  }
  
}
