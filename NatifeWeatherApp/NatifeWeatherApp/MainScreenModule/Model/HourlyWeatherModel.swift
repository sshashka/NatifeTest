//
//  HourlyWeatherModel.swift
//  NatifeWeatherApp
//
//  Created by Саша Василенко on 07.12.2022.
//

import Foundation

// MARK: - HourlyWeatherModel
struct HourlyWeatherModel: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [List]?
    let city: City?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.cod = try container.decodeIfPresent(String.self, forKey: .cod) ?? "NO DATA"
        self.message = try container.decodeIfPresent(Int.self, forKey: .message) ?? 0
        self.cnt = try container.decodeIfPresent(Int.self, forKey: .cnt) ?? 0
        self.list = try container.decodeIfPresent([List].self, forKey: .list)
        self.city = try container.decodeIfPresent(City.self, forKey: .city)
    }
}

// MARK: - City
struct City: Codable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
    let population, timezone, sunrise, sunset: Int?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.coord = try container.decodeIfPresent(Coord.self, forKey: .coord)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.population = try container.decodeIfPresent(Int.self, forKey: .population)
        self.timezone = try container.decodeIfPresent(Int.self, forKey: .timezone)
        self.sunrise = try container.decodeIfPresent(Int.self, forKey: .sunrise)
        self.sunset = try container.decodeIfPresent(Int.self, forKey: .sunset)
    }
}

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lat = try container.decode(Double.self, forKey: .lat)
        self.lon = try container.decode(Double.self, forKey: .lon)
    }
}

// MARK: - List
struct List: Codable {
    let dt: Int
    let main: MainClass
    let weather: [Weather]
    let clouds: Clouds
    let wind: HourlyWind
    let visibility: Int
    let pop: Double
    let snow: Rain?
    let sys: Sys?
    let dtTxt: String?
    let rain: Rain?
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, snow, sys
        case dtTxt = "dt_txt"
        case rain
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.dt = try container.decode(Int.self, forKey: .dt)
        self.main = try container.decode(MainClass.self, forKey: .main)
        self.weather = try container.decode([Weather].self, forKey: .weather)
        self.clouds = try container.decode(Clouds.self, forKey: .clouds)
        self.wind = try container.decode(HourlyWind.self, forKey: .wind)
        self.visibility = try container.decode(Int.self, forKey: .visibility)
        self.pop = try container.decode(Double.self, forKey: .pop)
        self.snow = try container.decodeIfPresent(Rain.self, forKey: .snow)
        self.sys = try container.decodeIfPresent(Sys.self, forKey: .sys)
        self.dtTxt = try container.decodeIfPresent(String.self, forKey: .dtTxt)
        self.rain = try container.decodeIfPresent(Rain.self, forKey: .rain)
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.temp = try container.decode(Double.self, forKey: .temp)
        self.feelsLike = try container.decode(Double.self, forKey: .feelsLike)
        self.tempMin = try container.decode(Double.self, forKey: .tempMin)
        self.tempMax = try container.decode(Double.self, forKey: .tempMax)
        self.pressure = try container.decode(Int.self, forKey: .pressure)
        self.seaLevel = try container.decode(Int.self, forKey: .seaLevel)
        self.grndLevel = try container.decode(Int.self, forKey: .grndLevel)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
        self.tempKf = try container.decode(Double.self, forKey: .tempKf)
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the3H: Double
    
    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.the3H = try container.decode(Double.self, forKey: .the3H)
    }
}

// MARK: - Sys
struct Sys: Codable {
    let pod: Pod
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: String
    let weatherDescription: String
    let icon: Icons
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.main = try container.decode(String.self, forKey: .main)
        self.weatherDescription = try container.decode(String.self, forKey: .weatherDescription)
        self.icon = try container.decode(Icons.self, forKey: .icon)
    }
}

// MARK: - Wind
struct HourlyWind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}


enum Icons: String, Codable {
    case clearSky = "01d"
    case clearSkyNight = "01n"
    case fewClouds = "02d"
    case fewCloudsNight = "02n"
    case scatteredClouds = "03d"
    case scatteredCloudsNight = "03n"
    case brokenClouds = "04d"
    case brokenCloudsNight = "04n"
    case showerRain = "09d"
    case showerRainNight = "09n"
    case rain = "10d"
    case rainNight = "10n"
    case thunderstorm = "11d"
    case thunderstormNight = "11n"
    case snow = "13d"
    case snowNight = "13n"
    case mist = "50d"
    case mistNight = "50n"
    
    var image: String {
        switch self {
        case .clearSky:
            return "ic_white_day_bright"
        case .fewClouds:
            return "ic_white_day_cloudy"
        case .scatteredClouds:
            return "ic_white_day_cloudy"
        case .brokenClouds:
            return "ic_white_day_cloudy"
        case .showerRain:
            return "ic_white_day_shower"
        case .rain:
            return "ic_white_day_rain"
        case .thunderstorm:
            return "ic_white_day_thunder"
        case .snow:
            return "snow"
        case .mist:
            return "mist"
        case .clearSkyNight:
            return "ic_white_night_bright"
        case .fewCloudsNight:
            return "ic_white_night_cloudy"
        case .scatteredCloudsNight:
            return "ic_white_night_cloudy"
        case .brokenCloudsNight:
            return "ic_white_night_cloudy"
        case .showerRainNight:
            return "ic_white_night_shower"
        case .rainNight:
            return "ic_white_night_rain"
        case .thunderstormNight:
            return "ic_white_night_thunder"
        case .snowNight:
            return "snow"
        case .mistNight:
            return "mist"
        }
    }
}
