//
//  MainPresenter.swift
//  OpenWeatherProject
//
//  Created by Радим Гасанов on 04.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import UIKit

//MARK: - Presenter
class MainPresenterImpl: MainPresenter {
    
    let view: MainView
    let router: MainRouter
    let state: MainState
    
    // MARK: - Service
    var realmService: RealmService
    var mainService: MainServiceImpl
    
    // MARK: - Init
    init(view: MainView,
         router: MainRouter,
         state: MainState,
         realmService: RealmService,
         mainService: MainServiceImpl) {
        self.view = view
        self.router = router
        self.state = state
        self.realmService = realmService
        self.mainService = mainService
    }
}

//MARK: - Functions
extension MainPresenterImpl {
    func getSettings() {
        realmService.getSettings { settingsModel in
            self.view.setSettingsModel(settingsModel: settingsModel)
        }
    }
    
    func getCityModels() {
//        realmService.getSettings { settingsModel in
//            self.view.setSettingsModel(settingsModel: settingsModel)
//        }
        realmService.getCityModels { cityModels in
            self.view.setCityModels(cityModels: cityModels)
            for cityModel in cityModels {
                self.mainService.searchForCityName(cityName: cityModel.name) { (getCityModel, error) in
                    guard error == nil,
                        let newCityModel = getCityModel else { return }
                    DispatchQueue.main.async {
                        self.realmService.updateCityModel(newCityModel: newCityModel)
                        self.view.updateCityModel(cityModel: newCityModel)
                    }
                }
            }
        }
    }
    func settingsButtonTouchUpInside() {
        self.router.navToSettings()
    }
}

//MARK: - MainModuleOutput
extension MainPresenterImpl: MainModuleOutput {
    func refreshCityModels() {
        getCityModels()
    }
    func changeTemperatureUnit(temperatureUnit: TemperatureUnit) {
        view.setSettingsModel(settingsModel: SettingsModel(type: "",
                                                           temperatureUnit: temperatureUnit))
    }
}
