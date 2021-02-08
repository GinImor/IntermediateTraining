//
//  AddCompanyController.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 1/30/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit
import CoreData

class AddCompanyController: AddCompanyEmployeeController {
  
  var company: Company? {
    didSet {
      if let imageData = company?.imageData {
        image = UIImage(data: imageData)
      }
      nameStackView.textInput = company?.name
      if let founded = company?.founded {
        datePicker.date = founded
      }
    }
  }
  
  lazy var imageView: UIImageView = self.createImageView(getstureRecognizor:
    UITapGestureRecognizer(target: self, action: #selector(tap)))
  
  var datePicker: UIDatePicker = UIDatePicker.datePicker()
  
  @objc func tap() { self.handleTap() }
  
  override func save() {
    presentingViewController?.dismiss(animated: true) {
      guard self.nameStackView.textInput != "" else { return }
      
      if self.company == nil { self.addCompany() }
      else { self.updateCompany() }
    }
  }

  private func addCompany() {
    CompanyEmployeeCoreDataStack.shared.addCompany(
      name: nameStackView.textInput,
      founded: datePicker.date,
      imageData: image?.jpegData(compressionQuality: 0.8)) { (company) in }
  }
  
  private func updateCompany() {
    CompanyEmployeeCoreDataStack.shared.updateCompany(
      company: company!,
      imageData: image?.jpegData(compressionQuality: 0.8),
      name: nameStackView.textInput,
      founded: datePicker.date) {}
  }
  
}

extension AddCompanyController: ImagePickerProtocol {}

// image picker protocol
extension AddCompanyController {
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    self.imagePickerDidCancel(picker)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    self.imagePicker(picker, didFinishPickingMediaWithInfo: info)
  }
}

// AddItemProtocol
extension AddCompanyController {
  
  var navitationTitle: String { "Add Company" }
  
  func setupViewsLayout() {
    let backgroundView = lightBlueBackgroundView(subViews: [imageView, nameStackView, datePicker])
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalToSystemSpacingBelow: backgroundView.topAnchor, multiplier: 1.0),
      imageView.heightAnchor.constraint(equalToConstant: 100),
      imageView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
      imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
      
      nameStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
      nameStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: backgroundView.leadingAnchor, multiplier: 2.0),
      backgroundView.trailingAnchor.constraint(equalToSystemSpacingAfter: nameStackView.trailingAnchor, multiplier: 2.0),
      nameStackView.heightAnchor.constraint(equalToConstant: 50),
      
      datePicker.topAnchor.constraint(equalToSystemSpacingBelow: nameStackView.bottomAnchor, multiplier: 1.0),
      datePicker.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
    ])
  }
}
