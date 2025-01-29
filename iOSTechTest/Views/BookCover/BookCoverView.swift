//
//  BookCoverView.swift
//  iOSTechTest
//
//  Created by Brandon Aubrey on 1/26/25.
//
import SwiftUI

struct BookCoverView: View {
    let coverImageURL: URL?
    let styler = BookCoverStyler()
    
    var body: some View {
        List {
            if let coverImageURL {
                // AsyncImage should handle image caching
                AsyncImage(url: coverImageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(styler.padding)
                } placeholder: {
                    Image(systemName: self.styler.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
            } else {
                Text(styler.notFoundText)
                    .font(.callout)
                Image(systemName: self.styler.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(self.styler.padding)
            }
            Text(styler.details)
                .accessibilityIdentifier(styler.details)
        }
    }
}

// MARK: - Styler
struct BookCoverStyler {
    let padding: CGFloat = 16
    let imageName = "book.fill"
    let notFoundText = "Cover Image Not Found"
    let details = String(localized: "Tap to see details...", comment: "See details")
}
