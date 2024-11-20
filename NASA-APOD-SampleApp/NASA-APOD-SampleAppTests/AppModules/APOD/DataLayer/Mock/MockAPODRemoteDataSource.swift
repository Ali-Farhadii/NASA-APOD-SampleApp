//
//  MockAPODRemoteDataSource.swift
//  NASA-APOD-SampleAppTests
//
//  Created by Ali Farhadi on 11/20/24.
//

import Foundation
@testable import NASA_APOD_SampleApp

struct MockAPODRemoteDataSource: APODRemoteDataSource {
    func fetchAPOD(with date: String) async throws -> APODBusinessModel {
        APODBusinessModel(title: "Title",
                          copyright: "",
                          date: "",
                          explanation: "",
                          url: "",
                          mediaType: "image")
    }
}
