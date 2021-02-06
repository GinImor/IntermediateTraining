//
//  JSONCompany.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 2/6/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import Foundation

struct JSONCompany: Decodable {
  let name: String
  let founded: String
  var employees: [JSONEmployee]?
}

struct JSONEmployee: Decodable {
  let name: String
  let birthday: String
  let type: String
}
