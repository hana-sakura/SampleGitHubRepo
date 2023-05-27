//
//  RepositoryDetailView.swift
//  SampleGitHubRepo
//

import SwiftUI
import WebKit

struct RepositoryDetailView: View {
    let repository: Repository

    var body: some View {
        WebView(urlString: repository.htmlURL)
            .navigationTitle(repository.name)
    }
}

struct WebView: UIViewRepresentable {
    let urlString: String

    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: urlString) else {
            return WKWebView()
        }

        let request = URLRequest(url: url)
        let webView = WKWebView()
        webView.load(request)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
