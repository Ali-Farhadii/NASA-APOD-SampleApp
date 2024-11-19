//
//  APODRepository.swift
//  NASA-APOD-SampleApp
//
//  Created by Ali Farhadi on 11/19/24.
//

import Foundation

protocol APODRepositoryProtocol {
    func fetchAPOD(with date: Date) async throws -> APODBusinessModel
}

struct APODRepository: APODRepositoryProtocol {
    func fetchAPOD(with date: Date) async throws -> APODBusinessModel {
        APODBusinessModel()
    }
}
