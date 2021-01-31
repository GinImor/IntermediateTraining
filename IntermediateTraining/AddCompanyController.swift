//
//  AddCompanyController.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 1/30/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit

class AddCompanyController: UIViewController {
  
  var nameStackView = TextInputStackView(for: "name")
  
  var backgroundView: UIView = {
    let backgroundView = UIView()
    
    backgroundView.tAMIC = false
    backgroundView.backgroundColor = .lightBlue
    
    return backgroundView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupMainUI()
    populateContentToNavigationBar()
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
    
    presentingViewController?.dismiss(animated: true)
  }
}