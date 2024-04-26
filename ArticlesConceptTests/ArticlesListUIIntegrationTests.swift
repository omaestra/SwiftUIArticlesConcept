//
//  ArticlesListUIIntegrationTests.swift
//  ArticlesConceptTests
//
//  Created by MAC918226 on 23/04/2024.
//

import XCTest
import SwiftUI
@testable import ArticlesConcept

@MainActor
final class ArticlesListUIIntegrationTests: XCTestCase {
    func test_loadArticles_requestArticlesFromLoader() async {
        let (sut, loader) = makeSUT()
        loader.completeLoading(with: makeArticlesResult())
                
        await sut.onRefresh?()
        XCTAssertEqual(loader.loadArticlesCallCount, 2)
    }
    
    private func makeSUT() -> (sut: ArticlesListView, loader: ArticlesLoaderStub) {
        let loader = ArticlesLoaderStub()
        let sut = ArticlesListUIComposer.composedWith(loader: loader)
        
        return (sut, loader)
    }
    
    // MARK: Helpers
    
    private func makeArticlesResult() -> [Article] {
        [
            Article(title: "an article", post: "a post"),
            Article(title: "another article", post: "another post")
        ]
    }
}

final class ArticlesLoaderStub: ArticlesLoader {
    private var articles = [Article]()
    private var error: Error?
    
    var loadArticlesCallCount: Int {
        return articles.count
    }
    
    func load() async throws -> [Article] {
        if let error {
            throw error
        }
        
        return articles
    }
    
    func completeLoading(with articles: [Article]) {
        self.articles = articles
    }
    
    func completeLoading(with error: Error) {
        self.error = error
    }
}
