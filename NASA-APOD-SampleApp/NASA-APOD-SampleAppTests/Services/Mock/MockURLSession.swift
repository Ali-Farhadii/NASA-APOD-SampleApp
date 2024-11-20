//
//  MockURLSession.swift
//  NASA-APOD-SampleAppTests
//
//  Created by Ali Farhadi on 11/20/24.
//

import Foundation
@testable import NASA_APOD_SampleApp

class MockURLSession: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }
        
        guard let data = data, let response = response else {
            throw MockError.requestFailed
        }
        
        return (data, response)
    }
}
