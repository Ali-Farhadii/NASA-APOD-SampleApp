//
//  MockAPODRepository.swift
//  NASA-APOD-SampleAppTests
//
//  Created by Ali Farhadi on 11/20/24.
//

import Foundation
@testable import NASA_APOD_SampleApp

struct MockAPODRepository: APODRepositoryProtocol {
    var expectedError: Bool = false
    
    func fetchAPOD(with date: String) async throws -> APODBusinessModel {
        try await Task.sleep(for: .seconds(1))
        
        if expectedError { throw NSError(domain: "MockError", code: 0) }
        
        return APODBusinessModel(title: "Title",
                                 copyright: "",
                                 date: "",
                                 explanation: "",
                                 url: "",
                                 mediaType: "image")
    }
}
