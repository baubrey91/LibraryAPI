//
//  BookDetailView.swift
//  iOSTechTest
//
//  Created by Brandon Aubrey on 1/22/25.
//

import SwiftUI
import TechTestCore

struct BookDetailView: View {
    @StateObject private var viewModel = BookDetailViewModel()
    var bookItem: BookItem
    var body: some View {
        Flashcard(
            front: {
                BookCoverView(
                    coverImageURL: self.viewModel.getImageURL(with: bookItem.coverId)
                )
            },
            back: {
                DetailCardView(
                    viewModel:
                        DetailCardViewModel(
                            bookItem: self.bookItem,
                            bookInfo: self.viewModel.bookInfo
                            )
                         )
        } )
        .background(self.viewModel.backgroundColor)
        .onAppear {
            Task {
                await self.viewModel.getBookInfo(key: bookItem.key)
            }
        }
    }
}



