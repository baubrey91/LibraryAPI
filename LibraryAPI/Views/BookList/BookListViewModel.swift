//
//  Untitled.swift
//  LibraryAPI
//
//  Created by Brandon Aubrey on 1/26/25.
//
import SwiftUI
import LibraryCore

enum ViewState {
    case loading
    case error(error: Error)
    case loaded
}

@MainActor
final class BookListViewModel: ObservableObject {
    // MARK: Properties
    @Published var viewState: ViewState = .loaded
    @Published var searchText: String = ""
    @Published var bookItems: [BookItem] = []
    
    private let networkService: NetworkService
    
    private var limit = 20
    private var limitIncrement = 20
    
    // MARK: - Initializer
    init(networkService: NetworkService = NetworkManager()) {
        self.networkService = networkService
    }
    
    // MARK: - Functions
    // Initial search
    func searchBySubject(_ subject: String, newSearch: Bool = false) async {
        viewState = .loading
        limit = limitIncrement
        do {
            let fetchedData: Works = try await networkService.fetchDataWithCacheCheck(
                endpoint: .search(query: subject.lowercased(), limit: limit)
            )
            self.bookItems = fetchedData.works
            viewState = .loaded
        } catch let error {
            //TODO: Log error
            viewState = .error(error: error)
        }
        
    }
    
    // Pagination call
    func loadMore(subject: String) async {
        limit += limitIncrement
        do {
            let fetchedData: Works = try await networkService.fetchDataWithCacheCheck(
                endpoint: .search(query: subject.lowercased(), limit: limit)
            )
            self.bookItems += fetchedData.works
        } catch let error {
            /// I did't want to update the viewstate to error since there is already data being shown. I think it would be best to log the error and swallow it
            //TODO: Log Error
        }
        
    }
    
    //Search suggestion / auto complete for searches
    var searchSuggestions: [String] {
        var suggestions: [String] = []
        
        let search = searchText.lowercased()
        if search.contains("lo") {
            suggestions.append("Love")
        }
        if search.contains("ho") {
            suggestions.append("Horror")
        }
        if search.contains("fa") {
            suggestions.append("Fantasy")
        }
        
        return suggestions + ["Fiction", "Nonfiction"]
    }
}

// MARK: - Unit Test properties
extension BookListViewModel {
    var testLimit: Int {
        return self.limit
    }
}
