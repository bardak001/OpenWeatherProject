//
//  AppDelegate.swift
//  OpenWeatherProject
//
//  Created by Радим Гасанов on 04.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import UIKit
import RealmSwift
import SnapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let serviceLocator = DefaultServiceLocator()

    func application( _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
        ) -> Bool {
        let schemaVersion: UInt64 = 1
        let config = Realm.Configuration(
            schemaVersion: schemaVersion,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < schemaVersion) {
                }
        })

        Realm.Configuration.defaultConfiguration = config
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
        self.window = window
        
        let vc = MainAssembler.createModule(serviceLocator: serviceLocator)
//        let navigationController = UINavigationController(rootViewController: vc)
        window.rootViewController = vc //navigationController
        window.makeKeyAndVisible()
        
        return true
    }
    
}
