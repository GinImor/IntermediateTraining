//
//  IndentedLabel.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 2/4/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit

class IndentedLabel: UILabel {
  
  override func drawText(in rect: CGRect) {
    let insetRect = rect.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0))
    super.drawText(in: insetRect)
  }
}
