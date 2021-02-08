//
//  AddCompanyEmployeeProtocol.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 2/8/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit

class AddCompanyEmployeeController: UIViewController {
  
  var nameStackView = TextInputStackView(for: "name")
}

extension AddCompanyEmployeeController: AddItemProtocol, LightBlueBackgroundColorProtocol {
  
  func setupViewsAppearance() {
    view.backgroundColor = .darkBlue
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupAddItemEnvironment()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    nameStackView.readyForInput()
  }
}
