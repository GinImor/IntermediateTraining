//
//  UISegmentedController+employeeTitles.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 2/8/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit

extension UISegmentedControl {
  
  static var employeeSegmentedController: UISegmentedControl {
    let segmentedControl = UISegmentedControl(items: EmployeeTitle.allNames)
    
    segmentedControl.disableTAMIC()
    segmentedControl.selectedSegmentIndex = 0
    segmentedControl.selectedSegmentTintColor = .darkBlue
    segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    
    return segmentedControl
  }
}

