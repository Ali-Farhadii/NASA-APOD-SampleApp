//
//  APODRemoteDataSource.swift
//  NASA-APOD-SampleApp
//
//  Created by Ali Farhadi on 11/19/24.
//

import Foundation

protocol APODRemoteDataSource {
    func fetchAPOD(with date: String) async throws -> APODBusinessModel
}

struct APODURLSessionDataSource: APODRemoteDataSource {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchAPOD(with date: String) async throws -> APODBusinessModel {
        let apodEndpoint = APODEndpoint(selectedDate: date)
        let response: APODDecodableModel = try await networkService.request(with: apodEndpoint)
        return mapToAPODBusinessModel(response)
    }
    
    func mapToAPODBusinessModel(_ response: APODDecodableModel) -> APODBusinessModel {
        APODBusinessModel(title: response.title,
                          copyright: response.copyright,
                          date: response.date,
                          explanation: response.explanation,
                          url: response.url,
                          mediaType: response.mediaType)
    }
}
