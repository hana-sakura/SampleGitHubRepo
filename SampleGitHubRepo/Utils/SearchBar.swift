//
//  SearchBar.swift
//  SampleGitHubRepo
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    let onSearch: () -> Void

    var body: some View {
        HStack {
            TextField("Search", text: $text, onCommit: {
                onSearch()
            })
            .padding(8)
            .background(Color(.systemGray5))
            .cornerRadius(8)

            Button(action: {
                text = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .padding(8)
                    .foregroundColor(.gray)
            }
            .opacity(text.isEmpty ? 0 : 1)
        }
    }
}
