//
//  MainScreenTableViewCell.swift
//  NatifeWeatherApp
//
//  Created by Саша Василенко on 04.12.2022.
//

import UIKit

final class MainScreenTableViewCell: UITableViewCell {
    static let identifier = "MainScreenTableViewCell"
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .label
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dayLabel, tempLabel, weatherImageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.spacing = 16
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(stackView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(data: DailyForecast, humanBeingDate: String) {
        dayLabel.text = humanBeingDate
        let minTemp = data.temperature?.minimum?.value
        let maxTemp = data.temperature?.maximum?.value
        guard let minTemp = minTemp else { return }
        guard let maxTemp = maxTemp else { return }
        tempLabel.text = "\(minTemp) / \(maxTemp)"
        weatherImageView.image = UIImage(named: data.day!.image)?.withRenderingMode(.alwaysTemplate)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        isSelected ? changeColorsForSelected() : changeColorsForDeselected()
    }
    
}

private extension MainScreenTableViewCell {
    func changeColorsForSelected() {
        dayLabel.textColor = UIColor(named: "MainBlue")
        tempLabel.textColor = UIColor(named: "MainBlue")
        
        contentView.backgroundColor = .clear
        contentView.layer.masksToBounds = false
        contentView.layer.shadowOpacity = 0.35
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentView.layer.shadowColor = UIColor(named: "MainBlue")?.cgColor
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        
        contentView.layer.shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: 8).cgPath
    }
    
    func changeColorsForDeselected() {
        dayLabel.textColor = .label
        tempLabel.textColor = .label
        
        contentView.backgroundColor = .systemBackground
        contentView.layer.masksToBounds = true
        contentView.layer.shadowOpacity = 0
        contentView.layer.shadowRadius = 0
        contentView.layer.cornerRadius = 0
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        ])
    }
}
