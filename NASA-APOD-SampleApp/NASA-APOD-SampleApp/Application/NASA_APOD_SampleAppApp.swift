//
//  NASA_APOD_SampleAppApp.swift
//  NASA-APOD-SampleApp
//
//  Created by Ali Farhadi on 11/15/24.
//

import SwiftUI

@main
struct NASA_APOD_SampleAppApp: App {
    
    @StateObject var navController = NavigationController()
    let appDependencyContainer = AppDependencyContainer()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navController.path) {
                TabView {
                    appDependencyContainer.apodDependencyContainer.rootView
                }
            }
            .environmentObject(navController)
        }
    }
    
}
