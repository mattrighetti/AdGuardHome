//
//  File.swift
//  
//
//  Created by Matt on 12/11/2022.
//

import Foundation

public struct Stats: Codable {
    public let timeUnits: String
    public let topQueriedDomains: [[String:Int]]
    public let topClients: [[String:Int]]
    public let topBlockedDomains: [[String:Int]]
    public let dnsQueries: [Int]
    public let blockedFiltering: [Int]
    public let replacedSafebrowsing: [Int]
    public let replacedParental: [Int]
    public let numDnsQueries: Int
    public let numBlockedFiltering: Int
    public let numReplacedSafebrowsing: Int
    public let numReplacedSafesearch: Int
    public let numReplacedParental: Int
    public let avgProcessingTime: Double
}
