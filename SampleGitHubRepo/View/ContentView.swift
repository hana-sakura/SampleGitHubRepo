//
//  ContentView.swift
//  SampleGitHubRepo
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @StateObject private var apiClient = GitHubAPIClient()

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, onSearch: {
                    apiClient.searchRepositories(query: searchText)
                })
                .padding()

                List(apiClient.repositories) { repository in
                    NavigationLink(destination: RepositoryDetailView(repository: repository)) {
                        RepositoryRow(repository: repository)
                    }
                }
            }
            .navigationTitle("GitHub Repositories")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
