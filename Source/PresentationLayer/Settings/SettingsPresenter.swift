//
//  SettingsPresenter.swift
//  OpenWeatherProject
//
//  Created by Радим Гасанов on 04.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import UIKit

//MARK: - Presenter
class SettingsPresenterImpl: SettingsPresenter {
    
    let view: SettingsView
    let router: SettingsRouter
    let state: SettingsState
    
    // MARK: - Service
    var realmService: RealmService
    var settingsService: SettingsServiceImpl
    
    // MARK: - Output
    var moduleOutput: MainModuleOutput?
    
    // MARK: - Init
    init(view: SettingsView,
         router: SettingsRouter,
         state: SettingsState,
         realmService: RealmService,
         settingsService: SettingsServiceImpl,
         moduleOutput: MainModuleOutput?) {
        self.view = view
        self.router = router
        self.state = state
        self.realmService = realmService
        self.settingsService = settingsService
        self.moduleOutput = moduleOutput
    }
}

//MARK: - Functions
extension SettingsPresenterImpl {
    
    func getSettings() {
        realmService.getSettings { settingsModel in
            self.view.setSettingsModel(settingsModel: settingsModel)
        }
    }
    
    func getCityModels() {
        realmService.getCityModels { cityModels in
            self.view.setCityModels(cityModels: cityModels)
        }
    }
    
    func removeCityModel(cityModel: CityModel, completion: @escaping (Bool) -> Void) {
        realmService.removeCityModel(cityModel: cityModel) { success in
            self.moduleOutput?.refreshCityModels()
            completion(success)
        }
    }
    
    func addButtonTouchUpInside() {
        router.navToSearchModule()
    }
    
    func changeTemperatureUnit(temperatureUnit: TemperatureUnit) {
        let newSettingsModel = SettingsModel(type: "", temperatureUnit: temperatureUnit)
        realmService.updateSettingsModel(newSettingsModel: newSettingsModel)
        moduleOutput?.changeTemperatureUnit(temperatureUnit: temperatureUnit)
    }
}

//MARK: - SettingsModuleOutput
extension SettingsPresenterImpl: SettingsModuleOutput {
    func addCityModel(cityModel: CityModel) {
        moduleOutput?.refreshCityModels()
        view.setCityModel(cityModel: cityModel)
    }
}
