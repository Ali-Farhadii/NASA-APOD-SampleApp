//
//  APODRemoteDataSource.swift
//  NASA-APOD-SampleApp
//
//  Created by Ali Farhadi on 11/19/24.
//

import Foundation

protocol APODRemoteDataSource {
    func fetchAPOD(with date: Date) async throws -> APODBusinessModel
}

struct APODURLSessionDataSource: APODRemoteDataSource {
    
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchAPOD(with date: Date) async throws -> APODBusinessModel {
        APODBusinessModel()
    }
}
