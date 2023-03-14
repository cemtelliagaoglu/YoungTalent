//
//  RequestError.swift
//  YoungTalent
//
//  Created by admin on 10.03.2023.
//

import Foundation

public enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        case .noResponse:
            return "Response error"
        default:
            return "Unknown error"
        }
    }
}
