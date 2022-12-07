//
//  ViewController.swift
//  NatifeWeatherApp
//
//  Created by Саша Василенко on 07.12.2022.
//

import UIKit

final class ViewController: UIViewController {
    private var hourlyData: HourlyWeatherModel?
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let conditionsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    // MARK: temp
    private let tempImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_temp")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tempStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tempImageView, tempLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    // MARK: humidity
    private let humidityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_humidity")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private lazy var humidityStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [humidityImageView, humidityLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.contentMode = .scaleToFill
        stackView.spacing = 16
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    
    // MARK: wind
    private let windImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_wind")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let windDirectionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_wind")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let windLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var windStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [windImageView, windLabel, windDirectionImageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.contentMode = .scaleToFill
        stackView.spacing = 16
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var conditionsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tempStackView, humidityStackView, windStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [conditionsImageView, conditionsStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var collectionView: UICollectionView! = nil
    

        
    // MARK: rootStackView
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, infoStackView, collectionView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "MainBlue")
        setupColletctionView()
        setupView()
        view.addSubview(rootStackView)
        setupConstraints()
    }
    func setupView() {
        dateLabel.text = "no data"
        tempLabel.text = "no data"
        humidityLabel.text = "no data"
        windLabel.text = "no data"
        conditionsImageView.image = UIImage(named: "ic_white_day_cloudy")
    }
}

private extension ViewController {
    func setupColletctionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.backgroundColor = UIColor(named: "CollectionViewBlue")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HeaderCellCollectionViewCell.self, forCellWithReuseIdentifier: HeaderCellCollectionViewCell.identifier)
        view.addSubview(collectionView)
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.22), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            infoStackView.heightAnchor.constraint(equalToConstant: 150),
            rootStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyData?.list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCellCollectionViewCell.identifier, for: indexPath) as? HeaderCellCollectionViewCell
        guard let cell = cell else { return UICollectionViewCell() }
        if let data = hourlyData?.list { cell.setupCell(with: data[indexPath.row]) }
        return cell
    }
}

extension ViewController {
    func showData(data: DailyForecast, humanBeingDate: String) {
        dateLabel.text = humanBeingDate
        let minTemp = data.temperature?.minimum?.value
        let maxTemp = data.temperature?.maximum?.value
        let humidity = data.day?.evapotranspiration?.value
        let wind = data.day?.wind?.speed?.value
        
        tempLabel.text = "\(minTemp ?? 0)˚/\(maxTemp ?? 0)˚"
        humidityLabel.text = "\(humidity ?? 0)%"
        windLabel.text = "\(wind ?? 0) ms/s"
        conditionsImageView.image = UIImage(named: data.day!.image)
    }
    
    func showHourlyWeather(weather: HourlyWeatherModel) {
        self.hourlyData = weather
        print(weather)
        collectionView.reloadData()
    }
}
