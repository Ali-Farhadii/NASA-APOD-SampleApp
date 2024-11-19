//
//  NetworkError.swift
//  NASA-APOD-SampleApp
//
//  Created by Ali Farhadi on 11/19/24.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case invalidResponse
    case decodeFailed
    case invalidData
    
    var title: String {
        switch self {
        case .badRequest:
            return ""
        case .invalidResponse:
            return ""
        case .decodeFailed:
            return ""
        case .invalidData:
            return ""
        }
    }
    
    var message: String {
        switch self {
        case .badRequest:
            return ""
        case .invalidResponse:
            return ""
        case .decodeFailed:
            return ""
        case .invalidData:
            return ""
        }
    }
}
