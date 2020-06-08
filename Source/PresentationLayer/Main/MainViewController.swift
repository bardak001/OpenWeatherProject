//
//  MainViewController.swift
//  OpenWeatherProject
//
//  Created by Радим Гасанов on 04.06.2020.
//  Copyright © 2020 Радим Гасанов. All rights reserved.
//

import UIKit

//MARK: - ViewController
class MainViewController: UIPageViewController {
    
    var presenter: MainPresenter?
    
    private let pageControl = UIPageControl.appearance()
    
    private var currentViewController: MainVC?
    private var currentIndex = 0
    
    private var settingsModel: SettingsModel?
    private var cityModels = [CityModel]()
    private var arrayViewController = [MainVC]()
    
    private let addLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.addLabelText
        label.font = Constants.addLabelFont
        return label
    }()
    
    private let settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.settingsButtonImage,
                        for: .normal)
        button.setImage(Constants.settingsButtonImage?.withRenderingMode(.alwaysTemplate),
                        for: .highlighted)
        button.addTarget(self,
                         action: #selector(settingsButtonTouchUpInside),
                         for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getSettings()
        presenter?.getCityModels()
        setupUI()
    }
    
}
//MARK: - Functions

extension MainViewController {
    
    //MARK: - UI functions
    private func setupUI() {
        pageControl.pageIndicatorTintColor = Constants.pageIndicatorTintColor
        pageControl.currentPageIndicatorTintColor = Constants.currentPageIndicatorTintColor
        dataSource = self
        delegate = self
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        //addsubview
        view.addSubview(addLabel)
        view.addSubview(settingsButton)
        
        //make constraint
        addLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        settingsButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-Constants.settingsButtonSNPTrailingOffset)
            $0.bottom.equalToSuperview().offset(-Constants.settingsButtonSNPBottomOffset)
            $0.width.height.equalTo(Constants.settingsButtonSNPSize)
        }
    }
    //MARK: - @objc functions
    //MARK: - another functions
    @objc private func settingsButtonTouchUpInside() {
        presenter?.settingsButtonTouchUpInside()
    }
}
//MARK: - View
extension MainViewController: MainView {
    func setSettingsModel(settingsModel: SettingsModel) {
        self.settingsModel = settingsModel
        for vc in arrayViewController {
            vc.updateSettings(settingsModel: settingsModel)
        }
    }
    func setCityModels(cityModels: [CityModel]) {
        self.cityModels = cityModels
        self.cityModels.sort(by: {$0.name > $1.name} )
        if let currentVC = currentViewController {
            currentIndex = cityModels.firstIndex(where: {$0.name == currentVC.cityModel?.name}) ?? 0
            switch currentIndex {
            case cityModels.count:
                currentIndex -= 1
            default:
                break
            }
        } else if currentIndex != 0 {
            switch currentIndex {
            case cityModels.count:
                currentIndex -= 1
            default:
                break
            }
        } else {
            currentIndex = 0
        }
        
        currentViewController = nil
        arrayViewController.removeAll()
        addLabel.isHidden = !cityModels.isEmpty
        
        for cityModel in cityModels {
            let vc = MainVC(cityModel: cityModel)
            arrayViewController.append(vc)
        }
        guard arrayViewController.count > 0 else { return }
        
        let vc = arrayViewController[0 <= currentIndex ? currentIndex : 0]
        setViewControllers([vc],
                           direction: .forward,
                           animated: true,
                           completion: nil)
        currentViewController = vc
    }
    func updateCityModel(cityModel: CityModel) {
        for vc in arrayViewController {
            if vc.cityModel?.name == cityModel.name {
                vc.updateSettings(settingsModel: self.settingsModel)
                vc.updateWeather(cityModel: cityModel)
            }
        }
    }
}

//MARK: - UIPageViewControllerDelegate
extension MainViewController: UIPageViewControllerDelegate {
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return arrayViewController.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard completed,
            let vc = pageViewController.viewControllers?.first as? MainVC,
            let index = arrayViewController.firstIndex(of: vc) else { return }
        currentIndex = index
        currentViewController = vc
    }
}

//MARK: - UIPageViewControllerDataSource
extension MainViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? MainVC,
            let index = arrayViewController.firstIndex(of: viewController),
            index > 0 else { return nil }
        return arrayViewController[index - 1]
        
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? MainVC,
            let index = arrayViewController.firstIndex(of: viewController),
            index < arrayViewController.count - 1 else { return nil }
        return arrayViewController[index + 1]
    }
}

//MARK: - Constants
extension MainViewController {
    private enum Constants {
        // add label
        static let addLabelText = "ДОБАВЬТЕ ГОРОД"
        static let addLabelFont = UIFont.systemFont(ofSize: 20, weight: .bold)
        // settings button
        static let settingsButtonImage = UIImage(named: "settingsButton")
        static let settingsButtonSNPTrailingOffset: CGFloat = 30
        static let settingsButtonSNPBottomOffset: CGFloat = 40
        static let settingsButtonSNPSize: CGFloat = 20
        
        static let pageIndicatorTintColor = UIColor.lightGray
        static let currentPageIndicatorTintColor = UIColor.red
    }
}
