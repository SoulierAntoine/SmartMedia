//
//  AppDelegate.swift
//  SmartMedia
//
//  Created by Soulier Antoine on 24/11/2016.
//  Copyright © 2016 antoine.soulier. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let nv = NavigationController();
        let mediaController = MediaController();
        
        nv.viewControllers = [mediaController];
        
        let w:UIWindow = UIWindow(frame: UIScreen.main.bounds);
        
        w.rootViewController = nv;
        self.window?.makeKeyAndVisible();
        self.window = w;
        
        return true
    }
}

