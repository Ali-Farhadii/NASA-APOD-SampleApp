//
//  NetworkService.swift
//  NASA-APOD-SampleApp
//
//  Created by Ali Farhadi on 11/19/24.
//

import Foundation

protocol NetworkService {
    func request<T: Decodable>(with endpoint: Endpoint) async throws -> T
}
