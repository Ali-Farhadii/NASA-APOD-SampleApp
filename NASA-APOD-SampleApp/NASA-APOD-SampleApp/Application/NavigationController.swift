//
//  NavigationController.swift
//  NASA-APOD-SampleApp
//
//  Created by Ali Farhadi on 11/20/24.
//

import SwiftUI

class NavigationController: ObservableObject {
    
    @Published var path = NavigationPath()
    
    func navigate(to destination: any Hashable) {
        path.append(destination)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRootView() {
        path.removeLast(path.count)
    }
}
