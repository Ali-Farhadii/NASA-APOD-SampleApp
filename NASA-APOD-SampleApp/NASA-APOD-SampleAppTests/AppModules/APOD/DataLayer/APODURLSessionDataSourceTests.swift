//
//  APODURLSessionDataSourceTests.swift
//  NASA-APOD-SampleAppTests
//
//  Created by Ali Farhadi on 11/20/24.
//

import XCTest
@testable import NASA_APOD_SampleApp

final class APODURLSessionDataSourceTests: XCTestCase {

    var networkService: MockNetworkService!
    var dataSource: APODRemoteDataSource!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        networkService = nil
        dataSource = nil
    }
    
    func testFetchAPOD_WithValidNetworkService_ShouldReturnAPODData() async throws {
        var networkService = MockNetworkService()
        let expectedData = APODDecodableModel(title: "title",
                                             copyright: "",
                                             date: "",
                                             explanation: "",
                                             url: "",
                                             mediaType: "image")
        networkService.mockRequestResult = expectedData
        
        let dataSource = APODURLSessionDataSource(networkService: networkService)
        let apodData: APODBusinessModel = try await dataSource.fetchAPOD(with: "2024-11-20")
        
        XCTAssertEqual(apodData.mediaType, expectedData.mediaType)
        XCTAssertEqual(apodData.title, expectedData.title)
    }
    
    func testFetchAPOD_WithNetworkError_ShouldThrowError() async throws {
        var networkService = MockNetworkService()
        networkService.mockRequestError = NSError(domain: "NetworkFakeError", code: 0, userInfo: nil)
        let dataSource = APODURLSessionDataSource(networkService: networkService)
        
        do {
            let _ = try await dataSource.fetchAPOD(with: Date().toString())
            XCTFail("Expected error to be thrown.")
        } catch let error {
            XCTAssertEqual((error as NSError).domain, "NetworkFakeError")
        }
    }
}
