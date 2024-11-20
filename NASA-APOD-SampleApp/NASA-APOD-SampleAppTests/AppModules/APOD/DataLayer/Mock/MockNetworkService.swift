//
//  MockNetworkService.swift
//  NASA-APOD-SampleAppTests
//
//  Created by Ali Farhadi on 11/20/24.
//

import Foundation
@testable import NASA_APOD_SampleApp

struct MockNetworkService: NetworkService {
    var mockRequestResult: APODDecodableModel?
    var mockRequestError: Error?
    
    func request<T: Decodable>(with endpoint: any Endpoint) async throws -> T {
        if let result = mockRequestResult as? T {
            return result
        } else if let error = mockRequestError {
            throw error
        } else {
            throw NSError(domain: "MockNetworkServiceError", code: 0, userInfo: nil)
        }
    }
}
