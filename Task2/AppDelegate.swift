//
//  AppDelegate.swift
//  Task2
//
//  Created by student on 8/2/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var vc = ViewController()
    
    
    func applicationWillTerminate(_ application: UIApplication) {
              vc.saveApp()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        vc.loadApp()
    }
    
}

