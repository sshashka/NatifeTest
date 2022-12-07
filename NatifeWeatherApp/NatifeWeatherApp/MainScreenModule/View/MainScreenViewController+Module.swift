//
//  MainScreenViewController+Modult.swift
//  NatifeWeatherApp
//
//  Created by Саша Василенко on 05.12.2022.
//

import Foundation

extension MainScreenViewController {
    static var module: MainScreenViewController {
        let vc = MainScreenViewController()
        let networkService = MainScreenService()
        let presenter = MainScreenModulePresenter(service: networkService, view: vc)
        vc.presenter = presenter
        return vc
    }
}
