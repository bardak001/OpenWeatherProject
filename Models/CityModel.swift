//
//  CityModel.swift
//  OpenWeatherProject
//
//  Created by Радим Гасанов on 04.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import Foundation
import RealmSwift

class CityModel: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var tempKelvin = 0.0
    @objc dynamic var weather = ""
    
    convenience init(name: String, tempKelvin: Double, weather: String) {
        self.init()
        self.name = name
        self.tempKelvin = tempKelvin
        self.weather = weather
    }
    
    override static func primaryKey() -> String? {
        return "name"
    }
}
