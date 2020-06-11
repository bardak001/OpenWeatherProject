//
//  SearchProtocols.swift
//  OpenWeatherProject
//
//  Created by Радим Гасанов on 04.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import UIKit

protocol SearchPresenter: AnyObject {
    func searchCity(cityName: String?)
    func cancel()
}

protocol SearchView: AnyObject {
    func showAlert(title: String, message: String)
}

protocol SearchRouter {
    func dismiss()
}
