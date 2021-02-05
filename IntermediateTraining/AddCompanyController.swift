//
//  AddCompanyController.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 1/30/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit
import CoreData

class AddCompanyController: UIViewController {
  
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
  
  var image: UIImage? {
    get { imageView.image }
    set {
      imageView.image = newValue
      setupRoundedImageView()
    }
  }
  
  lazy var imageView: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
    
    imageView.tAMIC = false
    imageView.contentMode = .scaleAspectFill
    imageView.isUserInteractionEnabled = true
    
    let tapGestureRecognizor = UITapGestureRecognizer(target: self, action: #selector(tap))
    imageView.addGestureRecognizer(tapGestureRecognizor)
    
    return imageView
  }()
  
  var nameStackView = TextInputStackView(for: "name")
  
  var datePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    
    datePicker.tAMIC = false
    datePicker.datePickerMode = .date
    
    return datePicker
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAddItemEnvironment()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    nameStackView.readyForInput()
  }
  
  override func save() {
    presentingViewController?.dismiss(animated: true) {
      guard self.nameStackView.textInput != "" else { return }
      
      if self.company == nil { self.addCompany() }
      else { self.updateCompany() }
    }
  }
  
  @objc func tap() {
    let imagePicker = UIImagePickerController()
    // remember ask user permision
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    
    present(imagePicker, animated: true, completion: nil)
  }
  
  private func addCompany() {
    CompanyEmployeeCoreDataStack.shared.addCompany(
      imageData: image?.jpegData(compressionQuality: 0.8),
      name: nameStackView.textInput,
      founded: datePicker.date) { (company) in }
  }
  
  private func updateCompany() {
    CompanyEmployeeCoreDataStack.shared.updateCompany(
      company: company!,
      imageData: image?.jpegData(compressionQuality: 0.8),
      name: nameStackView.textInput,
      founded: datePicker.date) {}
  }
  
  private func setupRoundedImageView() {
    imageView.layer.cornerRadius = imageView.frame.width/2
    imageView.layer.masksToBounds = true
    imageView.layer.borderWidth = 2
    imageView.layer.borderColor = UIColor.darkBlue.cgColor
  }
  
}

extension AddCompanyController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.presentingViewController?.dismiss(animated: true)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    if let editedImage = info[.editedImage] as? UIImage {
      image = editedImage
    } else if let originalImage = info[.originalImage] as? UIImage {
      image = originalImage
    }
    
    picker.presentingViewController?.dismiss(animated: true)
  }
}

extension AddCompanyController: AddItemProtocol {
  
  var navitationTitle: String { "Add Company" }
  
  func setupViewsLayout() {
    let backgroundView = lightBlueBackgroundView()
    
    backgroundView.addSubview(imageView)
    backgroundView.addSubview(nameStackView)
    backgroundView.addSubview(datePicker)
    
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
      backgroundView.bottomAnchor.constraint(equalTo: datePicker.bottomAnchor),
      datePicker.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
    ])
  }
  
}

extension AddCompanyController: LightBlueBackgroundColorProtocol {}
