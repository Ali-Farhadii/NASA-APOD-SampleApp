//
//  Endpoint.swift
//  NASA-APOD-SampleApp
//
//  Created by Ali Farhadi on 11/19/24.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var httpHeader: [String: String]? { get }
    var allHeaders: [String: String] { get }
    var httpBody: Encodable? { get }
    var queryParams: [String: String]? { get }
}

extension Endpoint {
    var allHeaders: [String: String] {
        defaultHeaders.merging(httpHeader ?? [:]) { (_, new) in new }
    }
    
    private var defaultHeaders: [String: String] {
        [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
    
    func createURLRequest() -> URLRequest? {
        guard let url = getURL() else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        if let body = httpBody {
            let jsonData = try? encoder.encode(body)
            urlRequest.httpBody = jsonData
        }
        
        allHeaders.forEach {
            urlRequest.addValue($1, forHTTPHeaderField: $0)
        }
        
        return urlRequest
    }
    
    func getURL() -> URL? {
        var urlComponent = URLComponents(string: Constants.baseURL)
        urlComponent?.path += path
        urlComponent?.queryItems = getQueryItems()
        return urlComponent?.url
    }
    
    private func getQueryItems() -> [URLQueryItem]? {
        guard let parameters = queryParams, !parameters.isEmpty else { return nil }
        
        var queryItems = [URLQueryItem]()
        queryItems = parameters.map { URLQueryItem(name: $0.key,
                                                   value: String(describing: $0.value)) }
        return queryItems
    }
    
}
