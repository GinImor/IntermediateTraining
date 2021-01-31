//
//  AddCompanyController.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 1/30/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit
import CoreData

protocol AddCompanyDelegate: class {
  func didAdd(company: Company)
}

class AddCompanyController: UIViewController {
  
  var nameStackView = TextInputStackView(for: "name")
  
  var backgroundView: UIView = {
    let backgroundView = UIView()
    
    backgroundView.tAMIC = false
    backgroundView.backgroundColor = .lightBlue
    
    return backgroundView
  }()
  
  weak var delegate: AddCompanyDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupMainUI()
    populateContentToNavigationBar()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    nameStackView.readyForInput()
  }
  
  private func setupMainUI() {
    view.backgroundColor = .darkBlue
    
    view.addSubview(backgroundView)
    NSLayoutConstraint.activate([
      backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      backgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor)
    ])
    
    backgroundView.addSubview(nameStackView)
    NSLayoutConstraint.activate([
      nameStackView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
      nameStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: backgroundView.leadingAnchor, multiplier: 2.0),
      backgroundView.trailingAnchor.constraint(equalToSystemSpacingAfter: nameStackView.trailingAnchor, multiplier: 2.0),
      nameStackView.heightAnchor.constraint(equalToConstant: 50),
      nameStackView.heightAnchor.constraint(equalTo: backgroundView.heightAnchor)
    ])
    
  }
  
  private func populateContentToNavigationBar() {
    navigationItem.title = "Add Company"
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
  }
  
  @objc func cancel() {
    presentingViewController?.dismiss(animated: true)
  }
  
  @objc func save() {
    presentingViewController?.dismiss(animated: true) {
      let company = NSEntityDescription.insertNewObject(
        forEntityName: "Company",
        into: CoreDataStack.shared.mainContext
      )
      company.setValue(self.nameStackView.textInput, forKey: "name")
      CoreDataStack.shared.saveContext()
      
      self.delegate?.didAdd(company: company as! Company)
    }
  }
  
}
