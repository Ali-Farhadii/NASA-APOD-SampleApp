//
//  APODRepositoryTests.swift
//  NASA-APOD-SampleAppTests
//
//  Created by Ali Farhadi on 11/20/24.
//

import XCTest
@testable import NASA_APOD_SampleApp

final class APODRepositoryTests: XCTestCase {

    var remoteDataSource: MockAPODRemoteDataSource!
    var repository: APODRepositoryProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        remoteDataSource = nil
        repository = nil
    }
    
    func testFetchAPOD_withValidRemoteDataSource_shouldReturnAPOD() async throws {
        remoteDataSource = MockAPODRemoteDataSource()
        repository = APODRepository(remoteDataSource: remoteDataSource)
        
        let apodData = try await repository.fetchAPOD(with: Date().toString())
        
        XCTAssertEqual(apodData.title, "Title")
        XCTAssertEqual(apodData.mediaType, "image")
    }
}

