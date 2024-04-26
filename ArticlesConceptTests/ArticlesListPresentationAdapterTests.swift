//
//  ArticlesListPresentationAdapterTests.swift
//  ArticlesConceptTests
//
//  Created by MAC918226 on 26/04/2024.
//

import XCTest
@testable import ArticlesConcept

final class ArticlesListPresentationAdapterTests: XCTestCase {

    func test_load_displaysErrorOnLoaderError() async throws {
        let (sut, loader) = makeSUT()
        loader.completeLoading(with: anyNSError())
        
        await sut.load()
        
        XCTAssertEqual(sut.viewModel?.error as? NSError, anyNSError())
    }
    
    func test_load_loadsArticles() async throws {
        let (sut, loader) = makeSUT()
        loader.completeLoading(with: makeArticlesResult())
        
        await sut.load()
        
        XCTAssertEqual(sut.viewModel?.articles.count, 2)
    }
    
    // MARK: Helpers
    
    private func makeSUT() -> (sut: ArticlesListPresentationAdapter, loader: ArticlesLoaderStub) {
        let loader = ArticlesLoaderStub()
        let viewModel = ArticlesListViewModel()
        let sut = ArticlesListPresentationAdapter(loader: loader)
        sut.viewModel = viewModel
        
        return (sut, loader)
    }
    
    private func makeArticlesResult() -> [Article] {
        [
            Article(title: "an article", post: "a post"),
            Article(title: "another article", post: "another post")
        ]
    }
}
