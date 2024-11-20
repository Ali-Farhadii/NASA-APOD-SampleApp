//
//  GenericErrorModel.swift
//  NASA-APOD-SampleApp
//
//  Created by Ali Farhadi on 11/20/24.
//

import Foundation

struct GenericErrorModel: Decodable {
    let code: Int
    let msg: String
}