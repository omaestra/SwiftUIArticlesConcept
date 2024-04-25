//
//  ArticlesListPresentationAdapter.swift
//  ArticlesConcept
//
//  Created by MAC918226 on 25/04/2024.
//

import Foundation

@MainActor
final class ArticlesListPresentationAdapter {
    private let loader: ArticlesLoader
    var viewModel: ArticlesListViewModel?
    
    init(loader: ArticlesLoader, viewModel: ArticlesListViewModel? = nil) {
        self.loader = loader
        self.viewModel = viewModel
    }
    
    func load() async {
        guard let viewModel, !viewModel.isLoading else { return }
        
        do {
            viewModel.didStartLoading()
            let articles = try await loader.load()
            self.viewModel?.didFinishLoading(with: map(articles))
        } catch {
            viewModel.didFinishLoading(with: error)
        }
    }
    
    private func map(_ articles: [Article]) -> [ArticleViewModel] {
        articles.map {
            ArticleViewModel(title: $0.title, post: $0.post)
        }
    }
}