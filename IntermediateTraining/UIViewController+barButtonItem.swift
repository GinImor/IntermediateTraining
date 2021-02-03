//
//  UIViewController+barButtonItem.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 2/3/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit

extension UIViewController {
  
  func setupAddBarButton() {
    navigationItem.rightBarButtonItem =
      // withRenderingMode(.alwaysOriginal) prevent default coloring, eg blue for bar button
      UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal),
                      style: .plain, target: self, action: #selector(add))
  }
  
  func setupResetBarButton() {
    navigationItem.leftBarButtonItem =
      UIBarButtonItem(title: "Reset",style: .plain, target: self, action: #selector(reset))
  }
  
  func setupCancelBarButton() {
    navigationItem.leftBarButtonItem =
      UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
  }
  
  func setupSaveBarButton() {
    navigationItem.rightBarButtonItem =
      UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
  }
  
  @objc func add() {}
  @objc func reset() {}
  @objc func save() {}
  @objc func cancel() { presentingViewController?.dismiss(animated: true) }
}
