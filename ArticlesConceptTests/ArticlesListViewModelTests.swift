//
//  ArticlesListViewModelTests.swift
//  ArticlesConceptTests
//
//  Created by MAC918226 on 24/04/2024.
//

import XCTest
@testable import ArticlesConcept

final class ArticlesListViewModelTests: XCTestCase {
    func test_init_doesNotStartsLoading() throws {
        let sut = ArticlesListViewModel()
        
        XCTAssertFalse(sut.isLoading)
    }
    
    func test_startLoading_setsLoadingToTrue() throws {
        let sut = ArticlesListViewModel()
        
        sut.didStartLoading()
        
        XCTAssertTrue(sut.isLoading)
    }
    
    func test_didFinishLoadingWithArticles_updatesLoadingState() throws {
        let articles: [ArticleViewModel] = [
            ArticleViewModel(title: "any title", post: "any post"),
            ArticleViewModel(title: "another title", post: "another post")
        ]
        let sut = ArticlesListViewModel()
        
        sut.didStartLoading()
        XCTAssertTrue(sut.isLoading)
        
        sut.didFinishLoading(with: articles)
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(sut.articles, articles)
    }
    
    func test_didFinishLoadingWithError_updatesLoadingState() throws {
        let error: NSError = anyNSError()
        let sut = ArticlesListViewModel()
        
        sut.didStartLoading()
        XCTAssertTrue(sut.isLoading)
        
        sut.didFinishLoading(with: error)
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(sut.error as? NSError, error)
    }
}

func anyNSError() -> NSError {
    NSError(domain: "any error", code: 0)
}
