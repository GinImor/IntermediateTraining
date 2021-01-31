//
//  AddCompanyController.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 1/30/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit

class AddCompanyController: UIViewController {
  
  var backgroundView: UIView = {
    let backgroundView = UIView()
    
    backgroundView.tAMIC = false
    backgroundView.backgroundColor = .lightBlue
    
    return backgroundView
  }()
  
  var nameLabel: UILabel = {
    let label = UILabel()
    
    label.text = "Name"
    label.setContentHuggingPriority(.init(rawValue: 251), for: .horizontal)
    label.setContentHuggingPriority(.init(rawValue: 251), for: .vertical)
    
    return label
  }()
  
  var nameTextField: UITextField = {
    let textField = UITextField()
    
    textField.placeholder = "Enter Company Name"
    return textField
  }()
  
  lazy var nameStackView: UIStackView = {
    let stackView = UIStackView()
    
    stackView.tAMIC = false
    stackView.addArrangedSubview(nameLabel)
    stackView.addArrangedSubview(nameTextField)
    stackView.alignment = .firstBaseline
    stackView.spacing = 8
    
    return stackView
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
      nameStackView.leadingAnchor.constraint(equalTo:backgroundView.leadingAnchor, constant: 16),
      backgroundView.trailingAnchor.constraint(equalTo: nameStackView.trailingAnchor, constant: 16),
      nameStackView.heightAnchor.constraint(equalToConstant: 50),
      nameStackView.heightAnchor.constraint(equalTo: backgroundView.heightAnchor)
    ])
    
    NSLayoutConstraint.activate([
      nameLabel.centerYAnchor.constraint(equalTo: nameStackView.centerYAnchor),
      nameLabel.widthAnchor.constraint(equalToConstant: 100)
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
    
  }
}
