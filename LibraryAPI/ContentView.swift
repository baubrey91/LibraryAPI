import SwiftUI
import LibraryCore

#Preview("BookListView") {
    BookListView()
}

#Preview("CardView") {
    let bookItem = BookItem(
        key: "key",
        title: "My Book",
        firstPublishYear: 1991,
        authors: [Author(name: "Shakespeare"), Author(name: "Moby")],
        coverId: nil
    )
    let bookInfo = BookInfo(
        key: "key",
        title: "Hamlet",
        description: "This is a description"
    )
    let viewModel = DetailCardViewModel(bookItem: bookItem, bookInfo: bookInfo)
    DetailCardView(viewModel: viewModel)
        .environment(\.locale, .init(identifier: "ja"))
}


