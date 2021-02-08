//
//  JSONEmployee.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 2/8/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import Foundation

struct JSONEmployee: Decodable {
  let name: String
  let birthday: String
  let type: String
}
