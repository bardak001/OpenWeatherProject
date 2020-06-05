//
//  ServiceLocator.swift
//  OpenWeatherProject
//
//  Created by Радим Гасанов on 04.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

protocol ServiceLocator {
    var realmService: RealmService { get }
    
    var mainService: MainServiceImpl { get }
    var settingsService: SettingsServiceImpl { get }
    var searchService: SearchServiceImpl { get }
}
