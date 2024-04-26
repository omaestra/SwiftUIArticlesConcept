//
//  ArticlesListPresentationAdapter.swift
//  ArticlesConcept
//
//  Created by MAC918226 on 25/04/2024.
//

import Foundation

final class ArticlesListPresentationAdapter {
    private let loader: ArticlesLoader
    var viewModel: ArticlesListViewModel?
    
    private var task: Task<Void, Never>?
    
    init(loader: ArticlesLoader, viewModel: ArticlesListViewModel? = nil) {
        self.loader = loader
        self.viewModel = viewModel
    }
    
    func load() async {
        guard let viewModel, !viewModel.isLoading else { return }
        
        task = Task { @MainActor in
            do {
                viewModel.didStartLoading()
                let articles = try await loader.load()
                viewModel.didFinishLoading(with: map(articles))
            } catch is CancellationError {
                viewModel.didCancel()
            } catch {
                viewModel.didFinishLoading(with: error)
            }
        }
        
        await task?.value
    }
    
    func cancel() {
        task?.cancel()
    }
    
    private func map(_ articles: [Article]) -> [ArticleViewModel] {
        articles.map {
            ArticleViewModel(title: $0.title, post: $0.post)
        }
    }
}
