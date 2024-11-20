//
//  APODView.swift
//  NASA-APOD-SampleApp
//
//  Created by Ali Farhadi on 11/15/24.
//

import SwiftUI
import AVKit

struct APODView: View {
    
    @ObservedObject var viewModel: APODViewModel
    @State private var selectedDate: Date = Date()
    @State private var isShowErrorAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    mediaView
                    title
                    copyright
                    explanation
                }
                .padding()
                .redacted(reason: viewModel.isLoading ? .placeholder : [])
            }
            .navigationTitle(selectedDate.toString())
            .toolbar {
                todayToolbarItem
                calendarToolbarItem
            }
            .task {
                viewModel.fetchAPOD(with: selectedDate)
            }
            .onChange(of: viewModel.errorModel) { newValue in
                isShowErrorAlert = newValue != nil
            }
            .alert("Something went wrong.",
                   isPresented: $isShowErrorAlert) {
                Button("OK") {
                    isShowErrorAlert = false
                }
                Button("Retry") {
                    viewModel.fetchAPOD(with: selectedDate)
                }
            } message: {
                Text(viewModel.errorModel?.msg ?? "")
                    .foregroundStyle(.primary)
                    .font(.body)
            }
        }
    }
    
    var mediaView: some View {
        VStack {
            switch viewModel.apodModel.mediaType {
            case .image:
                if let url = viewModel.apodModel.url {
                    getImageView(with: url)
                }
            case .video:
                if let url = viewModel.apodModel.url {
                    VideoPlayer(player: AVPlayer(url: url))
                        .frame(height: 250)
                }
            case .other:
                Image(systemName: "photo")
                    .frame(height: 250)
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
    
    var title: some View {
        Text(viewModel.apodModel.title)
            .frame(maxWidth: .infinity,
                   alignment: .leading)
            .font(.title.bold())
            .foregroundStyle(.primary)
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
            .font(.body)
            .foregroundStyle(.primary)
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
                    .foregroundStyle(.primary)
                    .font(.body)
                }
                .onChange(of: selectedDate) { newValue in
                    viewModel.refreshAPOD(with: newValue)
                }
        }
    }
    
    var todayToolbarItem: ToolbarItem<Void, some View> {
        ToolbarItem(placement: .topBarLeading) {
            Button("Today") {
                selectedDate = Date()
                viewModel.fetchAPOD(with: selectedDate)
            }
            .disabled(selectedDate.equalDay(with: Date()))
        }
    }
    
}

#Preview {
    let apodURLSession = APODURLSessionDataSource(networkService: URLSessionService())
    let repository = APODRepository(remoteDataSource: apodURLSession)
    let viewModel = APODViewModel(repository: repository)
    APODView(viewModel: viewModel)
}
