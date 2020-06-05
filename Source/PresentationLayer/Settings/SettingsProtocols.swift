//
//  SettingsProtocols.swift
//  OpenWeatherProject
//
//  Created by Радим Гасанов on 04.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import UIKit

protocol SettingsPresenter: AnyObject {
    func getSettings()
    func getCityModels()
    func removeCityModel(cityModel: CityModel, completion: @escaping (Bool) -> Void)
    func addButtonTouchUpInside()
    func changeTemperatureUnit(temperatureUnit: TemperatureUnit)
}

protocol SettingsView: AnyObject {
    func setSettingsModel(settingsModel: SettingsModel)
    func setCityModels(cityModels: [CityModel])
    func setCityModel(cityModel: CityModel)
}

protocol SettingsRouter {
    func navToSearchModule()
}

protocol SettingsModuleOutput: AnyObject {
    func addCityModel(cityModel: CityModel)
}
