//
//  SearchAssembler.swift
//  OpenWeatherProject
//
//  Created by Радим Гасанов on 04.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import UIKit

//MARK: - Assembly
class SearchAssembler {
    static func createModule(serviceLocator: ServiceLocator,
                             moduleOutput: SettingsModuleOutput?) -> UIViewController {
        let view = SearchViewController()
        let state = SearchState()
        let router = SearchRouterImpl(serviceLocator: serviceLocator)
        router.viewController = view
        
        let presenter = SearchPresenterImpl(view: view,
                                            router: router,
                                            state: state,
                                            realmService: serviceLocator.realmService,
                                            searchService: serviceLocator.searchService,
                                            moduleOutput: moduleOutput)
        view.presenter = presenter

        return view
    }
}
