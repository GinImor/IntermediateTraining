//
//  CompanyCell.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 2/3/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit

class CompanyCell: UITableViewCell {
  
  var imageViewWidth: CGFloat { 40 }
  var imageViewPadding: CGFloat { 8 }
  var imageViewCenterX: CGFloat { imageViewPadding+imageViewWidth/2 }
  var textLabelXOffset: CGFloat { 2*imageViewPadding+imageViewWidth }
  
  var company: Company? {
    didSet {
      if let name = company?.name, let founded = company?.founded {
        textLabel?.text = "\(name) - Founded: \(DateFormatter.m3D2Y4.string(from: founded))"
      } else {
        textLabel?.text = company?.name
      }
      
      if let imageData = company?.imageData {
        imageView?.image = UIImage(data: imageData)
      }
    }
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    backgroundColor = .tealColor
    
    imageView?.layer.cornerRadius = imageViewWidth/2
    imageView?.layer.masksToBounds = true
    imageView?.contentMode = .scaleAspectFill
    
    textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    textLabel?.textColor = .white
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    imageView?.frame = CGRect(x: 0, y: 0, width: imageViewWidth, height: imageViewWidth)
    imageView?.center = CGPoint(x: imageViewCenterX, y: bounds.midY)
    textLabel?.frame = CGRect(origin: .init(x: textLabelXOffset, y: 0), size: textLabel!.frame.size)
    
    separatorInset = UIEdgeInsets(top: 0, left: textLabelXOffset, bottom: 0, right: 0)
  }
}
 
