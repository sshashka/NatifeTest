//
//  API.swift
//  NatifeWeatherApp
//
//  Created by Саша Василенко on 04.12.2022.
//

import Foundation

class RestApi {
    let baseURLForWeather = "https://dataservice.accuweather.com/forecasts/v1/daily/5day/"
    let baseURLForCityCodeByCoords = "https://dataservice.accuweather.com/locations/v1/cities/geoposition/search?"
    let baseURLForCityCodeByName = "https://dataservice.accuweather.com/locations/v1/cities/search?"
    let currentWeatherToken = "apikey=o3WAJpqZIImbx21ImAOnmM71lsc4jvos"
    let baseURLForOpenWeatherApi = "https://api.openweathermap.org/data/2.5/forecast?"
    let tokenForOpenWeatherApi = "&appid=956fed3ae08968b145f6fabdbceb716c"
}
