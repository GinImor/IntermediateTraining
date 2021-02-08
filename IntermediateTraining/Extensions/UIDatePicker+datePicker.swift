//
//  UIDatePicker+datePicker.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 2/8/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit

extension UIDatePicker {
  
  static func datePicker() -> UIDatePicker {
    let datePicker = UIDatePicker()
    
    datePicker.tAMIC = false
    datePicker.datePickerMode = .date
    
    return datePicker
  }
}
