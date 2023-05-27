//
//  Repository.swift
//  SampleGitHubRepo
//

import Foundation

struct Repository: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String?
    let htmlURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case htmlURL = "html_url"
    }
}

struct RepositorySearchResponse: Codable {
    let items: [Repository]
}

