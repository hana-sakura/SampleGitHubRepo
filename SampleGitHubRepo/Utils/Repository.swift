//
//  Repository.swift
//  SampleGitHubRepo
//

import Foundation

struct Repository: Decodable, Identifiable {
    let id: String
    let name: String
    let description: String?
    let url: String
}

struct SearchResponse: Decodable {
    let data: DataResponse
}

struct DataResponse: Decodable {
    let search: SearchResult
}

struct SearchResult: Decodable {
    let edges: [Edge]
}

struct Edge: Decodable {
    let node: Repository
}
