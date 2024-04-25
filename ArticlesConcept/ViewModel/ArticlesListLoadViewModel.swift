//
//  ArticlesListLoadViewModel.swift
//  ArticlesConcept
//
//  Created by MAC918226 on 25/04/2024.
//

import Foundation

@MainActor
public final class ArticlesListLoadViewModel: ObservableObject {
    @Published private(set) var isLoading = false
    @Published private(set) var articles: [ArticleViewModel] = []
    @Published private(set) var error: Error?
    
    private var loader: ArticlesLoader
    
    init(loader: ArticlesLoader) {
        self.loader = loader
    }
    
    func load() async throws {
        defer {
            isLoading = false
        }
        
        do {
            guard !isLoading else { return }
            isLoading = true
            let articles = try await loader.load()
            self.articles = articles.map {
                ArticleViewModel(title: $0.title, post: $0.post)
            }
        } catch {
            self.error = error
        }
    }
}
