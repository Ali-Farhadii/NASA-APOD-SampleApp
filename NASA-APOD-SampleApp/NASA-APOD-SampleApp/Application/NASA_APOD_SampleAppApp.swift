//
//  NASA_APOD_SampleAppApp.swift
//  NASA-APOD-SampleApp
//
//  Created by Ali Farhadi on 11/15/24.
//

import SwiftUI

@main
struct NASA_APOD_SampleAppApp: App {
    
    let repository = APODRepository(remoteDataSource: APODURLSessionDataSource(networkService: URLSessionService()))
    
    var body: some Scene {
        WindowGroup {
            APODView(viewModel: APODViewModel(repository: repository))
        }
    }
}
