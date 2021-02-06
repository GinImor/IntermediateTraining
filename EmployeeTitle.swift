//
//  EmployeeTitle.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 2/4/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import Foundation

enum EmployeeTitle: String, CaseIterable {
  case Executive
  case SeniorManagement = "Senior Management"
  case Staff
  case Intern
  
  static var allNames: [String] = allCases.map { $0.rawValue }
}
