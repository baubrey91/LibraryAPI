//
//  API.swift
//  iOSTechTest
//
//  Created by Brandon Aubrey on 1/23/25.
//


import Foundation


/// Things to note, this could also be in its own framework like TechTestCore but since it's one file I decided to leave it for now,
/// This network layer also only supports gets and should add more for doing post request but that isn't in the requirements for now

// MARK: - Protocol for dependency injection

/// I keep both incase there is an instance where you don't want to bother checking cache (ie sensitive data you don't want to cache)
protocol NetworkService {
    func fetchData<T: Decodable>(endpoint: Endpoint) async throws -> T
    func fetchDataWithCacheCheck<T: Decodable>(endpoint: Endpoint) async throws -> T
}

// MARK: Enums

// Errors
enum NetworkError: Error, LocalizedError {
    case badURL
    case requestFailed
    case invalidResponse
    case decodingError
    case unknown

    var errorDescription: String? {
        switch self {
        case .badURL: return "The URL is invalid."
        case .requestFailed: return "The network request failed."
        case .invalidResponse: return "The server returned an invalid response."
        case .decodingError: return "Failed to decode the response."
        case .unknown: return "An unknown error occurred."
        }
    }
}


final class NetworkManager: NetworkService {

    private let session: URLSession
    
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // Fetch from cache
    func fetchDataWithCacheCheck<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.url() else {
            throw NetworkError.badURL
        }
        guard let data = getCachedData(for: url) else {
            return try await fetchData(endpoint: endpoint)
        }
        
        /// We could put this decoding logic in helper function since it is re used but I think this makes it easier to debug
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            // TODO: Log Error
            throw NetworkError.decodingError
        }
    }

    // Function to fetch data using async/await
    func fetchData<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.url() else {
            throw NetworkError.badURL
        }
        
        // Make Network request
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
        let (data, response) = try await session.data(for: request)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
        
        // Check for 200
        guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
            print(response)
            throw NetworkError.invalidResponse
        }
        
        // Decode
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch let error {
            // TODO: Log Error
            throw NetworkError.decodingError
        }
    }
    
    // MARK: Helper functions
    private func getCachedData(for url: URL) -> Data? {
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60.0)
        return URLCache.shared.cachedResponse(for: request)?.data
    }
}
