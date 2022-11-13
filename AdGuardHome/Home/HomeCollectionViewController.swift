//
//  ViewController.swift
//  AdGuardHome
//
//  Created by Matt on 12/11/2022.
//

import UIKit
import AdGuardHomeClient

class HomeCollectionViewController: UIViewController {
    let account: AdGuardHomeClient = AdGuardHomeClient(ip: "10.0.20.1", username: "test", password: "test")

    private lazy var collectionview: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: sectionProvider))
        cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return cv
    }()

    private lazy var datasource: UICollectionViewDiffableDataSource<Int, StatsType> = {
        let mainCellConfig = UICollectionView.CellRegistration<MainCell, StatsType> { cell, indexPath, statsType in
            cell.update(with: statsType)
        }

        let listCellConfig = UICollectionView.CellRegistration<UICollectionViewListCell, StatsType> { cell, indexPath, tuple in
            var config = cell.defaultContentConfiguration()
            if case .listTuple(let s, let i) = tuple {
                config.text = s
                cell.contentConfiguration = config
                cell.accessories = [.label(text: String(i))]
            }
        }

        let headerRegistration: UICollectionView.SupplementaryRegistration<UICollectionViewListCell> = .init(elementKind: UICollectionView.elementKindSectionHeader) { cell, _, indexPath in
            var config = cell.defaultContentConfiguration()

            switch indexPath.section {
            case 0:
                config.text = "Stats"
            case 1:
                config.text = "Top Domains"
            case 2:
                config.text = "Top Clients"
            case 3:
                config.text = "Top Blocked"
            default:
                config.text = "@:"
            }

            cell.contentConfiguration = config
        }

        let datasource = UICollectionViewDiffableDataSource<Int, StatsType>(collectionView: collectionview) { cv, indexPath, itemIdentifier in
            if indexPath.section == 0 {
                return cv.dequeueConfiguredReusableCell(using: mainCellConfig, for: indexPath, item: itemIdentifier)
            } else {
                return cv.dequeueConfiguredReusableCell(using: listCellConfig, for: indexPath, item: itemIdentifier)
            }
        }

        datasource.supplementaryViewProvider = { cv, kind, indexPath -> UICollectionReusableView? in
            if kind == UICollectionView.elementKindSectionHeader {
                return cv.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
            }

            return nil
        }

        return datasource
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "AdGuard Home"

        view.addSubview(collectionview)
        collectionview.delegate = self

        loadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionview.frame = view.bounds
    }

    private func setupDatasource(with stats: Stats) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, StatsType>()
        let adapter = StatsSectionsAdapter(stats: stats)

        snapshot.appendSections([0,1,2,3])
        snapshot.appendItems(adapter.firstSection, toSection: 0)
        snapshot.appendItems(adapter.topQueriedDomains, toSection: 1)
        snapshot.appendItems(adapter.topClients, toSection: 2)
        snapshot.appendItems(adapter.topBlockedDomains, toSection: 3)

        datasource.apply(snapshot, animatingDifferences: false)
    }

    private func loadData() {
        Task {
            guard let stats = await account.getStats() else { return }
            DispatchQueue.main.async {
                self.setupDatasource(with: stats)
            }
        }
    }
}

extension HomeCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return false
    }
}
