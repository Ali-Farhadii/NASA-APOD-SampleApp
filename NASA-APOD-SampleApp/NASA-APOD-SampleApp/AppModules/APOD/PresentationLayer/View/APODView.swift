//
//  APODView.swift
//  NASA-APOD-SampleApp
//
//  Created by Ali Farhadi on 11/15/24.
//

import SwiftUI

struct APODView: View {
    
    @ObservedObject var viewModel: APODViewModel
    //TODO: Hide/show date picker with below boolean
    @State private var showDatePicker: Bool = false
    @State private var selectedDate: Date = Date()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    if let url = viewModel.apodModel.url {
                        getImageView(with: url)
                    }
                    title
                    copyright
                    explanation
                }
                .padding()
            }
            .navigationTitle(selectedDate.toString())
            .toolbar {
                todayToolbarItem
                calendarToolbarItem
            }
            // TODO: task or onAppear?
            .task {
                viewModel.fetchAPOD(with: selectedDate)
            }
        }
    }
    
    @ViewBuilder func getImageView(with url: URL) -> some View {
        CacheAsyncImage(url: url) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 15))
            } else {
                VStack {
                    ProgressView()
                    Text("Loading...")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .frame(height: 250)
            }
        }
    }
    
    // TODO: Fix duplication of .frame(maxWidth)
    var title: some View {
        Text(viewModel.apodModel.title)
            .frame(maxWidth: .infinity,
                   alignment: .leading)
            .font(.title.bold())
    }
    
    var copyright: some View {
        Text(viewModel.apodModel.copyright)
            .frame(maxWidth: .infinity,
                   alignment: .leading)
            .font(.subheadline.bold())
            .foregroundStyle(.secondary)
    }
    
    var explanation: some View {
        Text(viewModel.apodModel.explanation)
            .frame(maxWidth: .infinity,
                   alignment: .leading)
            .font(.callout)
    }
    
    var calendarToolbarItem: ToolbarItem<Void, some View> {
        ToolbarItem(placement: .topBarTrailing) {
            Image(systemName: "calendar")
                .foregroundStyle(.blue)
                .overlay {
                    DatePicker("Select a date",
                               selection: $selectedDate,
                               in: ...Date(),
                               displayedComponents: [.date])
                    .blendMode(.destinationOver)
                }
                .onChange(of: selectedDate) { newValue in
                    viewModel.refreshAPOD(with: newValue)
                }
        }
    }
    
    var todayToolbarItem: ToolbarItem<Void, some View> {
        ToolbarItem(placement: .topBarLeading) {
            Button("Today") {
                viewModel.fetchAPOD(with: Date())
            }
            .disabled(selectedDate == Date())
        }
    }
    
}

#Preview {
    let apodURLSession = APODURLSessionDataSource(networkService: URLSessionService())
    let repository = APODRepository(remoteDataSource: apodURLSession)
    let viewModel = APODViewModel(repository: repository)
    APODView(viewModel: viewModel)
}
