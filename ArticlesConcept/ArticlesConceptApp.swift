//
//  ArticlesConceptApp.swift
//  ArticlesConcept
//
//  Created by MAC918226 on 23/04/2024.
//

import SwiftUI

@main
struct ArticlesConceptApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ArticlesListUIComposer.composedWith(loader: makeArticlesLoader())
            }
        }
    }
    
    private func makeArticlesLoader() -> ArticlesLoader {
        return LocalArticlesLoader()
    }
}
