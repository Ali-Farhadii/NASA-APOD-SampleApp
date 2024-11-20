//
//  APODRepository.swift
//  NASA-APOD-SampleApp
//
//  Created by Ali Farhadi on 11/19/24.
//

import Foundation

protocol APODRepositoryProtocol {
    func fetchAPOD(with date: String) async throws -> APODBusinessModel
}

struct APODRepository: APODRepositoryProtocol {
    
    private let remoteDataSource: APODRemoteDataSource
    
    init(remoteDataSource: APODRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    func fetchAPOD(with date: String) async throws -> APODBusinessModel {
        try await remoteDataSource.fetchAPOD(with: date)
    }
}
