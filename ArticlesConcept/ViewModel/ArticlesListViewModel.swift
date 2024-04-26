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

public final class ArticlesListViewModel: ObservableObject {
    @Published private(set) var isLoading = false
    @Published private(set) var articles: [ArticleViewModel] = []
    @Published private(set) var error: Error?
    
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
