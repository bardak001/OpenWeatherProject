//
//  SearchPresenter.swift
//  OpenWeatherProject
//
//  Created by Радим Гасанов on 04.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import UIKit

//MARK: - Presenter
class SearchPresenterImpl: SearchPresenter {
    
    let view: SearchView
    let router: SearchRouter
    let state: SearchState
    
    // MARK: - Service
    var realmService: RealmService
    var searchService: SearchServiceImpl
    
    // MARK: - Output
    var moduleOutput: SettingsModuleOutput?
    
    // MARK: - Init
    init(view: SearchView,
         router: SearchRouter,
         state: SearchState,
         realmService: RealmService,
         searchService: SearchServiceImpl,
         moduleOutput: SettingsModuleOutput?) {
        self.view = view
        self.router = router
        self.state = state
        self.realmService = realmService
        self.searchService = searchService
        self.moduleOutput = moduleOutput
    }
}

//MARK: - Functions
extension SearchPresenterImpl {
    func searchCity(cityName: String?) {
        guard let cityName = cityName else { return }
        
        guard realmService.checkHaveCityModel(cityName: cityName) == false else {
            DispatchQueue.main.async {
                self.view.showAlert(title: "Warning",
                                    message: "We have this is city!!!!!")
            }
            return
        }
        searchService.searchForCityName(cityName: cityName) { cityModel, error in
            guard error == nil,
                let cityModel = cityModel else {
                DispatchQueue.main.async {
                    self.view.showAlert(title: "Warning",
                                        message: error ?? "error")
                }
                return
            }
            DispatchQueue.main.async {
                self.realmService.saveCityModel(cityModel: cityModel) { success in
                    guard success else { return }
//                    self.view.showAlert(title: "Save City",
//                                        message: error ?? "Success")
                    self.moduleOutput?.addCityModel(cityModel: cityModel)
                    self.router.dismiss()
                }
            }
        }
    }
    func cancel() {
        router.dismiss()
    }
}
