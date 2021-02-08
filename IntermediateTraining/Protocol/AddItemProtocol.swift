//
//  AddItemProtocol.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 2/8/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit

@objc protocol AddItemProtocol {
  func setupViewsAppearance()
  @objc optional func setupViewsLayout()
  @objc optional var navitationTitle: String { get }
}

extension AddItemProtocol where Self: UIViewController {
    
  func setupAddItemEnvironment() {
    setupViewsAppearance()
    setupViewsLayout?()
    populateContentToNavigationBar()
  }
  
  func populateContentToNavigationBar() {
    navigationItem.title = navitationTitle
    setupCancelBarButton()
    setupSaveBarButton()
  }
}


