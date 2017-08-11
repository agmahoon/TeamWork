//
//  AppDelegate.swift
//  Challenge
//
//  Created by Abdul Ghafoor on 08/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    @IBOutlet var window: UIWindow?
    @IBOutlet var navController: UINavigationController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let project = ProjectsViewController(nibName: "ProjectsViewController", bundle: nil)
        self.navController.setViewControllers([project], animated: true)
        
        self.window?.rootViewController = self.navController
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
    
}
