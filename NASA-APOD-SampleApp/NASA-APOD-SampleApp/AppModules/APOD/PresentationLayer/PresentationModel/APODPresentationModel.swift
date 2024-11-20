//
//  APODPresentationModel.swift
//  NASA-APOD-SampleApp
//
//  Created by Ali Farhadi on 11/19/24.
//

import Foundation

struct APODPresentationModel {
    let title: String
    let copyright: String
    let date: String
    let explanation: String
    let url: URL?
    let mediaType: MediaType
    
    static func placeholder() -> Self {
        .init(title: "Title",
              copyright: "Copyright",
              date: "Date",
              explanation: "Explanation",
              url: nil,
              mediaType: .other)
    }
}
