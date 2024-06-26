//
//  ArticlesListUIComposer.swift
//  ArticlesConcept
//
//  Created by MAC918226 on 23/04/2024.
//

import Foundation

final class ArticlesListUIComposer {
    static func composedWith(loader: ArticlesLoader) -> ArticlesListView {
        let viewModel = ArticlesListViewModel()
        let presentationAdapter = ArticlesListPresentationAdapter(loader: loader, viewModel: viewModel)
        
        var view = ArticlesListView(viewModel: viewModel)
        view.onRefresh = { await presentationAdapter.load()?.value } 
        view.onCancel = presentationAdapter.cancel
        
        return view
    }
}
