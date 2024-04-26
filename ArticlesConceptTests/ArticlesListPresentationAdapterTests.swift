//
//  ArticlesListPresentationAdapterTests.swift
//  ArticlesConceptTests
//
//  Created by MAC918226 on 26/04/2024.
//

import XCTest
import Combine
@testable import ArticlesConcept

final class ArticlesListPresentationAdapterTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()

    func test_load_displaysErrorOnLoaderError() async throws {
        var messages = [Message<ArticleViewModel>]()
        let (sut, loader) = makeSUT()
        loader.completeLoading(with: anyNSError())
        sut.viewModel?.$isLoading
            .dropFirst()
            .sink(receiveValue: { value in
                messages.append(.isLoading(value))
            })
            .store(in: &cancellables)
        sut.viewModel?.$error
            .dropFirst()
            .sink(receiveValue: { error in
                messages.append(.error(error: error as? NSError))
            })
            .store(in: &cancellables)
        
        await sut.load()
        
        XCTAssertEqual(messages, [.isLoading(true), .error(error: anyNSError()), .isLoading(false)])
    }
    
    func test_load_loadsArticles() async throws {
        var messages = [Message<[ArticleViewModel]>]()
        let articles = makeArticlesResult()
        let mapped = makeArticlesResult().map { ArticleViewModel(title: $0.title, post: $0.post) }
        let (sut, loader) = makeSUT()
        loader.completeLoading(with: articles)
        sut.viewModel?.$isLoading
            .dropFirst()
            .sink(receiveValue: { value in
                messages.append(.isLoading(value))
            })
            .store(in: &cancellables)
        sut.viewModel?.$articles
            .dropFirst()
            .sink(receiveValue: { articles in
                messages.append(.loaded(resource: articles))
            })
            .store(in: &cancellables)
        
        await sut.load()
        
        XCTAssertEqual(messages, [.isLoading(true), .loaded(resource: mapped), .isLoading(false)])
    }
    
    func test_load_updatesLoadingState() async {
        var loadingRequests: [Bool] = []
        let (sut, _) = makeSUT()
        
        sut.viewModel?.$isLoading.sink(receiveValue: { value in
            loadingRequests.append(value)
        })
        .store(in: &cancellables)
        
        await sut.load()
        
        XCTAssertEqual(loadingRequests, [false, true, false])
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

enum Message<Resource>: Equatable where Resource: Equatable {
    case isLoading(Bool)
    case loaded(resource: Resource)
    case error(error: NSError?)
}
