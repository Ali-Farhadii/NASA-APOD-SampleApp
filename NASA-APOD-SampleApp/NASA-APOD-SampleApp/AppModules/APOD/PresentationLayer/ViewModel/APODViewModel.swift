//
//  APODViewModel.swift
//  NASA-APOD-SampleApp
//
//  Created by Ali Farhadi on 11/19/24.
//

import Foundation

class APODViewModel: ObservableObject {
    
    @Published var imageURL: URL?
    private let repository: APODRepository
    
    init(repository: APODRepository) {
        self.repository = repository
    }
    
    func fetchAPOD(with date: Date) {
        Task {
            do {
                let response = try await repository.fetchAPOD(with: Date())
                print(response)
            } catch {
                print(error)
            }
        }
    }
    
}
