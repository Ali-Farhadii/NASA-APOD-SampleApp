//
//  YoutubeView.swift
//  NASA-APOD-SampleApp
//
//  Created by Ali Farhadi on 11/20/24.
//

import SwiftUI
import WebKit

struct YouTubeView: UIViewRepresentable {
    let videoURL: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: videoURL)
        uiView.load(request)
    }
}
