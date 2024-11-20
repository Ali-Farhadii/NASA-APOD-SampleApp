//
//  APODViewModel.swift
//  NASA-APOD-SampleApp
//
//  Created by Ali Farhadi on 11/19/24.
//

import Foundation

class APODViewModel: ObservableObject {
    
    @Published var apodModel: APODPresentationModel = .placeholder()
    @Published var errorModel: GenericErrorModel?
    private let repository: APODRepository
    
    init(repository: APODRepository) {
        self.repository = repository
    }

    @MainActor
    func fetchAPOD(with date: Date) {
        errorModel = nil
        Task {
            do {
                let formattedDate = date.changeFormat(to: "yyyy-MM-dd")
                let response = try await repository.fetchAPOD(with: formattedDate)
                apodModel = mapToAPODPresentationModel(with: response)
            } catch let error as NetworkError {
                handleError(error)
            } catch {
                errorModel = GenericErrorModel(code: 400,
                                               msg: "Unexpected error")
            }
        }
    }
    
    @MainActor
    func refreshAPOD(with date: Date) {
        apodModel = .placeholder()
        fetchAPOD(with: date)
    }
    
    private func mapToAPODPresentationModel(with response: APODBusinessModel) -> APODPresentationModel {
        //TODO: Error handling for invalid URL
        guard let imageURL = URL(string: response.url) else { return .placeholder() }
        
        return APODPresentationModel(title: response.title,
                                     copyright: "Copyright: \(response.copyright)",
                                     date: response.date,
                                     explanation: response.explanation,
                                     url: imageURL,
                                     mediaType: MediaType(rawValue: response.mediaType) ?? .other)
    }
    
    private func handleError(_ error: NetworkError) {
        switch error {
        case .decodeFailed(let errorModel):
            self.errorModel = errorModel
        case .invalidResponse(let errorModel):
            self.errorModel = errorModel
        case .badRequest(let errorModel):
            self.errorModel = errorModel
        }
    }
    
}
