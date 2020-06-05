//
//  MainAssembler.swift
//  OpenWeatherProject
//
//  Created by Радим Гасанов on 04.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import UIKit

//MARK: - Assembly
class MainAssembler {
    static func createModule(serviceLocator: ServiceLocator) -> UIViewController {
        let view = MainViewController(transitionStyle: .scroll,
                                      navigationOrientation: .horizontal)
        let state = MainState()
        let router = MainRouterImpl(serviceLocator: serviceLocator)
        router.viewController = view
        
        let presenter = MainPresenterImpl(view: view,
                                          router: router,
                                          state: state,
                                          realmService: serviceLocator.realmService,
                                          mainService: serviceLocator.mainService)
        
        router.moduleOutput = presenter
        view.presenter = presenter
        
        return view
    }
}
