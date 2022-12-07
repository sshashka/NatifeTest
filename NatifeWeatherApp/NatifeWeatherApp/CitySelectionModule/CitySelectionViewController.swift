//
//  CitySelectionModule.swift
//  NatifeWeatherApp
//
//  Created by Саша Василенко on 06.12.2022.
//

import UIKit

protocol CitySelectionViewControllerDelegate: AnyObject {
    func didSelectCityFromList(lat: Double, lon: Double)
}

final class CitySelectionViewController: UIViewController {
    weak var delegate: CitySelectionViewControllerDelegate?
    private var data = [Cities]()
    private let searchController = UISearchController(searchResultsController: nil)
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CityNameTableViewCell.self, forCellReuseIdentifier: CityNameTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        tableView.delegate = self
        tableView.dataSource = self
        data = [Cities(title: "Zhytomyr", lat: 50.253550000000075, lon:  28.66543000000007), Cities(title: "Kyiv", lat: 50.450001, lon: 30.523333)]
        setupConstraints()
    }
}

private extension CitySelectionViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension CitySelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityNameTableViewCell.identifier, for: indexPath) as? CityNameTableViewCell
        guard let cell = cell else { return UITableViewCell() }
        cell.setupCell(data: data[indexPath.row].title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = data[indexPath.row]
        delegate?.didSelectCityFromList(lat: city.lat, lon: city.lon)
    }
    
}

extension CitySelectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.isActive {
            guard let text = searchController.searchBar.text, text != "" else { return }
            
            data = data.filter { city in
                city.title.contains(text)
            }
        } else {
            data = [Cities(title: "Zhytomyr", lat: 50.253550000000075, lon: 28.66543000000007), Cities(title: "Kyiv", lat: 50.450001, lon: 30.523333)]
        }
        tableView.reloadData()
    }
}
