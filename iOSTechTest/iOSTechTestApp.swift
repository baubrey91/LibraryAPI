//
//  iOSTechTestApp.swift
//  iOSTechTest
//
//  Created by Stone Zhang on 2023/11/26.
//

import SwiftUI

@main
struct iOSTechTestApp: App {
    
    var body: some Scene {
        WindowGroup {
            BookListView()
                .onAppear {
                    configureURLlCache()
                }
        }
    }
    
    // This set up should be in a scene delegate or app delegate
    private func configureURLlCache() {
        // Might be excessive but extra memory for image caching
        let memoryCapacity = 50_000_000 // ~10 MB memory space
        let diskCapacity = 1_000_000_000 // ~1GB disk cache space
        let cache = URLCache(
            memoryCapacity: memoryCapacity,
            diskCapacity: diskCapacity,
            diskPath: "techTestCache"
        )
        URLCache.shared = cache
    }
}

