//
//  SettingsRouter.swift
//  OpenWeatherProject
//
//  Created by Радим Гасанов on 04.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import UIKit

//MARK: - Router
final class SettingsRouterImpl: SettingsRouter {

    weak var viewController: UIViewController?
    
    private let serviceLocator: ServiceLocator
    
    // MARK: - Output
    weak var moduleOutput: SettingsModuleOutput?
    
    init(serviceLocator: ServiceLocator) {
        self.serviceLocator = serviceLocator
    }
}

//MARK: - Functions
extension SettingsRouterImpl {
    func navToSearchModule() {
        let vc = SearchAssembler.createModule(serviceLocator: serviceLocator,
                                              moduleOutput: moduleOutput)
        viewController?.present(vc,
                                animated: true,
                                completion: nil)
    }
}
