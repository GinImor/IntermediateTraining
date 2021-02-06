//
//  Service.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 2/6/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import Foundation
import CoreData

enum Service {
  
  static let companyUrlString = "https://api.letsbuildthatapp.com/intermediate_training/companies"
  
  static func downloadCompanies(completion: @escaping () -> Void) {
    guard let companyUrl = URL(string: companyUrlString) else { return }
    
    URLSession.shared.dataTask(with: companyUrl) { (data, response, error) in
      guard error == nil else { return }
      
      guard let httpResponse = response as? HTTPURLResponse,
        (200...209).contains(httpResponse.statusCode) else { return }
      
      guard let data = data, let string = String(data: data, encoding: .utf8) else { return }
      print(string)
      
      do {
        let jsonCompanies = try JSONDecoder().decode([JSONCompany].self, from: data)
        CompanyEmployeeCoreDataStack.shared.addCompanies(jsonCompanies: jsonCompanies)
      } catch {
        print("can't decode the data", error)
      }
      
      DispatchQueue.main.async {
        completion()
      }
    }.resume()
  }
  
}
