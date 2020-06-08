//
//  SwitchSettingsTableViewCell.swift
//  OpenWeatherProject
//
//  Created by Радим Гасанов on 04.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import UIKit

class SwitchSettingsTableViewCell: UITableViewCell {
    
    static let reuseID = "SwitchSettingsTableViewCell"
    
    let tempSegmentController = UISegmentedControl(items: Constants.tempSegmentControllerItems)
    
    let button = UIButton(type: .contactAdd)

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        addSubview(tempSegmentController)
        addSubview(button)
        
        tempSegmentController.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Constants.tempSegmentControllerSNPLeadindOffset)
            $0.centerY.equalToSuperview()
        }
        button.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-Constants.buttonSNPTrailingOffset)
            $0.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: - Constants
extension SwitchSettingsTableViewCell {
    private enum Constants {
        // temp segment controller
        static let tempSegmentControllerItems = [
            TemperatureUnit.celsius.rawValue,
            TemperatureUnit.fahrenheit.rawValue
        ]
        static let tempSegmentControllerSNPLeadindOffset: CGFloat = 20
        // button
        static let buttonSNPTrailingOffset: CGFloat = 20
    }
}
