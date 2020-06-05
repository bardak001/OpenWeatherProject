//
//  MainProtocols.swift
//  OpenWeatherProject
//
//  Created by Радим Гасанов on 04.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import UIKit

protocol MainPresenter: AnyObject {
    func getSettings()
    func getCityModels()
    func settingsButtonTouchUpInside()
}

protocol MainView: AnyObject {
    func setSettingsModel(settingsModel: SettingsModel)
    func setCityModels(cityModels: [CityModel])
    func updateCityModel(cityModel: CityModel)
}

protocol MainRouter {
    func navToSettings()
}

protocol MainModuleOutput: AnyObject {
    func refreshCityModels()
    func changeTemperatureUnit(temperatureUnit: TemperatureUnit)
}
