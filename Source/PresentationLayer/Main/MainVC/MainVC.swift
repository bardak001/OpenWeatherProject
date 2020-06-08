//
//  MainVC.swift
//  OpenWeatherProject
//
//  Created by Радим Гасанов on 04.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    private var temperatureUnit: TemperatureUnit?
    
    var cityModel: CityModel?
    
    private let nameLabel = CustomLabel(text: nil,
                                        fontSize: Constants.nameLabelFontSize)
    
    private let weatherLabel = CustomLabel(text: nil,
                                           fontSize: Constants.weatherLabelFontSize)
    
    private let temperatureLabel = CustomLabel(text: nil,
                                           fontSize: Constants.temperatureLabelFontSize)
    
    init(cityModel: CityModel) {
        super.init(nibName: nil,
                   bundle: nil)
        self.cityModel = cityModel
        
        nameLabel.text = cityModel.name
        weatherLabel.text = cityModel.weather
        
        setupUI()
    }
    
    func updateSettings(settingsModel: SettingsModel?) {
        guard let settingsModel = settingsModel,
            let newTemperatureUnit = TemperatureUnit.init(rawValue: settingsModel.temperatureUnit),
            newTemperatureUnit != temperatureUnit else { return }
        temperatureUnit = newTemperatureUnit
        setupTemt()
    }
    
    func updateWeather(cityModel: CityModel) {
        self.cityModel = cityModel
        
        nameLabel.text = cityModel.name
        weatherLabel.text = cityModel.weather
        setupTemt()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - Functions

extension MainVC {
    
    //MARK: - UI functions
    private func setupUI() {
        view.backgroundColor = .white
        
        //addsubview
        view.addSubview(nameLabel)
        view.addSubview(weatherLabel)
        view.addSubview(temperatureLabel)
        
        //make constraint
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.nameLabelSNPTopOffset)
            $0.centerX.equalToSuperview()
        }
        weatherLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Constants.weatherLabelSNPTopOffset)
            $0.centerX.equalToSuperview()
        }
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(weatherLabel.snp.bottom).offset(Constants.temperatureLabelSNPTopOffset)
            $0.centerX.equalToSuperview()
        }
    }
    //MARK: - @objc functions
    //MARK: - another functions
    private func setupTemt() {
        guard let temp = cityModel?.tempKelvin,
            let temperatureUnit = temperatureUnit else { return }
        temperatureLabel.text = TemperatureConverter.getString(t: temp,
                                                               temperatureUnit: temperatureUnit)
    }
}

//MARK: - Constants
extension MainVC {
    private enum Constants {
        // labels
            // font size
        static let nameLabelFontSize: CGFloat = 35
        static let weatherLabelFontSize: CGFloat = 25
        static let temperatureLabelFontSize: CGFloat = 30
            // snp
        static let nameLabelSNPTopOffset: CGFloat = 50
        static let weatherLabelSNPTopOffset: CGFloat = 30
        static let temperatureLabelSNPTopOffset: CGFloat = 30
    }
    
    private class CustomLabel: UILabel {
        init(text: String?, fontSize: CGFloat?) {
            super.init(frame: .zero)
            self.text = text
            backgroundColor = UIColor.black.withAlphaComponent(0.1)
            font = UIFont.systemFont(ofSize: fontSize ?? 16, weight: .bold)
            textColor = .white
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
