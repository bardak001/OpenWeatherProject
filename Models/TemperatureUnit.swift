//
//  Temperature.swift
//  OpenWeatherProject
//
//  Created by Радим Гасанов on 04.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import Foundation

enum TemperatureUnit: String, CaseIterable {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
}

class TemperatureConverter {
    class func getString(t: Double, temperatureUnit: TemperatureUnit) -> String {
        switch temperatureUnit {
        case .celsius:
            return String(format: "%.1f", t - 273.15) + " C"
        case .fahrenheit:
            return String(format: "%.1f", (t - 273.15) * 9 / 5 + 32) + " F"
        }
    }
}
