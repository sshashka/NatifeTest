//
//  CurrentWeatherModel.swift
//  NatifeWeatherApp
//
//  Created by Саша Василенко on 04.12.2022.
//

import Foundation

// MARK: - CityCodeModel
struct CityCodeModel: Codable {
    let version: Int
    let key, type: String
    let rank: Int
    let localizedName, englishName, primaryPostalCode: String
    let region, country: Country?
    let administrativeArea: AdministrativeArea?
    let timeZone: TimeZone?
    let geoPosition: GeoPosition?
    let isAlias: Bool
    let supplementalAdminAreas: [Int]
    let dataSets: [String]

    enum CodingKeys: String, CodingKey {
        case version = "Version"
        case key = "Key"
        case type = "Type"
        case rank = "Rank"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
        case primaryPostalCode = "PrimaryPostalCode"
        case region = "Region"
        case country = "Country"
        case administrativeArea = "AdministrativeArea"
        case timeZone = "TimeZone"
        case geoPosition = "GeoPosition"
        case isAlias = "IsAlias"
        case supplementalAdminAreas = "SupplementalAdminAreas"
        case dataSets = "DataSets"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.version = try container.decodeIfPresent(Int.self, forKey: .version) ?? 0
        self.key = try container.decodeIfPresent(String.self, forKey: .key) ?? "No data"
        self.type = try container.decodeIfPresent(String.self, forKey: .type) ?? "No data"
        self.rank = try container.decodeIfPresent(Int.self, forKey: .rank) ?? 0
        self.localizedName = try container.decodeIfPresent(String.self, forKey: .localizedName) ?? "No data"
        self.englishName = try container.decodeIfPresent(String.self, forKey: .englishName) ?? "No data"
        self.primaryPostalCode = try container.decodeIfPresent(String.self, forKey: .primaryPostalCode) ?? "No data"
        self.region = try container.decodeIfPresent(Country.self, forKey: .region)
        self.country = try container.decodeIfPresent(Country.self, forKey: .country)
        self.administrativeArea = try container.decodeIfPresent(AdministrativeArea.self, forKey: .administrativeArea) 
        self.timeZone = try container.decodeIfPresent(TimeZone.self, forKey: .timeZone) ?? nil
        self.geoPosition = try container.decodeIfPresent(GeoPosition.self, forKey: .geoPosition)
        self.isAlias = try container.decodeIfPresent(Bool.self, forKey: .isAlias) ?? false
        self.supplementalAdminAreas = try container.decodeIfPresent([Int].self, forKey: .supplementalAdminAreas) ?? [0]
        self.dataSets = try container.decode([String].self, forKey: .dataSets)
    }
}

// MARK: - AdministrativeArea
struct AdministrativeArea: Codable {
    let id, localizedName, englishName: String
    let level: Int
    let localizedType, englishType, countryID: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
        case level = "Level"
        case localizedType = "LocalizedType"
        case englishType = "EnglishType"
        case countryID = "CountryID"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? "No data"
        self.localizedName = try container.decodeIfPresent(String.self, forKey: .localizedName)  ?? "No data"
        self.englishName = try container.decodeIfPresent(String.self, forKey: .englishName)  ?? "No data"
        self.level = try container.decodeIfPresent(Int.self, forKey: .level) ?? 0
        self.localizedType = try container.decodeIfPresent(String.self, forKey: .localizedType)  ?? "No data"
        self.englishType = try container.decodeIfPresent(String.self, forKey: .englishType)  ?? "No data"
        self.countryID = try container.decodeIfPresent(String.self, forKey: .countryID) ?? "No data"
    }
}

// MARK: - Country
struct Country: Codable {
    let id, localizedName, englishName: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
    }
}

// MARK: - GeoPosition
struct GeoPosition: Codable {
    let latitude, longitude: Double
    let elevation: Elevation

    enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
        case elevation = "Elevation"
    }
}

// MARK: - Elevation
struct Elevation: Codable {
    let metric, imperial: Imperial

    enum CodingKeys: String, CodingKey {
        case metric = "Metric"
        case imperial = "Imperial"
    }
}

// MARK: - Imperial
struct Imperial: Codable {
    let value: Int
    let unit: String
    let unitType: Int

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
    }
}

// MARK: - TimeZone
struct TimeZone: Codable {
    let code, name: String?
    let gmtOffset: Int?
    let isDaylightSaving: Bool?
    let nextOffsetChange: String?

    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case name = "Name"
        case gmtOffset = "GmtOffset"
        case isDaylightSaving = "IsDaylightSaving"
        case nextOffsetChange = "NextOffsetChange"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.gmtOffset = try container.decodeIfPresent(Int.self, forKey: .gmtOffset)
        self.isDaylightSaving = try container.decodeIfPresent(Bool.self, forKey: .isDaylightSaving)
        self.nextOffsetChange = try container.decodeIfPresent(String.self, forKey: .nextOffsetChange)
    }
}
