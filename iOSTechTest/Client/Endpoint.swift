//
//  Endpoint.swift
//  iOSTechTest
//
//  Created by Brandon Aubrey on 1/28/25.
//

import Foundation

enum ImageSize: String {
    case small = "S"
    case medium = "M"
    case large = "L"
}

// Endpoints
enum Endpoint {
    case search(query: String, limit: Int)
    case bookInfo(bookKey: String)
    // https://covers.openlibrary.org/b/ID/\(coverId)-M.jpg
    case coverImage(id: Int, size: ImageSize)
    
    var path: String {
        switch self {
        case .search(let query, _):
            "/subjects/\(query).json"
        case .bookInfo(let key):
            "/\(key).json"
        case .coverImage(let id, let size):
            "/b/ID/\(id)-\(size.rawValue).jpg"
        }
    }
    
    var queryParameters: [URLQueryItem]? {
        switch self {
        case .search(_, let limit):
            return [URLQueryItem(name: "limit", value: "20"),
                    URLQueryItem(name: "offset", value: "\(limit)")]
        default:
            return nil
        }
    }
    
    var host: String {
        switch self {
        case .coverImage: "covers.openlibrary.org"
        case .bookInfo, .search: "openlibrary.org"
        }
    }
    
    func url() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        
        if let queryParameters {
            components.queryItems = queryParameters
        }
        guard let url = components.url else {
            //TODO: Log error or throw error if needed
            return nil
        }
        
        return url
    }
}
