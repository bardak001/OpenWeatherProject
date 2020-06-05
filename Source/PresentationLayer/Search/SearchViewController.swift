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
        label.text = "Введите город"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = UIColor.black.withAlphaComponent(0.7)
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "city"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        return textField
    }()
    
    private let okButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ok", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.addTarget(self, action: #selector(okButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.addTarget(self, action: #selector(cancelButtonTouchUpInside), for: .touchUpInside)
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
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalToSuperview().offset(10)
        }
        textField.snp.makeConstraints {
            $0.top.equalTo(enterCityLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().offset(-20)
        }
        okButton.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(20)
            $0.trailing.equalTo(view.snp.centerX).offset(-20)
        }
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(20)
            $0.leading.equalTo(view.snp.centerX).offset(20)
        }
    }
    //MARK: - @objc functions
    @objc private func okButtonTouchUpInside() {
        presenter?.searchCity(cityName: textField.text)
    }
    
    @objc private func cancelButtonTouchUpInside() {
        textField.text = nil
    }
    //MARK: - another functions
}

//MARK: - View
extension SearchViewController: SearchView {
    func showAlert(title: String, message: String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController?.addAction(action)
        guard let alContr = alertController else { return }
        present(alContr, animated: true, completion: nil)
    }
}

//MARK: - Constants
extension SearchViewController {
    private enum Constants {}
}

extension UIViewController {
    override open func touchesBegan(_ touches: Set<UITouch>,
                                    with event: UIEvent?) {
        view.endEditing(true)
    }
}
