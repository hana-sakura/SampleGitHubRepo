//
//  ContentView.swift
//  SampleGitHubRepo
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @StateObject private var viewModel = RepositoryViewModel()

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, onSearch: {
                    viewModel.searchRepositories(searchText: searchText)
                })
                .padding()

                List(viewModel.repositories) { repository in
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
