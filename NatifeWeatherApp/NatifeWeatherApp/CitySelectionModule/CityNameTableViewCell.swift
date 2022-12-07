//
//  CityNameTableViewCell.swift
//  NatifeWeatherApp
//
//  Created by Саша Василенко on 06.12.2022.
//

import UIKit

final class CityNameTableViewCell: UITableViewCell {
    static let identifier = "CityNameTableViewCell"
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        accessoryType = selected ? .checkmark : .none
    }
}

private extension CityNameTableViewCell {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

extension CityNameTableViewCell {
    func setupCell(data: String) {
        label.text = data
    }
}
