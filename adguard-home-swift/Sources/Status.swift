//
//  File.swift
//  
//
//  Created by Matt on 12/11/2022.
//

import Foundation

public struct Status: Codable {
    public let version: String
    public let language: String
    public let dnsAddresses: [String]
    public let dnsPort: Int
    public let httpPort: Int
    public let protectionEnables: Bool
    public let dhcpAvailable: Bool
    public let running: Bool
}
