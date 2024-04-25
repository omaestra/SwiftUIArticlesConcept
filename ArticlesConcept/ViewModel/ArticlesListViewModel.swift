//
//  ArticlesListViewModel.swift
//  ArticlesConcept
//
//  Created by MAC918226 on 23/04/2024.
//

import Foundation

struct ArticleViewModel: Hashable {
    var title: String
    var post: String
}

@MainActor
public final class ArticlesListViewModel: ObservableObject {
    @Published private(set) var isLoading = false
    @Published private(set) var articles: [ArticleViewModel] = []
    @Published private(set) var error: Error?
    
    init(isLoading: Bool = false, articles: [ArticleViewModel] = [], error: Error? = nil) {
        self.isLoading = isLoading
        self.articles = articles
        self.error = error
    }
    
    func didStartLoading() {
        print("Start loading...")
        isLoading = true
    }
    
    func didCancel() {
        isLoading = false
    }
    
    func didFinishLoading(with articles: [ArticleViewModel]) {
        print("Finish loading with articles...")
        self.isLoading = false
        self.articles = articles
    }
    
    func didFinishLoading(with error: Error) {
        print("Finish loading with error: <\(error)>")
        self.isLoading = false
        self.error = error
    }
}
