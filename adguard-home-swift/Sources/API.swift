//
//  File.swift
//  
//
//  Created by Matt on 12/11/2022.
//

import Foundation

enum API {
    case status
    case stats

    var method: String {
        switch self {
        case .status, .stats:
            return "GET"
        }
    }

    var path: String {
        switch self {
        case .status:
            return "/status"
        case .stats:
            return "/stats"
        }
    }
}
