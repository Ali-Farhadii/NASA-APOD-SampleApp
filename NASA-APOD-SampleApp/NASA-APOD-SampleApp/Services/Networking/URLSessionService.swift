//
//  URLSessionService.swift
//  NASA-APOD-SampleApp
//
//  Created by Ali Farhadi on 11/19/24.
//

import Foundation

struct URLSessionService: NetworkService {
    
    //TODO: Make it better for mocking and unit testing
    let urlSession = URLSession.shared
    
    func request<T: Decodable>(with endpoint: Endpoint) async throws -> T {
        guard let urlRequest = endpoint.createURLRequest() else { throw NetworkError.badRequest }
        let (data, response) = try await urlSession.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else { throw NetworkError.invalidResponse }
        
        if let decodedData: T = decodeData(data) {
            return decodedData
        } else {
            throw NetworkError.decodeFailed
        }
    }
    
    func decodeData<T: Decodable>(_ data: Data) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try? decoder.decode(T.self, from: data)
    }
}
