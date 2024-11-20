//
//  MockEndpoint.swift
//  NASA-APOD-SampleAppTests
//
//  Created by Ali Farhadi on 11/20/24.
//

import Foundation
@testable import NASA_APOD_SampleApp

struct MockValidEndpoint: Endpoint {
    var path: String = "/api/data"
    var httpMethod: HTTPMethod = .get
    var httpHeader: [String : String]?
    var httpBody: (any Encodable)?
    var queryParams: [String : String]?
}

struct MockInvalidEndpoint: Endpoint {
    var path: String = "/api/invalid"
    var httpMethod: HTTPMethod = .get
    var httpHeader: [String : String]?
    var httpBody: (any Encodable)?
    var queryParams: [String : String]?
}
