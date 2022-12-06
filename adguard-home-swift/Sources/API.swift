//
//  File.swift
//  
//
//  Created by Matt on 12/11/2022.
//

import Foundation

enum API {
    // MARK: - Stats
    case stats
    case statsInfo

    // MARK: - Clients
    case clients
    case clientsFind(String)
    case clientsList

    // MARK: - DHCP
    case dhcpStatus
    case dhcpInterfaces

    // MARK: - Filtering
    case filteringStatus
    case filteringCheckHost

    // MARK: - Global
    case status
    case dnsInfo

    // MARK: - Install
    case installGetAddresses

    // MARK: - Log
    case queryLog
    case queryLogInfo

    // MARK: - Parental
    case parentalStatus

    // MARK: - SafeBrowsing
    case safebrowsingStatus

    // MARK: - SafeSearch
    case safesearchStatus

    // MARK: - TLS
    case tlsStatus

    // MARK: - Blocked Services
    case blockedServicesAll
    case blockedServicesList

    // MARK: - Rewrite
    case rewriteList

    var method: String {
        switch self {
        case .statsInfo:
            return "GET"
        case .clients:
            return "GET"
        case .clientsFind(_):
            return "GET"
        case .clientsList:
            return "GET"
        case .dhcpStatus:
            return "GET"
        case .dhcpInterfaces:
            return "GET"
        case .filteringStatus:
            return "GET"
        case .filteringCheckHost:
            return "GET"
        case .dnsInfo:
            return "GET"
        case .installGetAddresses:
            return "GET"
        case .queryLog:
            return "GET"
        case .queryLogInfo:
            return "GET"
        case .parentalStatus:
            return "GET"
        case .safebrowsingStatus:
            return "GET"
        case .safesearchStatus:
            return "GET"
        case .tlsStatus:
            return "GET"
        case .blockedServicesAll:
            return "GET"
        case .blockedServicesList:
            return "GET"
        case .rewriteList:
            return "GET"
        case .stats:
            return "GET"
        case .status:
            return "GET"
        }
    }

    var path: String {
        switch self {
        case .status:
            return "/status"
        case .stats:
            return "/stats"
        case .statsInfo:
            return "/stats_info"
        case .clients:
            return "/clients"
        case .clientsFind(_):
            return "/clients/find"
        case .clientsList:
            return "clients/list"
        case .dhcpStatus:
            return "/dhcp/status"
        case .dhcpInterfaces:
            return "/dhcp/interfaces"
        case .filteringStatus:
            return "/filtering/status"
        case .filteringCheckHost:
            return "/filtering/chech_host"
        case .dnsInfo:
            return "/dns_info"
        case .installGetAddresses:
            return "/install/get_addresses"
        case .queryLog:
            return "/querylog"
        case .queryLogInfo:
            return "/querylog_info"
        case .parentalStatus:
            return "/parental/status"
        case .safebrowsingStatus:
            return "/safebrowsing/status"
        case .safesearchStatus:
            return "/safesearch/status"
        case .tlsStatus:
            return "/tls/status"
        case .blockedServicesAll:
            return "/blocked_services/all"
        case .blockedServicesList:
            return "/blocked_services/list"
        case .rewriteList:
            return "rewrite/list"
        }
    }
}
