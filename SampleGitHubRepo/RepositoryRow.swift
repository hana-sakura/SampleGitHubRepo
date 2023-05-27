//
//  RepositoryRow.swift
//  SampleGitHubRepo
//

import SwiftUI

struct RepositoryRow: View {
    let repository: Repository

    var body: some View {
        VStack(alignment: .leading) {
            Text(repository.name)
                .font(.headline)

            Text(repository.description ?? "No description")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}
