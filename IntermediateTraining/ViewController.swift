//
//  ViewController.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 1/30/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    view.backgroundColor = .white
    configureNavigationBar()
  }

  private func configureNavigationBar() {
    configureBarAppearanceForNavigationController()
    populateContentToNavigationBar()
  }
  
  private func populateContentToNavigationBar() {
    navigationItem.title = "Companies"
    // withRenderingMode(.alwaysOriginal) prevent default coloring, eg blue for bar button
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal),
                                                        style: .plain, target: self, action: #selector(addCompany))
  }
  
  @objc func addCompany() {
    //TODO
  }
  
  private func configureBarAppearanceForNavigationController() {
    let navigationBar = navigationController?.navigationBar
    let standardAppearance = navigationBar?.standardAppearance
    
    navigationItem.title = "Companies"
    navigationBar?.prefersLargeTitles = true
    
    let lightRed = UIColor(rgb: (247, 66, 82))
    standardAppearance?.backgroundColor = lightRed
    standardAppearance?.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    
    navigationBar?.scrollEdgeAppearance = standardAppearance
  }

  private func configureBarAppearanceForChildController() {
    // specific to this item
    let navigationBar = navigationController?.navigationBar
    let standardAppearance = navigationBar?.standardAppearance.copy()
    // customize the appearance
    navigationItem.standardAppearance = standardAppearance
    navigationItem.scrollEdgeAppearance = standardAppearance
  }
}

