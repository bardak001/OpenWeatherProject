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
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let weatherLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    init(cityModel: CityModel) {
        super.init(nibName: nil,
                   bundle: nil)
        self.cityModel = cityModel
        
        nameLabel.text = cityModel.name
        weatherLabel.text = cityModel.weather
        setupTemt()
        
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
            $0.top.equalToSuperview().offset(50)
            $0.centerX.equalToSuperview()
        }
        weatherLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(weatherLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
    }
    //MARK: - @objc functions
    //MARK: - another functions
    private func setupTemt() {
        guard let temp = cityModel?.tempKelvin, let temperatureUnit = temperatureUnit else { return }
        temperatureLabel.text = TemperatureConverter.getString(t: temp,
                                                               temperatureUnit: temperatureUnit)
    }
}

//MARK: - Constants
extension MainVC {
    private enum Constants {}
}
