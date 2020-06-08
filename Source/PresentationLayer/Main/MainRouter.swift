//
//  MainRouter.swift
//  OpenWeatherProject
//
//  Created by Радим Гасанов on 04.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import UIKit

//MARK: - Router
final class MainRouterImpl: MainRouter {

    weak var viewController: UIViewController?
    
    private let serviceLocator: ServiceLocator
    
    // MARK: - Output
    weak var moduleOutput: MainModuleOutput?
    
    init(serviceLocator: ServiceLocator) {
        self.serviceLocator = serviceLocator
    }
}

//MARK: - Functions
extension MainRouterImpl {
    func navToSettings() {
        let vc = SettingsAssembler.createModule(serviceLocator: serviceLocator,
                                                moduleOutput: moduleOutput)
        viewController?.present(vc, animated: true, completion: nil)
    }
}
