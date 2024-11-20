//
//  NetworkError.swift
//  NASA-APOD-SampleApp
//
//  Created by Ali Farhadi on 11/19/24.
//

import Foundation

enum NetworkError: Error {
    case badRequest(_ errorModel: GenericErrorModel)
    case invalidResponse(_ errorModel: GenericErrorModel)
    case decodeFailed(_ errorModel: GenericErrorModel)
}
