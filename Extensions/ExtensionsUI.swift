//
//  ExtensionsUI.swift
//  OpenWeatherProject
//
//  Created by Радим Гасанов on 08.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import UIKit

//MARK: - UIViewController
extension UIViewController {
    override open func touchesBegan(_ touches: Set<UITouch>,
                                    with event: UIEvent?) {
        view.endEditing(true)
    }
}
