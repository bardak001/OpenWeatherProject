//
//  DefaultServiceLocator.swift
//  OpenWeatherProject
//
//  Created by Радим Гасанов on 04.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

class DefaultServiceLocator: ServiceLocator {
    var realmService: RealmService = RealmService()
    private let requestManager = RequestManager()
    
    lazy var mainService = MainServiceImpl(realmService: realmService,
                                           requestManager: requestManager)
    lazy var settingsService = SettingsServiceImpl(realmService: realmService,
                                               requestManager: requestManager)
    lazy var searchService = SearchServiceImpl(realmService: realmService,
                                               requestManager: requestManager)
}
