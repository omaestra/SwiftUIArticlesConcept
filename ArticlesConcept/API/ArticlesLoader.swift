//
//  ArticlesLoader.swift
//  ArticlesConcept
//
//  Created by MAC918226 on 23/04/2024.
//

import Foundation

protocol ArticlesLoader {
    func load() async throws -> [Article]
}

class LocalArticlesLoader: ArticlesLoader {
    func load() async throws -> [Article] {
        try await Task.sleep(for: .seconds(3))
        return [
            Article(title: "an article", post: "a post"),
            Article(title: "another article", post: "another post")
        ]
    }
}
