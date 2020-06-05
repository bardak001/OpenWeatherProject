//
//  SettingsViewController.swift
//  OpenWeatherProject
//
//  Created by Радим Гасанов on 04.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import UIKit

//MARK: - ViewController
class SettingsTableViewController: UITableViewController {
    
    var presenter: SettingsPresenter?
    
    private let reuseID = "cell"
    
    private var temperatureUnit: TemperatureUnit?
    private var cityModels = [CityModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: reuseID)
        tableView.register(SwitchSettingsTableViewCell.self,
                           forCellReuseIdentifier: SwitchSettingsTableViewCell.reuseID)
        presenter?.getSettings()
        presenter?.getCityModels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.performBatchUpdates(nil,
                                      completion: nil)
    }
    
    @objc private func changeTemp(_ sender: UISegmentedControl) {
        guard let title = sender.titleForSegment(at: sender.selectedSegmentIndex),
        let temperatureUnit = TemperatureUnit.init(rawValue: title) else { return }
        presenter?.changeTemperatureUnit(temperatureUnit: temperatureUnit)
        self.temperatureUnit = temperatureUnit
        for i in 0 ..< cityModels.count {
            let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0))
            let text = cityModels[i].name + "   " + TemperatureConverter.getString(t: cityModels[i].tempKelvin, temperatureUnit: temperatureUnit)
            cell?.textLabel?.text = text
        }
    }
    
    @objc private func addButtonTouchUpInside() {
        presenter?.addButtonTouchUpInside()
    }
}
    // MARK: - Table view data source
extension SettingsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityModels.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        if row == cityModels.count,
            let cell = tableView.dequeueReusableCell(withIdentifier: SwitchSettingsTableViewCell.reuseID, for: indexPath) as? SwitchSettingsTableViewCell {
            cell.tempSegmentController.addTarget(self, action: #selector(changeTemp), for: .valueChanged)
            cell.button.addTarget(self, action: #selector(addButtonTouchUpInside), for: .touchUpInside)
            
            if cell.tempSegmentController.selectedSegmentIndex <= 0 {
                for i in 0 ..< cell.tempSegmentController.numberOfSegments {
                    if let title = cell.tempSegmentController.titleForSegment(at: i),
                        let tempUnit = TemperatureUnit.init(rawValue: title),
                        tempUnit == temperatureUnit {
                        cell.tempSegmentController.selectedSegmentIndex = i
                        break

                    }
                }
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath)
            cell.selectionStyle = .none
            let cityModel = cityModels[row]
            if let temperatureUnit = temperatureUnit {
                cell.textLabel?.text = cityModel.name + "   " + TemperatureConverter.getString(t: cityModel.tempKelvin,
                                                                                               temperatureUnit: temperatureUnit)
            } else {
                cell.textLabel?.text = cityModel.name
            }
            return cell
        }
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - Table view delegate
extension SettingsTableViewController {
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard indexPath.row < cityModels.count else {
            return }
        let cityModel = cityModels[indexPath.row]
        presenter?.removeCityModel(cityModel: cityModel, completion: { success in
            guard success else { return }
            self.cityModels.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        })
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return indexPath.row == cityModels.count ? .none : .delete
    }
}

//MARK: - View
extension SettingsTableViewController: SettingsView {
    func setSettingsModel(settingsModel: SettingsModel) {
        guard let temperatureUnit = TemperatureUnit(rawValue: settingsModel.temperatureUnit) else { return }
        self.temperatureUnit = temperatureUnit
        for i in 0 ..< cityModels.count {
            let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0))
            let text = cityModels[i].name + "   " + TemperatureConverter.getString(t: cityModels[i].tempKelvin,
                                                                                   temperatureUnit: temperatureUnit)
            cell?.textLabel?.text = text
        }
        
        if let cell = tableView.cellForRow(at: IndexPath(row: cityModels.count, section: 0)) as? SwitchSettingsTableViewCell,
            cell.tempSegmentController.selectedSegmentIndex <= 0 {
            for i in 0 ..< cell.tempSegmentController.numberOfSegments {
                if let title = cell.tempSegmentController.titleForSegment(at: i),
                    let tempUnit = TemperatureUnit.init(rawValue: title),
                    tempUnit == temperatureUnit {
                    cell.tempSegmentController.selectedSegmentIndex = i
                    break

                }
            }
        }
        
    }
    func setCityModels(cityModels: [CityModel]) {
        self.cityModels = cityModels
        tableView.reloadData()
    }
    func setCityModel(cityModel: CityModel) {
        cityModels.append(cityModel)
        tableView.insertRows(at: [IndexPath(row: cityModels.count - 1,
                                            section: 0)],
                             with: .automatic)
    }
}

//MARK: - Constants
extension SettingsTableViewController {
    private enum Constants {}
}
