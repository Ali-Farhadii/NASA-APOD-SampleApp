//
//  URLSessionServiceTests.swift
//  NASA-APOD-SampleAppTests
//
//  Created by Ali Farhadi on 11/15/24.
//

import XCTest
@testable import NASA_APOD_SampleApp

final class URLSessionServiceTests: XCTestCase {

    var service: URLSessionService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        service = nil
    }
    
    func testRequest_WithValidEndPoint_ShouldDecodeResponse() async {
        let endPoint = MockValidEndpoint()
        
        let mockResponse = MockResponse(message: "Success")
        let jsonData = try! JSONEncoder().encode(mockResponse)
        
        let mockURLSession = MockURLSession()
        mockURLSession.data = jsonData
        mockURLSession.response = HTTPURLResponse(url: endPoint.createURLRequest()!.url!,
                                                  statusCode: 200,
                                                  httpVersion: nil,
                                                  headerFields: nil)
        
        service = URLSessionService(urlSession: mockURLSession)

        do {
            let response: MockResponse = try await service.request(with: endPoint)
            
            XCTAssertEqual(response.message, "Success")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testRequest_WithInvalidEndPoint_ShouldThrowError() {
        let endPoint = MockInvalidEndpoint()
        
        let mockURLSession = MockURLSession()
        mockURLSession.error = NSError(domain: "URL Can Not Be Created", code: 0)
        
        service = URLSessionService(urlSession: mockURLSession)
        
        let expectation = XCTestExpectation(description: "Request completion")
        
        let task = Task.detached {
            do {
                let _: MockResponse = try await self.service.request(with: endPoint)
                XCTFail("Expected error to be thrown.")
            } catch {
                XCTAssertEqual((error as NSError).domain, "URL Can Not Be Created")
                XCTAssertEqual((error as NSError).code, 0)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        task.cancel()
    }
    
    func testRequest_WithEmptyData_ShouldThrowError() async throws {
        let endPoint = MockInvalidEndpoint()
        
        let mockURLSession = MockURLSession()
        mockURLSession.data = Data() // Empty data
        service = URLSessionService(urlSession: mockURLSession)
        
        do {
            let _: MockResponse = try await self.service.request(with: endPoint)
            XCTFail("Expected error to be thrown.")
        } catch {
            
        }
    }
}
