//
//  MainScreenService.swift
//  NatifeWeatherApp
//
//  Created by Саша Василенко on 04.12.2022.
//

import Foundation

protocol MainScreenServiceProtocol: AnyObject {
    func getCityCodeByCoords(lat: Double, lon: Double, completion: @escaping(CityCodeModel) -> Void)
    func getDailyWeather(code: String, completion: @escaping(DailyWeatherModel) -> Void)
    func getHourlyForecast(lat: Double, lon: Double, completion: @escaping(HourlyWeatherModel) -> Void)
}

class MainScreenService: RestApi {
    
    func linkStringForCityCodeByCoordinates(lat: Double, lon: Double) -> String {
        let coordsString = "\(lat)%2C%20\(lon)"
        return baseURLForCityCodeByCoords + currentWeatherToken + "&q=\(coordsString)"
    }
    
    func linkStringForCityCodeByName(name: String) -> String {
        return baseURLForCityCodeByName + currentWeatherToken + "&q=\(name)"
    }
    
    func linkStringForWeather(code: String) -> String {
        return baseURLForWeather + "\(code)?" + currentWeatherToken + "&metric=true"
    }
    
    func linkStringForHourlyWeatcher(lat: Double, lon: Double) -> String {
        return baseURLForOpenWeatherApi + "lat=\(lat)&lon=\(lon)" + tokenForOpenWeatherApi + "&units=metric"
    }
}

extension MainScreenService: MainScreenServiceProtocol {
    
    func getCityCodeByCoords(lat: Double, lon: Double, completion: @escaping(CityCodeModel) -> Void) {
        let url = URL(string: linkStringForCityCodeByCoordinates(lat: lat, lon: lon))
        guard let url = url else { return }
        print(url)
        let urlRequest = URLRequest(url: url)
        let decoder = JSONDecoder()
        URLSession.shared.dataTask(with: urlRequest) { data, responce, error in
            guard let data = data else { return }
            do {
                let result = try decoder.decode(CityCodeModel.self, from: data)
                completion(result)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getDailyWeather(code: String, completion: @escaping(DailyWeatherModel) -> Void) {
        let url = URL(string: linkStringForWeather(code: code))
        guard let url = url else { return }
        print(url)
        let urlRequest = URLRequest(url: url)
        let decoder = JSONDecoder()
        URLSession.shared.dataTask(with: urlRequest) { data, responce, error in
            guard let data = data else { return }
            do {
                let result = try decoder.decode(DailyWeatherModel.self, from: data)
                DispatchQueue.main.async {
                    completion(result)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getHourlyForecast(lat: Double, lon: Double, completion: @escaping (HourlyWeatherModel) -> Void) {
        let url = URL(string: linkStringForHourlyWeatcher(lat: lat, lon: lon))
        guard let url = url else { return }
        print(url)
        let urlRequest = URLRequest(url: url)
        let decoder = JSONDecoder()
        URLSession.shared.dataTask(with: urlRequest) { data, responce, error in
            guard let data = data else { return }
            do {
                let result = try decoder.decode(HourlyWeatherModel.self, from: data)
                DispatchQueue.main.async {
                    completion(result)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
