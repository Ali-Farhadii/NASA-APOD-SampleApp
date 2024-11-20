//
//  APODEndpoint.swift
//  NASA-APOD-SampleApp
//
//  Created by Ali Farhadi on 11/19/24.
//

import Foundation

struct APODEndpoint: Endpoint {
    var path: String = "/planetary/apod"
    var httpMethod: HTTPMethod = .get
    var httpHeader: [String : String]? = nil
    var httpBody: (any Encodable)? = nil
    var queryParams: [String : String]?
    
    init(selectedDate: String) {
        queryParams = [
            "api_key": Constants.apiKey,
            "date": selectedDate
        ]
    }
}
