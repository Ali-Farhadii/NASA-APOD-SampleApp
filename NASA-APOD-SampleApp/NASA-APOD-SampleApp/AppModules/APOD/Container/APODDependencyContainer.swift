//
//  APODDependencyContainer.swift
//  NASA-APOD-SampleApp
//
//  Created by Ali Farhadi on 11/19/24.
//

import SwiftUI

struct APODDependencyContainer {
    
    @MainActor
    var rootView: some View {
        APODView(viewModel: apodViewModel)
            .tabItem {
                Label("APOD", systemImage: "globe.asia.australia")
            }
    }
    
    @MainActor
    private var apodViewModel: APODViewModel {
        APODViewModel(repository: apodRepository)
    }
    
    @MainActor
    private var apodRepository: APODRepositoryProtocol {
        APODRepository(remoteDataSource: remoteDataSource)
    }
    
    private var remoteDataSource: APODRemoteDataSource {
        APODURLSessionDataSource(networkService: URLSessionService())
    }

}
