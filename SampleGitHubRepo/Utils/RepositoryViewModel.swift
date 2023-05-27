//
//  RepositoryViewModel.swift
//  SampleGitHubRepo
//

import Foundation
import Combine

class RepositoryViewModel: ObservableObject {
    @Published var repositories: [Repository] = []
    private var cancellables = Set<AnyCancellable>()

    func searchRepositories(searchText: String) {
        guard let url = createSearchURL(searchText: searchText) else {
            repositories = []
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: RepositorySearchResponse.self, decoder: JSONDecoder())
            .map { $0.items }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: \.repositories, on: self)
            .store(in: &cancellables)
    }

    private func createSearchURL(searchText: String) -> URL? {
        let baseUrl = "https://api.github.com/search/repositories"
        let query = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(baseUrl)?q=\(query)"

        return URL(string: urlString)
    }
}

