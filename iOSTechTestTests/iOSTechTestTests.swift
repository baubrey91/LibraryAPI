//
//  TechTestCoreTests.swift
//  TechTestCoreTests
//
//  Created by Brandon Aubrey on 1/26/25.
//

import Testing
import TechTestCore

@testable import iOSTechTest


@Suite("Book List")
struct BookListViewModelTests {
    ///Test if search is updating bookitems in viewmodel
    
    @Test func testBookListViewModelSearch() async throws {
        // Arrange
        let mockNetworkService = MockNetworkService(jsonFile: .fiction)
        let viewModel = await BookListViewModel(networkService: mockNetworkService)
        
        // Act
        await viewModel.searchBySubject("")
        
        // Assert
        switch await viewModel.viewState {
        case .loaded:
            await #expect(viewModel.bookItems.count == 20, "Did not fetch book items")
        case .loading:
            Issue.record("Never left loading state")
        case .error(error: let error):
            Issue.record("Error: \(error)")
        }
    }
    
    // test for when search call fails
    @Test func testBookListViewModelSearchFail() async throws {
        // Arrange
        let mockNetworkService = MockNetworkService(jsonFile: .fail)
        let viewModel = await BookListViewModel(networkService: mockNetworkService)
        
        // Act
        let _ = await viewModel.searchBySubject("")
        
        // Assert
        switch await viewModel.viewState {
        case .loaded:
            Issue.record("We loaded a json that shouldn't exist")
        case .loading:
            Issue.record("Never left loading state")
        case .error(error: let error):
            #expect(error.localizedDescription.contains("The operation couldn’t be completed."), "Wrong error")
        }
    }
    
    // Test if load more is working
    @Test func testBookListViewModelLoadMore() async throws {
        // Arrange
        let mockNetworkService = MockNetworkService(jsonFile: .fiction)
        let viewModel = await BookListViewModel(networkService: mockNetworkService)
        
        // Act
        await viewModel.searchBySubject("")
        await viewModel.loadMore(subject: "")
        await viewModel.loadMore(subject: "")
        
        // Assert
        await #expect(viewModel.testLimit == 60, "Did not load more book items")
    }
    
    // Test if new search resets load more limit
    @Test func testBookListViewModelLoadMoreNewSearch() async throws {
        // Arrange
        let mockNetworkService = MockNetworkService(jsonFile: .fiction)
        let viewModel = await BookListViewModel(networkService: mockNetworkService)

        // Act
        await viewModel.searchBySubject("")
        await viewModel.loadMore(subject: "")
        await viewModel.loadMore(subject: "")
        await viewModel.searchBySubject("")
        
        // Assert
        await #expect(viewModel.testLimit == 20, "Did not reset limit")
    }
}

@Suite("Book Detail")
struct BookDetailViewModelTests {
    
    // Test get more info in detail view
    @Test func testBookDetailViewModelGetBookInfo() async throws {
        // Arrange
        let mockNetworkService = MockNetworkService(jsonFile: .hamlet)
        let viewModel = await BookDetailViewModel(networkService: mockNetworkService)
        
        // Act
        await viewModel.getBookInfo(key: "OL9170454W")
        
        // Assert
        await #expect(viewModel.bookInfo != nil, "No book item")
    }
    
    
    // Test if image url is returned
    // This should be more of a network test
    @Test func testBookDetailViewModel() async throws {
        // Arrange
        let mockNetworkService = MockNetworkService(jsonFile: .hamlet)
        let viewModel = await BookDetailViewModel(networkService: mockNetworkService)
        
        // Act
        let imageUrl = await viewModel.getImageURL(with: 11272464)
        
        // Assert
        #expect(imageUrl?.absoluteString == "https://covers.openlibrary.org/b/ID/11272464-L.jpg", "Incorrect image url")
    }
}

