//
//  SettingsModel.swift
//  OpenWeatherProject
//
//  Created by Радим Гасанов on 04.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import Foundation
import RealmSwift

class SettingsModel: Object {
    
    @objc dynamic var type = ""
    @objc dynamic var temperatureUnit = TemperatureUnit.celsius.rawValue
    
    convenience init(type: String, temperatureUnit: TemperatureUnit) {
        self.init()
        self.type = type
        self.temperatureUnit = temperatureUnit.rawValue
    }
    override static func primaryKey() -> String? {
        return "type"
    }
}
