//
//  MockNetworkService.swift
//  LibraryAPI
//
//  Created by Brandon Aubrey on 1/28/25.
//

import Foundation
@testable import LibraryAPI

enum JSONFile: String {
    case fail = "DNE"
    case fiction = "fiction"
    case hamlet = "hamlet"
}

final class MockNetworkService: NetworkService {
    
    enum MockNetworkError: Error {
        case missingJSONFile
        case decodingFailed
    }
    
    var jsonFile: JSONFile
    
    let frameworkBundle = Bundle(identifier: "com.brandonaubrey.LibraryAPITests")!

    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    init(jsonFile: JSONFile) {
        self.jsonFile = jsonFile
    }
    
    func fetchData<T>(endpoint: Endpoint) async throws -> T where T : Decodable {
            
        if let path = frameworkBundle.path(forResource: jsonFile.rawValue, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                return try decoder.decode(T.self, from: data)
            } catch {
                throw MockNetworkError.decodingFailed
            }
        }
        throw MockNetworkError.missingJSONFile
    }
    
    func fetchDataWithCacheCheck<T>(endpoint: LibraryAPI.Endpoint) async throws -> T where T : Decodable {
        //Go straight to fetchData, no need to test cache
        try await self.fetchData(endpoint: endpoint)
    }
}

