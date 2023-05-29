//
//  GitHubAPIClient.swift
//  SampleGitHubRepo
//

import Foundation
import Combine

class GitHubAPIClient: ObservableObject {

    @Published var repositories: [Repository] = []
    private var cancellables: Set<AnyCancellable> = []

    func searchRepositories(query: String) {
        let graphQLQuery = """
        query SearchRepositories($query: String!) {
          search(query: $query, type: REPOSITORY, first: 50) {
            edges {
              node {
                ... on Repository {
                  id
                  name
                  description
                  url
                }
              }
            }
          }
        }
        """

        let variables = ["query": query]
        let apiUrl = URL(string: "https://api.github.com/graphql")!
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        let token = "ACCESS_TOKEN"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = ["query": graphQLQuery, "variables": variables] as [String : Any]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: SearchResponse.self, decoder: JSONDecoder())
            .map { $0.data.search.edges.map { $0.node } }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] repositories in
                self?.repositories = repositories
            }
            .store(in: &cancellables)
    }

}
