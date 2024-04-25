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
                
        await sut.onRefresh?()
        XCTAssertEqual(loader.loadArticlesCallCount, 2)
    }
    
    private func makeSUT() -> (sut: ArticlesListView, loader: MockArticlesLoader) {
        let loader = MockArticlesLoader()
        let sut = ArticlesListUIComposer.composedWith(loader: loader)
        
        return (sut, loader)
    }
}

final class MockArticlesLoader: ArticlesLoader {
    private var requests = [Article]()
    
    var loadArticlesCallCount: Int {
        return requests.count
    }
    
    func load() async throws -> [Article] {
        requests = [
            Article(title: "an article", post: "a post"),
            Article(title: "another article", post: "another post")
        ]
        
        return requests
    }
}
