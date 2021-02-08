//
//  ImagePickerProtocol.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 2/8/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit

protocol ImagePickerProtocol: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  
  var imageView: UIImageView { get set }
}

extension ImagePickerProtocol where Self: UIViewController {
  
  var image: UIImage? {
     get { imageView.image }
     set {
       imageView.image = newValue
       setupRoundedImageView()
     }
   }
  
  func setupRoundedImageView() {
    imageView.layer.cornerRadius = imageView.frame.width/2
    imageView.layer.masksToBounds = true
    imageView.layer.borderWidth = 2
    imageView.layer.borderColor = UIColor.darkBlue.cgColor
  }
  
  func createImageView(getstureRecognizor: UIGestureRecognizer) -> UIImageView {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
    
    imageView.tAMIC = false
    imageView.contentMode = .scaleAspectFill
    imageView.isUserInteractionEnabled = true
    
    imageView.addGestureRecognizer(getstureRecognizor)
    return imageView
  }

  func handleTap() {
    let imagePicker = UIImagePickerController()
    // remember ask user permision
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    
    present(imagePicker, animated: true, completion: nil)
  }
  
  func imagePickerDidCancel(_ picker: UIImagePickerController) {
    picker.presentingViewController?.dismiss(animated: true)
  }
  
  func imagePicker(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    if let editedImage = info[.editedImage] as? UIImage {
      image = editedImage
    } else if let originalImage = info[.originalImage] as? UIImage {
      image = originalImage
    }
    
    picker.presentingViewController?.dismiss(animated: true)
  }
}

