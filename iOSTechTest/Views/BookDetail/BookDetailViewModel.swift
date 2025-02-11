//
//  BookDetailViewModel.swift
//  iOSTechTest
//
//  Created by Brandon Aubrey on 1/26/25.
//

import SwiftUI
import TechTestCore

@MainActor
final class BookDetailViewModel: ObservableObject {
    @Published var bookInfo: BookInfo?
    
    let backgroundColor = Color.gray.opacity(0.1)
    
    private let networkService: NetworkService

    init(networkService: NetworkService = NetworkManager()) {
        self.networkService = networkService
    }
    
    func getBookInfo(key: String) async {
        do {
            self.bookInfo = try await networkService.fetchData(endpoint: .bookInfo(bookKey: key))
        } catch let error {
            // TODO: Log Error
        }
    }
    
    func getImageURL(with id: Int?) -> URL? {
        guard let id else { return nil }
        return Endpoint.coverImage(id: id, size: .large).url()
    }
}
