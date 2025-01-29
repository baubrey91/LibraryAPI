//
//  BookListView.swift
//  iOSTechTest
//
//  Created by Brandon Aubrey on 1/22/25.
//
import SwiftUI
import TechTestCore

struct BookListView: View {
    @StateObject private var viewModel = BookListViewModel()
    private let styler = BookListStyler()

    var body: some View {
        switch viewModel.viewState {
        case .loading:
            ProgressView()
                .controlSize(.large)
        case .error(let error):
            // Error view if api call fails (Needs better UI)
            Text(error.localizedDescription)
            Button(styler.retry) {
                self.viewModel.bookItems.removeAll()
                self.viewModel.viewState = .loaded
            }
        case .loaded:
            // TODO: - Might want to move this into a seperate struct as logic gets longer
            NavigationStack {
                List {
                    if self.viewModel.bookItems.isEmpty {
                        HStack {
                            Image(systemName: styler.bookImageName)
                            Text(styler.emptyText)
                        }
                    } else {
                        ForEach(viewModel.bookItems, id: \.key) { bookItem in
                            NavigationLink {
                                BookDetailView(bookItem: bookItem)
                            } label: {
                                HStack {
                                    Image(systemName: styler.bookImageName)
                                    Text(bookItem.title)
                                }
                            }
                            .buttonStyle(.plain)
                        }
                        
                        ///There is an issue with this since it will show even after we have downloaded all books in this category.
                        ///I didn't see any flag in the api letting us know there are no more books to be fetched
                        HStack {
                            Spacer()
                            Text(styler.loadingText)
                                .onAppear {
                                    Task { await self.viewModel.loadMore(subject: viewModel.searchText)  }
                                }
                            Spacer()
                        }
                    }
                }
            }
            .searchSuggestions( {
                ForEach(viewModel.searchSuggestions, id: \.self) { suggestion in
                    Text(suggestion)
                        .searchCompletion(suggestion)
                        .accessibilityIdentifier("listItem")
                }
                
            })
            .searchable(
                text: $viewModel.searchText,
                placement: .automatic,
                prompt: Text(styler.searchText)
            )
            .onSubmit(of: .search) {
                Task {
                    await viewModel.searchBySubject(viewModel.searchText, newSearch: true)
                }
            }
        }
    }
}


// Should be in seperate file but it's small enought I will keep it here for now
struct BookListStyler {
    let bookImageName = "book.fill"
    let loadingText = "Loading..."
    let searchText = "Search by subject"
    let emptyText = "No books found"
    let retry = String(localized: "Retry", comment: "Retry button text for api failure")
}

