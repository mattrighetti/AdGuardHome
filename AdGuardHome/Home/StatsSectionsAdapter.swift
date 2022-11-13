//
//  StatsSectionsAdapter.swift
//  AdGuardHome
//
//  Created by Matt on 12/11/2022.
//

import UIKit
import AdGuardHomeClient
import Foundation

enum StatsType: Hashable {
    case dnsQueries(Int, [Int])
    case blockedByFilters(Int, [Int])
    case blockedMalwarePhising(Int, [Int])
    case blockedAdultWebsites(Int, [Int])
    case listTuple(String, Int)

    var labelText: String? {
        switch self {
        case .dnsQueries(_, _):
            return "DNS Queries"
        case .blockedByFilters(_, _):
            return "Blocked by Filters"
        case .blockedMalwarePhising(_, _):
            return "Blocked Malware/Phising"
        case .blockedAdultWebsites(_, _):
            return "Blocked Adult Websites"
        default:
            return nil
        }
    }

    var color: UIColor? {
        switch self {
        case .dnsQueries(_, _):
            return UIColor(red: 70/255, green: 127/255, blue: 207/255, alpha: 1.0)
        case .blockedByFilters(_, _):
            return UIColor(red: 205/255, green: 33/255, blue: 31/255, alpha: 1.0)
        case .blockedAdultWebsites(_, _):
            return UIColor(red: 241/255, green: 196/255, blue: 41/255, alpha: 1.0)
        case .blockedMalwarePhising(_, _):
            return UIColor(red: 94/255, green: 136/255, blue: 0/255, alpha: 1.0)
        default:
            return nil
        }
    }
}

struct StatsSectionsAdapter {
    let stats: Stats

    init(stats: Stats) {
        self.stats = stats
    }

    var firstSection: [StatsType] {
        [
            .dnsQueries(stats.numDnsQueries, stats.dnsQueries),
            .blockedByFilters(stats.numBlockedFiltering, stats.blockedFiltering),
            .blockedMalwarePhising(stats.numReplacedSafebrowsing, stats.replacedSafebrowsing),
            .blockedAdultWebsites(stats.numReplacedParental, stats.replacedParental)
        ]
    }

    var topBlockedDomains: [StatsType] {
        let v = stats.topBlockedDomains.compactMap { getFirstEntry($0) }
        return Array(v[..<5])
    }

    var topQueriedDomains: [StatsType] {
        let v = stats.topQueriedDomains.compactMap { getFirstEntry($0) }
        return Array(v[..<5])
    }

    var topClients: [StatsType] {
        let v = stats.topClients.compactMap { getFirstEntry($0) }
        return Array(v[..<5])
    }

    private func getFirstEntry(_ dict: [String : Int]) -> StatsType? {
        for (key, value) in dict {
            return .listTuple(key, value)
        }
        return nil
    }
}
