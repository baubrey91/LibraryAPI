////
////  BookInfo.swift
////  LibraryAPI
////
////  Created by Brandon Aubrey on 1/22/25.
////


public struct BookInfo: Decodable {

    public struct Description: Codable {
        let type: String
        let value: String
    }

    public let key: String
    public let title: String
    public let description: String?
    
    public init(key: String, title: String, description: String?) {
        self.key = key
        self.title = title
        self.description = description
    }
}

extension BookInfo {

    enum CodingKeys: String, CodingKey {
        case key
        case title
        case description
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // Decode regular properties
        self.key = try container.decode(String.self, forKey: .key)
        self.title = try container.decode(String.self, forKey: .title)

        // Custom decoding for description field that can be either a Description object or a String
        if let descriptionObject = try? container.decodeIfPresent(Description.self, forKey: .description) {
            self.description = descriptionObject.value
        } else {
            self.description = try? container.decodeIfPresent(String.self, forKey: .description)
        }
    }
}

