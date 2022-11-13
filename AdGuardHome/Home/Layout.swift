//
//  Layout.swift
//  AdGuardHome
//
//  Created by Matt on 12/11/2022.
//

import UIKit

extension HomeCollectionViewController {
    private var width: CGFloat {
        view.frame.size.width
    }

    private var primaryItemWidth: CGFloat {
        switch width {
        case 0..<500:
            return 1/2
        default:
            return 1/6
        }
    }

    private var secondayItemWidth: CGFloat {
        switch width {
        case 0..<500:
            return 1/2
        case 500..<1000:
            return 1/4
        default:
            return 1/6
        }
    }

    private var mainSection: NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(primaryItemWidth),
                heightDimension: .absolute(90)
            )
        )
        item.contentInsets.trailing = 8
        item.contentInsets.bottom = 5

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(500)
            ),
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)

        section.contentInsets.leading = 16
        section.boundarySupplementaryItems = [
            .init(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(50)
                ),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .topLeading
            )
        ]

        return section
    }

    var sectionProvider: UICollectionViewCompositionalLayoutSectionProvider {
        let sectionProvider = { (sectionNumber: Int, env: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            if sectionNumber == 0 {
                return self.mainSection
            }

            var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            config.headerMode = .supplementary
            return NSCollectionLayoutSection.list(using: config, layoutEnvironment: env)
        }

        return sectionProvider
    }
}
