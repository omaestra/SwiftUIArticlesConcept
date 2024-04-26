//
//  ArticlesConceptApp.swift
//  ArticlesConcept
//
//  Created by MAC918226 on 23/04/2024.
//

import SwiftUI

@main
struct ArticlesConceptApp: App {
    @State var path = NavigationPath()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                ArticlesListUIComposer.composedWith(loader: makeArticlesLoader())
                    .navigationDestination(for: ArticleViewModel.self) { value in
                        Text("This is an Article,\nTitle: \(value.title)\nPost: \(value.post)")
                    }
            }
        }
    }
    
    private func makeArticlesLoader() -> ArticlesLoader {
        return LocalArticlesLoader()
    }
}
