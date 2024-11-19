//
//  APODView.swift
//  NASA-APOD-SampleApp
//
//  Created by Ali Farhadi on 11/15/24.
//

import SwiftUI

struct APODView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    APODView()
}
