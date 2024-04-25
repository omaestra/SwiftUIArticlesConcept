//
//  ArticlesListView.swift
//  ArticlesConcept
//
//  Created by MAC918226 on 23/04/2024.
//

import SwiftUI

struct ArticlesListView: View {
    @ObservedObject var viewModel: ArticlesListViewModel
    
    init(viewModel: ArticlesListViewModel) {
        self.viewModel = viewModel
    }
    
    var onRefresh: (() async -> Void)?
    var onCancel: (() -> Void)?
    var onSelection: ((ArticleViewModel) -> Void)?
    
    var body: some View {
        List {
            if viewModel.isLoading, viewModel.articles.isEmpty {
                ProgressView()
                    .frame(maxWidth: .infinity)
            }
            ForEach(viewModel.articles, id: \.self) { item in
                VStack(alignment: .leading) {
                    Text(item.title)
                    Text(item.post)
                }
                .redacted(reason: viewModel.isLoading ? [.placeholder] : [])
                .onTapGesture {
                    onSelection?(item)
                }
            }
        }
        .task {
            await onRefresh?()
        }
        .refreshable {
            await onRefresh?()
        }
    }
}

#Preview {
    ArticlesListView(viewModel: ArticlesListViewModel())
}