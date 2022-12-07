//
//  CityCoordinates.swift
//  NatifeWeatherApp
//
//  Created by Саша Василенко on 05.12.2022.
//

import MapKit

final class CityCoordinates: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    
    init(name: String, coordinate: CLLocationCoordinate2D) {
        self.title = name
        self.coordinate = coordinate
    }
}
