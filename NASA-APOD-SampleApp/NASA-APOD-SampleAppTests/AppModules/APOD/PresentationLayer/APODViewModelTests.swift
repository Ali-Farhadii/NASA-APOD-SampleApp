//
//  APODViewModelTests.swift
//  NASA-APOD-SampleAppTests
//
//  Created by Ali Farhadi on 11/20/24.
//

import XCTest
@testable import NASA_APOD_SampleApp

@MainActor
final class APODViewModelTests: XCTestCase {

    var mockRepository: MockAPODRepository!
    var viewModel: APODViewModel!
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        mockRepository = nil
        viewModel = nil
    }

    func testFetchAPOD_withValidRepositoryResponse_shouldSuccess() {
        mockRepository = MockAPODRepository()
        mockRepository.expectedError = false
        viewModel = APODViewModel(repository: mockRepository)
        
        XCTAssertNil(viewModel.errorModel)
        
        viewModel.fetchAPOD(with: Date())
        
        let predication = NSPredicate { _, _ in
            self.viewModel.apodModel == .placeholder()
        }
        let expectations = [XCTNSPredicateExpectation(predicate: predication,
                                                      object: viewModel)]

        wait(for: expectations, timeout: 5)
        XCTAssertNil(viewModel.errorModel)
        XCTAssertEqual(viewModel.apodModel.title, "Title")
    }
    
    func testFetchAPOD_withInvalidRepositoryResponse_shouldFail() {
        mockRepository = MockAPODRepository()
        mockRepository.expectedError = true
        viewModel = APODViewModel(repository: mockRepository)
        
        XCTAssertNil(viewModel.errorModel)
        
        viewModel.fetchAPOD(with: Date())
        
        let predication = NSPredicate { _, _ in
            self.viewModel.apodModel == .placeholder()
        }
        let expectations = [XCTNSPredicateExpectation(predicate: predication,
                                                      object: viewModel)]

        wait(for: expectations, timeout: 5)
        XCTAssertNotNil(viewModel.errorModel)
        XCTAssertEqual(viewModel.apodModel, .placeholder())
    }
    
}
