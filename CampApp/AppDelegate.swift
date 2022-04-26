//
//  AppDelegate.swift
//  CampApp
//
//  Created by yusuf terzi on 22.09.2021.
//

import UIKit
import Firebase
import YTNetwork
import GooglePlaces

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  lazy var router = MainCoordinator().strongRouter
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    if #available(iOS 13.0, *) {
      window?.overrideUserInterfaceStyle = .light
    } else {
      // Fallback on earlier versions
    }

    FirebaseApp.configure()
    FirebaseNetwork(Firestore.firestore())
    router.setRoot(for: window!)
    GMSPlacesClient.provideAPIKey("AIzaSyDfgZ54ZmQdrnCJKL4wz1Se6IhCi0ac1-0")
    
    SessionHelper.shared.loginAnymous()
    
    return true
  }
  
}

