//
//  MapScreenModule.swift
//  NatifeWeatherApp
//
//  Created by Саша Василенко on 05.12.2022.
//

import MapKit
import UIKit

protocol MapScreenModuleDelegate: AnyObject {
    func didSelectCity(lat: Double, lon: Double)
}

final class MapScreenModule: UIViewController {
    weak var delegate: MapScreenModuleDelegate?
    
    private let mapKitView: MKMapView = {
        let mapKitView = MKMapView()
        mapKitView.translatesAutoresizingMaskIntoConstraints = false
        mapKitView.isZoomEnabled = true
        return mapKitView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapKitView)
        view.backgroundColor = UIColor(named: "MainBlue")
        mapKitView.delegate = self
        setupCities()
        setupCosntraints()
    }
}

private extension MapScreenModule {
    func setupCities() {
        let zhytomyr = CityCoordinates(name: "Zhytomyr", coordinate: CLLocationCoordinate2DMake(50.253550000000075, 28.66543000000007))
        let kyiv = CityCoordinates(name: "Kyiv", coordinate: CLLocationCoordinate2DMake(50.450001, 30.523333))
        
        mapKitView.addAnnotation(zhytomyr)
        mapKitView.addAnnotation(kyiv)
    }
    
    func setupCosntraints() {
        NSLayoutConstraint.activate([
            mapKitView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapKitView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapKitView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapKitView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}


extension MapScreenModule: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is CityCoordinates else { return nil }

        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let city = view.annotation as? CityCoordinates else { return }
        let placeName = city.title
        delegate?.didSelectCity(lat: city.coordinate.latitude, lon: city.coordinate.longitude)
        
        let ac = UIAlertController(title: "Selected", message: placeName, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
