// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let dailyWeatherModel = try? newJSONDecoder().decodeIfPresent(DailyWeatherModel.self, from: jsonData)

import Foundation

// MARK: - DailyWeatherModel
struct DailyWeatherModel: Codable {
    let headline: Headline
    let dailyForecasts: [DailyForecast]

    enum CodingKeys: String, CodingKey {
        case headline = "Headline"
        case dailyForecasts = "DailyForecasts"
    }
}

// MARK: - DailyForecast
struct DailyForecast: Codable {
    let date: String
    let epochDate: Int
    let sun: Sun?
    let moon: Moon?
    let temperature, realFeelTemperature, realFeelTemperatureShade: RealFeelTemperature?
    let hoursOfSun: Double
    let degreeDaySummary: DegreeDaySummary?
    let airAndPollen: [AirAndPollen]?
    let day, night: Day?
    let sources: [String]
    let mobileLink, link: String

    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case epochDate = "EpochDate"
        case sun = "Sun"
        case moon = "Moon"
        case temperature = "Temperature"
        case realFeelTemperature = "RealFeelTemperature"
        case realFeelTemperatureShade = "RealFeelTemperatureShade"
        case hoursOfSun = "HoursOfSun"
        case degreeDaySummary = "DegreeDaySummary"
        case airAndPollen = "AirAndPollen"
        case day = "Day"
        case night = "Night"
        case sources = "Sources"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decodeIfPresent(String.self, forKey: .date) ?? "No data"
        self.epochDate = try container.decodeIfPresent(Int.self, forKey: .epochDate) ?? 0
        self.sun = try container.decodeIfPresent(Sun.self, forKey: .sun)
        self.moon = try container.decodeIfPresent(Moon.self, forKey: .moon)
        self.temperature = try container.decodeIfPresent(RealFeelTemperature.self, forKey: .temperature)
        self.realFeelTemperature = try container.decodeIfPresent(RealFeelTemperature.self, forKey: .realFeelTemperature)
        self.realFeelTemperatureShade = try container.decodeIfPresent(RealFeelTemperature.self, forKey: .realFeelTemperatureShade)
        self.hoursOfSun = try container.decodeIfPresent(Double.self, forKey: .hoursOfSun) ?? 0
        self.degreeDaySummary = try container.decodeIfPresent(DegreeDaySummary.self, forKey: .degreeDaySummary)
        self.airAndPollen = try container.decodeIfPresent([AirAndPollen].self, forKey: .airAndPollen)
        self.day = try container.decodeIfPresent(Day.self, forKey: .day)
        self.night = try container.decodeIfPresent(Day.self, forKey: .night)
        self.sources = try container.decodeIfPresent([String].self, forKey: .sources) ?? ["No data"]
        self.mobileLink = try container.decodeIfPresent(String.self, forKey: .mobileLink) ?? "No data"
        self.link = try container.decodeIfPresent(String.self, forKey: .link) ?? "No data"
    }
}

// MARK: - AirAndPollen
struct AirAndPollen: Codable {
    let name: String
    let value: Int
    let category: Category?
    let categoryValue: Int
    let type: String?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case value = "Value"
        case category = "Category"
        case categoryValue = "CategoryValue"
        case type = "Type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "No data"
        self.value = try container.decodeIfPresent(Int.self, forKey: .value) ?? 0
        self.category = try container.decodeIfPresent(Category.self, forKey: .category)
        self.categoryValue = try container.decodeIfPresent(Int.self, forKey: .categoryValue) ?? 0
        self.type = try container.decodeIfPresent(String.self, forKey: .type) ?? "No data"
    }
}

enum Category: String, Codable {
    case good = "Good"
    case low = "Low"
}

// MARK: - Day
struct Day: Codable {
    let icon: Int
    let iconPhrase: String
    let hasPrecipitation: Bool
    let shortPhrase, longPhrase: String
    let precipitationProbability, thunderstormProbability, rainProbability, snowProbability: Int
    let iceProbability: Int
    let wind, windGust: Wind?
    let totalLiquid, rain, snow, ice: Evapotranspiration?
    let hoursOfPrecipitation, hoursOfRain: Double
    let hoursOfSnow, hoursOfIce, cloudCover: Int
    let evapotranspiration, solarIrradiance: Evapotranspiration?
    let precipitationType, precipitationIntensity: String?

    enum CodingKeys: String, CodingKey {
        case icon = "Icon"
        case iconPhrase = "IconPhrase"
        case hasPrecipitation = "HasPrecipitation"
        case shortPhrase = "ShortPhrase"
        case longPhrase = "LongPhrase"
        case precipitationProbability = "PrecipitationProbability"
        case thunderstormProbability = "ThunderstormProbability"
        case rainProbability = "RainProbability"
        case snowProbability = "SnowProbability"
        case iceProbability = "IceProbability"
        case wind = "Wind"
        case windGust = "WindGust"
        case totalLiquid = "TotalLiquid"
        case rain = "Rain"
        case snow = "Snow"
        case ice = "Ice"
        case hoursOfPrecipitation = "HoursOfPrecipitation"
        case hoursOfRain = "HoursOfRain"
        case hoursOfSnow = "HoursOfSnow"
        case hoursOfIce = "HoursOfIce"
        case cloudCover = "CloudCover"
        case evapotranspiration = "Evapotranspiration"
        case solarIrradiance = "SolarIrradiance"
        case precipitationType = "PrecipitationType"
        case precipitationIntensity = "PrecipitationIntensity"
    }
    
    var image: String {
        switch self.icon {
        case 1...5:
            return "ic_white_day_bright"
        case 6...11:
            return "ic_white_day_cloudy"
        case 12...14:
            return "ic_white_day_shower"
        case 18:
            return "ic_white_day_rain"
        case 15...17:
            return "ic_white_day_thunder"
        case 29:
            return "snow"
        default:
            return "ic_white_day_bright"
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.icon = try container.decodeIfPresent(Int.self, forKey: .icon) ?? 0
        self.iconPhrase = try container.decodeIfPresent(String.self, forKey: .iconPhrase) ?? "No data"
        self.hasPrecipitation = try container.decodeIfPresent(Bool.self, forKey: .hasPrecipitation) ?? false
        self.shortPhrase = try container.decodeIfPresent(String.self, forKey: .shortPhrase) ?? "No data"
        self.longPhrase = try container.decodeIfPresent(String.self, forKey: .longPhrase) ?? "No data"
        self.precipitationProbability = try container.decodeIfPresent(Int.self, forKey: .precipitationProbability) ?? 0
        self.thunderstormProbability = try container.decodeIfPresent(Int.self, forKey: .thunderstormProbability) ?? 0
        self.rainProbability = try container.decodeIfPresent(Int.self, forKey: .rainProbability) ?? 0
        self.snowProbability = try container.decodeIfPresent(Int.self, forKey: .snowProbability) ?? 0
        self.iceProbability = try container.decodeIfPresent(Int.self, forKey: .iceProbability) ?? 0
        self.wind = try container.decodeIfPresent(Wind.self, forKey: .wind)
        self.windGust = try container.decodeIfPresent(Wind.self, forKey: .windGust)
        self.totalLiquid = try container.decodeIfPresent(Evapotranspiration.self, forKey: .totalLiquid)
        self.rain = try container.decodeIfPresent(Evapotranspiration.self, forKey: .rain)
        self.snow = try container.decodeIfPresent(Evapotranspiration.self, forKey: .snow)
        self.ice = try container.decodeIfPresent(Evapotranspiration.self, forKey: .ice)
        self.hoursOfPrecipitation = try container.decodeIfPresent(Double.self, forKey: .hoursOfPrecipitation) ?? 0
        self.hoursOfRain = try container.decodeIfPresent(Double.self, forKey: .hoursOfRain) ?? 0
        self.hoursOfSnow = try container.decodeIfPresent(Int.self, forKey: .hoursOfSnow) ?? 0
        self.hoursOfIce = try container.decodeIfPresent(Int.self, forKey: .hoursOfIce) ?? 0
        self.cloudCover = try container.decodeIfPresent(Int.self, forKey: .cloudCover) ?? 0
        self.evapotranspiration = try container.decodeIfPresent(Evapotranspiration.self, forKey: .evapotranspiration)
        self.solarIrradiance = try container.decodeIfPresent(Evapotranspiration.self, forKey: .solarIrradiance)
        self.precipitationType = try container.decodeIfPresent(String.self, forKey: .precipitationType) ?? "No data"
        self.precipitationIntensity = try container.decodeIfPresent(String.self, forKey: .precipitationIntensity) ?? "No data"
    }
}

// MARK: - Evapotranspiration
struct Evapotranspiration: Codable {
    let value: Double
    let unit: Unit?
    let unitType: Int
    let phrase: String?

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
        case phrase = "Phrase"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decodeIfPresent(Double.self, forKey: .value) ?? 0
        self.unit = try container.decodeIfPresent(Unit.self, forKey: .unit)
        self.unitType = try container.decodeIfPresent(Int.self, forKey: .unitType) ?? 0
        self.phrase = try container.decodeIfPresent(String.self, forKey: .phrase)
    }
}

enum Unit: String, Codable {
    case f = "F"
    case c = "C"
    case miH = "mi/h"
    case kmH = "km/h"
    case unitIn = "in"
    case wM = "W/m²"
    case mm = "mm"
    case cm = "cm"
    case m = "m"
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Evapotranspiration?
    let direction: Direction?

    enum CodingKeys: String, CodingKey {
        case speed = "Speed"
        case direction = "Direction"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.speed = try container.decodeIfPresent(Evapotranspiration.self, forKey: .speed)
        self.direction = try container.decodeIfPresent(Direction.self, forKey: .direction)
    }
}

// MARK: - Direction
struct Direction: Codable {
    let degrees: Int
    let localized, english: String

    enum CodingKeys: String, CodingKey {
        case degrees = "Degrees"
        case localized = "Localized"
        case english = "English"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.degrees = try container.decodeIfPresent(Int.self, forKey: .degrees) ?? 0
        self.localized = try container.decodeIfPresent(String.self, forKey: .localized) ?? "No data"
        self.english = try container.decodeIfPresent(String.self, forKey: .english) ?? "No data"
    }
    
    var image: String {
        switch degrees {
        case 0..<45:
            return "icon_wind_n"
        case 45..<90:
            return "icon_wind_ne"
        case 90..<135:
            return "icon_wind_e"
        case 135..<180:
            return "icon_wind_se"
        case 180..<225:
            return "icon_wind_s"
        case 225..<270:
            return "icon_wind_ws"
        case 270..<315:
            return "icon_wind_w"
        case 315..<360:
            return "icon_wind_wn"
        default:
            return "icon_wind_w"
        }
        

    }
}

// MARK: - DegreeDaySummary
struct DegreeDaySummary: Codable {
    let heating, cooling: Evapotranspiration?

    enum CodingKeys: String, CodingKey {
        case heating = "Heating"
        case cooling = "Cooling"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.heating = try container.decodeIfPresent(Evapotranspiration.self, forKey: .heating)
        self.cooling = try container.decodeIfPresent(Evapotranspiration.self, forKey: .cooling)
    }
}

// MARK: - Moon
struct Moon: Codable {
    let rise: String
    let epochRise: Int
    let moonSet: String
    let epochSet: Int
    let phase: String
    let age: Int

    enum CodingKeys: String, CodingKey {
        case rise = "Rise"
        case epochRise = "EpochRise"
        case moonSet = "Set"
        case epochSet = "EpochSet"
        case phase = "Phase"
        case age = "Age"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.rise = try container.decodeIfPresent(String.self, forKey: .rise) ?? "No data"
        self.epochRise = try container.decodeIfPresent(Int.self, forKey: .epochRise) ?? 0
        self.moonSet = try container.decodeIfPresent(String.self, forKey: .moonSet) ?? "No data"
        self.epochSet = try container.decodeIfPresent(Int.self, forKey: .epochSet) ?? 0
        self.phase = try container.decodeIfPresent(String.self, forKey: .phase) ?? "No data"
        self.age = try container.decodeIfPresent(Int.self, forKey: .age) ?? 0
    }
}

// MARK: - RealFeelTemperature
struct RealFeelTemperature: Codable {
    let minimum, maximum: Evapotranspiration?

    enum CodingKeys: String, CodingKey {
        case minimum = "Minimum"
        case maximum = "Maximum"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.minimum = try container.decodeIfPresent(Evapotranspiration.self, forKey: .minimum) ?? nil
        self.maximum = try container.decodeIfPresent(Evapotranspiration.self, forKey: .maximum)
    }
}

// MARK: - Sun
struct Sun: Codable {
    let rise: String
    let epochRise: Int
    let sunSet: String
    let epochSet: Int

    enum CodingKeys: String, CodingKey {
        case rise = "Rise"
        case epochRise = "EpochRise"
        case sunSet = "Set"
        case epochSet = "EpochSet"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.rise = try container.decodeIfPresent(String.self, forKey: .rise) ?? "No data"
        self.epochRise = try container.decodeIfPresent(Int.self, forKey: .epochRise) ?? 0
        self.sunSet = try container.decodeIfPresent(String.self, forKey: .sunSet) ?? "No data"
        self.epochSet = try container.decodeIfPresent(Int.self, forKey: .epochSet) ?? 0
    }
}

// MARK: - Headline
struct Headline: Codable {
    let effectiveDate: String
    let effectiveEpochDate, severity: Int
    let text, category: String
    let endDate: String
    let endEpochDate: Int
    let mobileLink, link: String

    enum CodingKeys: String, CodingKey {
        case effectiveDate = "EffectiveDate"
        case effectiveEpochDate = "EffectiveEpochDate"
        case severity = "Severity"
        case text = "Text"
        case category = "Category"
        case endDate = "EndDate"
        case endEpochDate = "EndEpochDate"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.effectiveDate = try container.decodeIfPresent(String.self, forKey: .effectiveDate) ?? "No data"
        self.effectiveEpochDate = try container.decodeIfPresent(Int.self, forKey: .effectiveEpochDate) ?? 0
        self.severity = try container.decodeIfPresent(Int.self, forKey: .severity) ?? 0
        self.text = try container.decodeIfPresent(String.self, forKey: .text) ?? "No data"
        self.category = try container.decodeIfPresent(String.self, forKey: .category) ?? "No data"
        self.endDate = try container.decodeIfPresent(String.self, forKey: .endDate) ?? "No data"
        self.endEpochDate = try container.decodeIfPresent(Int.self, forKey: .endEpochDate) ?? 0
        self.mobileLink = try container.decodeIfPresent(String.self, forKey: .mobileLink) ?? "No data"
        self.link = try container.decodeIfPresent(String.self, forKey: .link) ?? "No data"
    }
}
