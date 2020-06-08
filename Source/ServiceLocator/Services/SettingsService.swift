//
//  SettingsService.swift
//  OpenWeatherProject
//
//  Created by Радим Гасанов on 04.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import Foundation

//MARK: - Service
class SettingsServiceImpl {
    
    private var realmService: RealmService
    private var requestManager: RequestManager
    
    init(realmService: RealmService,
         requestManager: RequestManager) {
        self.realmService = realmService
        self.requestManager = requestManager
    }
    
}
//MARK: - Functions
extension SettingsServiceImpl {}
