//
//  RealmServiceProtocol.swift
//  OpenWeatherProject
//
//  Created by Радим Гасанов on 04.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmServiceProtocol {
    var realm: Realm { get }
    
    // MARK: - settings
    func getSettings(completion: @escaping (SettingsModel) -> Void)
    func updateSettingsModel(newSettingsModel: SettingsModel)
    
    // MARK: - city model
    func getCityModels(completion: @escaping ([CityModel]) -> Void)
    func saveCityModel(cityModel: CityModel, completion: @escaping (Bool) -> Void)
    func checkHaveCityModel(cityName: String) -> Bool
    func updateCityModel(newCityModel: CityModel)
    func removeCityModel(cityModel: CityModel, completion: @escaping (Bool) -> Void)
}
