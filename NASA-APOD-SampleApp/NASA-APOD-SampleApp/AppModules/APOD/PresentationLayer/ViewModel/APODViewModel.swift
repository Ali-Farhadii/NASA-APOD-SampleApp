//
//  APODViewModel.swift
//  NASA-APOD-SampleApp
//
//  Created by Ali Farhadi on 11/19/24.
//

import Foundation

class APODViewModel: ObservableObject {
    
    @Published var apodModel: APODPresentationModel = .placeholder()
    private let repository: APODRepository
    
    init(repository: APODRepository) {
        self.repository = repository
    }

    @MainActor
    func fetchAPOD(with date: Date) {
        Task {
            do {
                let formattedDate = date.changeFormat(to: "yyyy-MM-dd")
                let response = try await repository.fetchAPOD(with: formattedDate)
                apodModel = mapToAPODPresentationModel(with: response)
                print(response)
            } catch {
                print(error)
            }
        }
    }
    
    @MainActor
    func refreshAPOD(with date: Date) {
        apodModel = .placeholder()
        fetchAPOD(with: date)
    }
    
    func mapToAPODPresentationModel(with response: APODBusinessModel) -> APODPresentationModel {
        guard let imageURL = URL(string: response.url) else { return .placeholder() }
        
        return APODPresentationModel(title: response.title,
                                     copyright: "Copyright: \(response.copyright)",
                                     date: response.date,
                                     explanation: response.explanation,
                                     url: imageURL,
                                     mediaType: MediaType(rawValue: response.mediaType) ?? .image)
    }
    
}
