//
//  Author.swift
//  LibraryAPI
//
//  Created by Brandon Aubrey on 1/27/25.
//

public struct Author: Decodable {
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
}

