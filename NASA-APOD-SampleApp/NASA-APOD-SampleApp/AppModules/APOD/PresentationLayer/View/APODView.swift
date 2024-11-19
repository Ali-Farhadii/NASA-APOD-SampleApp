//
//  APODView.swift
//  NASA-APOD-SampleApp
//
//  Created by Ali Farhadi on 11/15/24.
//

import SwiftUI

struct APODView: View {
    
    @ObservedObject var viewModel: APODViewModel
    @State private var showDatePicker: Bool = false
    @State private var selectedDate: Date = Date()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    imageView
                    
                    // TODO: Fix duplication of .frame(maxWidth)
                    Text(viewModel.apodModel.title)
                        .frame(maxWidth: .infinity,
                               alignment: .leading)
                        .font(.title.bold())
                    
                    Text(viewModel.apodModel.copyright)
                        .frame(maxWidth: .infinity,
                               alignment: .leading)
                        .font(.subheadline.bold())
                        .foregroundStyle(.secondary)
                    
                    Text(viewModel.apodModel.explanation)
                        .frame(maxWidth: .infinity,
                               alignment: .leading)
                        .font(.callout)
                }
                .padding()
            }
            .navigationTitle("18 November 2024")
            .toolbar {
                // TODO: Show today only when selected data is not today
                todayToolbarItem
                calendarToolbarItem
            }
            // TODO: task or onAppear?
            .task {
                viewModel.fetchAPOD(with: selectedDate)
            }
        }
    }
    
    var imageView: some View {
        AsyncImage(url: viewModel.apodModel.url) { image in
            image
        } placeholder: {
            VStack {
                ProgressView()
                Text("Loading...")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(height: 250)
        }
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
                    viewModel.fetchAPOD(with: newValue)
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
