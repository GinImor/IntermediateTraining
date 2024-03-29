//
//  InputStackView.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 1/31/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit

class TextInputStackView: UIStackView {
  
  var label: UILabel = {
    let label = UILabel()
    label.setContentHuggingPriority(.init(rawValue: 251), for: .horizontal)
    label.setContentHuggingPriority(.init(rawValue: 251), for: .vertical)
    return label
  }()
  
  var textField: UITextField = {
    let textField = UITextField()
    return textField
  }()
  
  var textInput: String! {
    get {
      guard let text = textField.text else { return "" }
      return text
    }
    set {
      textField.text = newValue
    }
  }
  
  private override init(frame: CGRect) {
    super.init(frame: .zero)
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(for labelName: String, placeholder: String? = nil) {
    super.init(frame: .zero)
    setup(for: labelName, placeholder: placeholder)
  }
  
  private func setup(for labelName: String, placeholder: String?) {
    label.text = labelName.capitalized
    textField.placeholder = placeholder ?? "Enter \(label.text!)"
    textField.delegate = self
    
    tAMIC = false
    addArrangedSubview(label)
    addArrangedSubview(textField)
    alignment = .firstBaseline
    
    NSLayoutConstraint.activate([
      label.centerYAnchor.constraint(equalTo: centerYAnchor),
      label.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2)
    ])
  }
  
  func readyForInput() {
    if textField.window != nil {
      textField.becomeFirstResponder()
    }
  }
}


extension TextInputStackView: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
