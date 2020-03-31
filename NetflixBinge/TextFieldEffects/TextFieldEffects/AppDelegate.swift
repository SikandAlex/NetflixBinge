//
//  AppDelegate.swift
//  NetflixBinge
//
//  Created by Alex Sikand on 3/26/20.
//  Copyright © 2020 CS411. All rights reserved.
//

import UIKit
import Firebase
import Hero
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
   

    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }

    

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        let handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                //self.navigationController.popToRootViewController(animated: true)
                print("Changed")
            }
            else {
                
                print("user exists")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewController = storyboard.instantiateViewController(withIdentifier: "loginVC")
                self.window?.rootViewController = initialViewController
                self.window?.makeKeyAndVisible()
                //self.navigationController?.popToRootViewController(animated: true)
                
                
            }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

  


}

