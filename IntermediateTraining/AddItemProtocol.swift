//
//  AddItemProtocol.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 2/3/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit

protocol AddItemProtocol: class {
  var navitationTitle: String { get }
  func setupViewsAppearance()
  func setupViewsLayout()
}

extension AddItemProtocol where Self: UIViewController {
    
  func setupAddItemEnvironment() {
    setupMainUI()
    populateContentToNavigationBar()
  }
  
  func setupMainUI() {
    setupViewsAppearance()
    setupViewsLayout()
  }
  
  func setupViewsAppearance() {
    view.backgroundColor = .darkBlue
  }
  
  func populateContentToNavigationBar() {
    navigationItem.title = navitationTitle
    setupCancelBarButton()
    setupSaveBarButton()
  }

}

