//
//  ainScreenModulePresenter.swift
//  NatifeWeatherApp
//
//  Created by Саша Василенко on 05.12.2022.
//

import Foundation
protocol MainScreenModuleViewProtocol: AnyObject {
    func showDailyWeather(weather: DailyWeatherModel)
    func passHourlyWeather(weather: HourlyWeatherModel)
}
 
protocol MainScreenModulePresenterProtocol: AnyObject {
    func getCityCodeByLocation(lat: Double, lon: Double)
    func convertStringToDate(date: String, to: String) -> String
    func getHourlyWeather(lat: Double, lon: Double)
}

class MainScreenModulePresenter: MainScreenModulePresenterProtocol {
    
    let service: MainScreenServiceProtocol
    weak var view: MainScreenModuleViewProtocol?
    private var cityName: String?
    private var cityCode: String? {
        didSet {
            getWeather()
        }
    }
    
    init(service: MainScreenServiceProtocol, view: MainScreenModuleViewProtocol) {
        self.service = service
        self.view = view
    }
    
    func getCityCodeByLocation(lat: Double, lon: Double) {
        service.getCityCodeByCoords(lat: lat, lon: lon, completion: { [weak self] result in
            self?.cityCode = result.key
            self?.cityName = result.englishName
        })
    }
    
    
    func getWeather() {
        guard let cityCode = cityCode else { return }
        service.getDailyWeather(code: cityCode) {[weak self] result in
            self?.view?.showDailyWeather(weather: result)
        }
    }
    
    func convertStringToDate(date: String, to format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:date)!
        
        dateFormatter.dateFormat = format
        let dateToShow = dateFormatter.string(from: date)
        return dateToShow
    }
    
    func getHourlyWeather(lat: Double, lon: Double) {
        service.getHourlyForecast(lat: lat, lon: lon, completion: {[weak self] result in
            self?.view?.passHourlyWeather(weather: result)
        })
    }
}
