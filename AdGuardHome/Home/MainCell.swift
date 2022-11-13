//
//  MainCell.swift
//  AdGuardHome
//
//  Created by Matt on 12/11/2022.
//

import UIKit

class MainCell: UICollectionViewCell {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.rounded(ofSize: 17, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.rounded(ofSize: 17, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)

        layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        layer.borderWidth = 3
        layer.cornerRadius = 15
        clipsToBounds = true

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        titleLabel.text = nil
        valueLabel.text = nil
    }

    public func update(with statsType: StatsType) {
        titleLabel.text = statsType.labelText
        backgroundColor = statsType.color

        switch statsType {
        case .dnsQueries(let int, _):
            valueLabel.text = String(int)
        case .blockedByFilters(let int, _):
            valueLabel.text = String(int)
        case .blockedMalwarePhising(let int, _):
            valueLabel.text = String(int)
        case .blockedAdultWebsites(let int, _):
            valueLabel.text = String(int)
        default:
            return
        }
    }
}
