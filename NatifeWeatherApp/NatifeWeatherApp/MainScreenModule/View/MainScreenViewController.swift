//
//  ViewController.swift
//  NatifeWeatherApp
//
//  Created by Саша Василенко on 02.12.2022.
//

import UIKit
import CoreLocation

final class MainScreenViewController: UIViewController {
    var data: DailyWeatherModel?
    var presenter: MainScreenModulePresenterProtocol?
    let coreLocationManager = CLLocationManager()
    private var cityName = "City"
    private let cityChangeButton = UIButton()
    private let currentWeatherViewController: ViewController = {
        let vc = ViewController()
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MainScreenTableViewCell.self, forCellReuseIdentifier: MainScreenTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [currentWeatherViewController.view, tableView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        setupConstraints()
        setupNavVC()
        tableView.delegate = self
        tableView.dataSource = self
        coreLocationManager.delegate = self
        coreLocationManager.requestAlwaysAuthorization()
        setupChildView()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let currentVCVerticalWindth = currentWeatherViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        currentVCVerticalWindth.priority = .defaultLow
        if view.traitCollection.verticalSizeClass == .compact {
            stackView.axis = .horizontal
            
        } else {
            stackView.axis = .vertical
            NSLayoutConstraint.activate([
                currentVCVerticalWindth
            ])
        }
    }
}

private extension MainScreenViewController {
    func setupChildView() {
        addChild(currentWeatherViewController)
        currentWeatherViewController.didMove(toParent: self)
    }
    func setupNavVC() {
        let mapButton = UIBarButtonItem(image: UIImage(named: "ic_my_location"), style: .plain, target: self, action: #selector(mapLocationButtonDidTap))
        let coreLocationButton = UIBarButtonItem(image: UIImage(named: "ic_place"), style: .plain, target: self, action: #selector(coreLocationButtonDidTap))
        
        let citySelectionButton = UIBarButtonItem(customView: cityChangeButton)
        cityChangeButton.setTitle(cityName, for: .normal)
        cityChangeButton.addTarget(self, action: #selector(citySelectionButtonDidTap), for: .touchUpInside)
        cityChangeButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        citySelectionButton.customView?.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        citySelectionButton.customView?.setContentCompressionResistancePriority(.defaultHigh + 1, for: .horizontal)
        
        
        navigationItem.rightBarButtonItem = mapButton
        navigationItem.leftBarButtonItems = [coreLocationButton, citySelectionButton]
        
        navigationController?.view.tintColor = .white
    }
    
    @objc func mapLocationButtonDidTap() {
        let vc = MapScreenModule()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func coreLocationButtonDidTap() {
        coreLocationManager.requestLocation()
    }
    
    @objc func citySelectionButtonDidTap() {
        let vc = CitySelectionViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupConstraints() {
        let currentVCHeightConstraint = currentWeatherViewController.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6)
        currentVCHeightConstraint.priority = .defaultLow
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            currentVCHeightConstraint
        ])
    }
    
    func showLocationDeniedAlert() {
        let alert = UIAlertController(title: "Oops", message: "To use location services change settings", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        alert.addAction(UIAlertAction(title: "Go to settings", style: .default))
    }
}

// MARK: TableView Delegate
extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.dailyForecasts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainScreenTableViewCell.identifier, for: indexPath) as? MainScreenTableViewCell
        guard let cell = cell else { return UITableViewCell() }
        if let data = data {
            let humanBeingDate = presenter?.convertStringToDate(date: data.dailyForecasts[indexPath.row].date, to: "EE") ?? "No data"
            cell.setupCell(data: data.dailyForecasts[indexPath.row], humanBeingDate: humanBeingDate)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = data else { return }
        currentWeatherViewController.showData(data: data.dailyForecasts[indexPath.row], humanBeingDate: presenter?.convertStringToDate(date: data.dailyForecasts[indexPath.row].date, to: "E, d MMM") ?? "No data")
    }
}


extension MainScreenViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            showLocationDeniedAlert()
        case .denied:
            showLocationDeniedAlert()
        case .authorizedAlways:
            manager.startUpdatingLocation()
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
        @unknown default:
            assert(false)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location else { return }
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        presenter?.getCityCodeByLocation(lat: lat, lon: lon)
        presenter?.getHourlyWeather(lat: lat, lon: lon)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showLocationDeniedAlert()
        print(error)
    }
}

extension MainScreenViewController: MainScreenModuleViewProtocol {
    func showDailyWeather(weather: DailyWeatherModel) {
        self.data = weather
        tableView.reloadData()
        currentWeatherViewController.showData(data: weather.dailyForecasts[0], humanBeingDate: presenter?.convertStringToDate(date: weather.dailyForecasts[0].date, to: "E, d MMM") ?? "No data")
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
    }
    
    func passHourlyWeather(weather: HourlyWeatherModel) {
        currentWeatherViewController.showHourlyWeather(weather: weather)
        guard let city = weather.city?.name else { return }
        cityChangeButton.setTitle(city, for: .normal)
    }
}

extension MainScreenViewController: MapScreenModuleDelegate {
    func didSelectCity(lat: Double, lon: Double) {
        presenter?.getCityCodeByLocation(lat: lat, lon: lon)
        presenter?.getHourlyWeather(lat: lat, lon: lon)
    }
}

extension MainScreenViewController: CitySelectionViewControllerDelegate {
    func didSelectCityFromList(lat: Double, lon: Double) {
        presenter?.getCityCodeByLocation(lat: lat, lon: lon)
        presenter?.getHourlyWeather(lat: lat, lon: lon)
    }
}
