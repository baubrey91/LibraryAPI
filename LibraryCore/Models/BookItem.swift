//
//  BookItem.swift
//  LibraryAPI
//
//  Created by Brandon Aubrey on 1/26/25.
//

public struct BookItem: Decodable {
    public let key: String
    public let title: String
    public let firstPublishYear: Int
    public let authors: [Author]
    public let coverId: Int?
    
    public init(key: String, title: String, firstPublishYear: Int, authors: [Author], coverId: Int?) {
        self.key = key
        self.title = title
        self.firstPublishYear = firstPublishYear
        self.authors = authors
        self.coverId = coverId
    }
}

