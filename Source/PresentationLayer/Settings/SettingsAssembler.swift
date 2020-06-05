//
//  SettingsAssembler.swift
//  OpenWeatherProject
//
//  Created by Радим Гасанов on 04.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import UIKit

//MARK: - Assembly
class SettingsAssembler {
    static func createModule(serviceLocator: ServiceLocator,
                             moduleOutput: MainModuleOutput?) -> UIViewController {
        let view = SettingsTableViewController(style: .plain)
        let state = SettingsState()
        let router = SettingsRouterImpl(serviceLocator: serviceLocator)
        router.viewController = view
        
        let presenter = SettingsPresenterImpl(view: view,
                                            router: router,
                                            state: state,
                                            realmService: serviceLocator.realmService,
                                            settingsService: serviceLocator.settingsService,
                                            moduleOutput: moduleOutput)
        view.presenter = presenter
        router.moduleOutput = presenter

        return view
    }
}
