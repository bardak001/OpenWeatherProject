//
//  SearchRouter.swift
//  OpenWeatherProject
//
//  Created by Радим Гасанов on 04.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import UIKit

//MARK: - Router
final class SearchRouterImpl: SearchRouter {

    weak var viewController: UIViewController?
    
    private let serviceLocator: ServiceLocator
    
    init(serviceLocator: ServiceLocator) {
        self.serviceLocator = serviceLocator
    }
}

//MARK: - Functions
extension SearchRouterImpl {
    func dismiss() {
        viewController?.dismiss(animated: true,
                                completion: nil)
    }
}
