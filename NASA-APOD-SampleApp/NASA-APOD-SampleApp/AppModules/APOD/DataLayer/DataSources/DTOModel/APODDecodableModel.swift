//
//  APODDecodableModel.swift
//  NASA-APOD-SampleApp
//
//  Created by Ali Farhadi on 11/19/24.
//

import Foundation

struct APODDecodableModel: Decodable {
    let title: String
    let copyright: String?
    let date: String
    let explanation: String
    let url: String?
    let mediaType: String
}
