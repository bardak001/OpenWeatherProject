//
//  RealmService.swift
//  OpenWeatherProject
//
//  Created by Радим Гасанов on 04.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService: RealmServiceProtocol {
    
    let realm = try! Realm()
    
    
    // MARK: - settings
    private let settingsModelPrimaryKey = "MainSettings"
    func getSettings(completion: @escaping (SettingsModel) -> Void) {
        if let mainSettings = realm.object(ofType: SettingsModel.self,
                                           forPrimaryKey: settingsModelPrimaryKey) {
            completion(mainSettings)
        } else {
            try! self.realm.write {
                let mainSettings = SettingsModel(type: settingsModelPrimaryKey,
                                                 temperatureUnit: .celsius)
                self.realm.add(mainSettings)
                completion(mainSettings)
            }
        }
    }
    func updateSettingsModel(newSettingsModel: SettingsModel) {
        guard let oldSettingsModel = realm.object(ofType: SettingsModel.self,
                                              forPrimaryKey: settingsModelPrimaryKey) else { return }
        try! self.realm.write {
            oldSettingsModel.temperatureUnit = newSettingsModel.temperatureUnit
        }
    }
    
    // MARK: - city model
    func getCityModels(completion: @escaping ([CityModel]) -> Void) {
        let results = realm.objects(CityModel.self)
        completion(Array(results))
    }
    
    func checkHaveCityModel(cityName: String) -> Bool {
        let cityModel = realm.object(ofType: CityModel.self, forPrimaryKey: cityName)
        return cityModel != nil
    }
    
    func saveCityModel(cityModel: CityModel, completion: @escaping (Bool) -> Void) {
        try! self.realm.write {
            self.realm.add(cityModel, update: .all)
            completion(true)
        }
    }
    
    func updateCityModel(newCityModel: CityModel) {
        guard let oldCityModel = realm.object(ofType: CityModel.self,
                                              forPrimaryKey: newCityModel.name) else { return }
        try! self.realm.write {
            oldCityModel.tempKelvin = newCityModel.tempKelvin
            oldCityModel.weather = newCityModel.weather
        }
    }
    
    func removeCityModel(cityModel: CityModel, completion: @escaping (Bool) -> Void) {
        try! self.realm.write {
            self.realm.delete(cityModel)
            completion(true)
        }
    }
    
}
