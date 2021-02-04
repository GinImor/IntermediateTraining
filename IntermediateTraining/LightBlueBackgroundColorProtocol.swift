//
//  LightBlueBackgroundColorProtocol.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 2/3/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit

protocol LightBlueBackgroundColorProtocol: class {
  func lightBlueBackgroundView() -> UIView
}

extension LightBlueBackgroundColorProtocol where Self: UIViewController {
  
  func lightBlueBackgroundView() -> UIView {
    let backgroundView = UIView()
    
    backgroundView.tAMIC = false
    backgroundView.backgroundColor = .lightBlue
    
    view.addSubview(backgroundView)
    NSLayoutConstraint.activate([
      backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      backgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
    ])
    
    return backgroundView
  }
  
}
