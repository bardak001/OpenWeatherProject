//
//  SearchViewController.swift
//  OpenWeatherProject
//
//  Created by Радим Гасанов on 04.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import UIKit

//MARK: - ViewController
class SearchViewController: UIViewController {
    
    var presenter: SearchPresenter?
    
    private var alertController: UIAlertController?
    
    private let enterCityLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.enterCityText
        label.font = Constants.enterCityFont
        label.textColor = Constants.enterCityTextColor
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.textFieldPlaceholder
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        return textField
    }()
    
    private let okButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.okButtonTitle,
                        for: .normal)
        button.setTitleColor(Constants.buttonTitleColorForNormal,
                             for: .normal)
        button.setTitleColor(Constants.buttonTitleColorForHighlighted,
                             for: .highlighted)
        button.addTarget(self,
                         action: #selector(okButtonTouchUpInside),
                         for: .touchUpInside)
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.cancelButtonTitle,
                        for: .normal)
        button.setTitleColor(Constants.buttonTitleColorForNormal,
                             for: .normal)
        button.setTitleColor(Constants.buttonTitleColorForHighlighted,
                             for: .highlighted)
        button.addTarget(self,
                         action: #selector(cancelButtonTouchUpInside),
                         for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//MARK: - Functions

extension SearchViewController {
    
    //MARK: - UI functions
    private func setupUI() {
        view.backgroundColor = .white
        
        //addsubview
        view.addSubview(enterCityLabel)
        view.addSubview(textField)
        view.addSubview(okButton)
        view.addSubview(cancelButton)
        
        //make constraint
        enterCityLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.enterCityLabelSNPTopOffset)
            $0.leading.equalToSuperview().offset(Constants.enterCityLabelSNPLeadingOffset)
        }
        textField.snp.makeConstraints {
            $0.top.equalTo(enterCityLabel.snp.bottom).offset(Constants.textFieldSNPTopOffset)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().offset(-Constants.textFieldSNPWidthOffset)
        }
        okButton.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(Constants.okButtonSNPTopOffset)
            $0.trailing.equalTo(view.snp.centerX).offset(-Constants.okButtonSNTrailingOffset)
        }
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(Constants.cancelButtonSNPTopOffset)
            $0.leading.equalTo(view.snp.centerX).offset(Constants.cancelButtonSNLeadingOffset)
        }
    }
    //MARK: - @objc functions
    @objc private func okButtonTouchUpInside() {
        presenter?.searchCity(cityName: textField.text)
    }
    
    @objc private func cancelButtonTouchUpInside() {
        textField.text = nil
        presenter?.cancel()
    }
    //MARK: - another functions
}

//MARK: - View
extension SearchViewController: SearchView {
    func showAlert(title: String,
                   message: String) {
        alertController = UIAlertController(title: title,
                                            message: message,
                                            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: nil)
        alertController?.addAction(action)
        guard let alContr = alertController else { return }
        present(alContr,
                animated: true,
                completion: nil)
    }
}

//MARK: - Constants
extension SearchViewController {
    private enum Constants {
        // enter city
        static let enterCityText = "Введите город"
        static let enterCityFont = UIFont.systemFont(ofSize: 25,
                                                     weight: .bold)
        static let enterCityTextColor = UIColor.black.withAlphaComponent(0.7)
        
        static let enterCityLabelSNPTopOffset: CGFloat = 50
        static let enterCityLabelSNPLeadingOffset: CGFloat = 10
        
        // textfield
        static let textFieldPlaceholder = "City"
        
        static let textFieldSNPTopOffset: CGFloat = 20
        static let textFieldSNPWidthOffset: CGFloat = 20
        
        // ok button
        static let okButtonTitle = "Ok"
        
        static let okButtonSNPTopOffset: CGFloat = 20
        static let okButtonSNTrailingOffset: CGFloat = 20
        
        // cancel button
        static let cancelButtonTitle = "Cancel"
        
        static let cancelButtonSNPTopOffset: CGFloat = 20
        static let cancelButtonSNLeadingOffset: CGFloat = 20
        
        // buttons
        static let buttonTitleColorForNormal = UIColor.blue
        static let buttonTitleColorForHighlighted = UIColor.lightGray
    }
}
