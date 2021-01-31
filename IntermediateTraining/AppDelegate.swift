//
//  AppDelegate.swift
//  IntermediateTraining
//
//  Created by Gin Imor on 1/30/21.
//  Copyright © 2021 Brevity. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // remember to call the method !!!
    configureBarAppearance()
    return true
  }

  private func configureBarAppearance() {
    // all navigation bar created with the custom appearance
    let buttonAppearance = UIBarButtonItemAppearance()
    let barStandardAppearance = UINavigationBarAppearance()
    
    buttonAppearance.configureWithDefault(for: .plain)
    buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
    
    barStandardAppearance.configureWithDefaultBackground()
    barStandardAppearance.backgroundColor = .lightRed
    barStandardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    barStandardAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    barStandardAppearance.buttonAppearance = buttonAppearance

    UINavigationBar.appearance().prefersLargeTitles = true
    UINavigationBar.appearance().standardAppearance = barStandardAppearance
    // used when navigation associated with a scroll view,
    // for large title navigation bar even it does not have scroll view
    // Scroll edge appearance also applies for navigation bar with search controller
    UINavigationBar.appearance().scrollEdgeAppearance = barStandardAppearance
  }
  
  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }


}

