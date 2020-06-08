//
//  MainService.swift
//  OpenWeatherProject
//
//  Created by Радим Гасанов on 04.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import Foundation

//MARK: - Service
class MainServiceImpl {
    
    private var realmService: RealmService
    private var requestManager: RequestManager
    
    init(realmService: RealmService,
         requestManager: RequestManager) {
        self.realmService = realmService
        self.requestManager = requestManager
    }
    
}
//MARK: - Functions
extension MainServiceImpl {
    func searchForCityName(cityName: String, completion: @escaping (CityModel?, String?) -> Void) {
        let parameters: [String : String] = [
            "q": cityName,
            "appid": "e211178a31f04495e8d169e6b121601c"
        ]
        let headerParameters: [String : String] = [:]
        RequestManager.sendRequest(url: "https://api.openweathermap.org/data/2.5/weather",
                                   parameters: parameters,
                                   headerParameters: headerParameters) { responseObject, error in
            guard let responseObject = responseObject,
                error == nil, responseObject["cod"] as? Int == 200 else {
                    completion(nil,
                               error?.localizedDescription ?? "error!")
                return
            }
            let name = responseObject["name"] as? String ?? "UNKNOWNED NAME"
            let main = responseObject["main"] as? [String: Any] ?? [:]
            let tempKelvin = main["temp"] as? Double ?? -1000000
            let weather = responseObject["weather"] as? [[String: Any]] ?? [[:]]
            var description = ""
            for i in weather {
                if let descript = i["description"] as? String {
                    description = descript
                }
            }
            let cityModel = CityModel(name: name,
                                      tempKelvin: tempKelvin,
                                      weather: description)
            completion(cityModel,
                       nil)
        }
    }
}
