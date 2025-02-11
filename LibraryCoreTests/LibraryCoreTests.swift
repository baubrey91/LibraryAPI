import Testing
import Foundation
@testable import LibraryCore

private enum TestFailure: Error {
    case failedToDecode
    case failedToFindJSON
}

@Suite("Decoding Models")
struct LibraryCoreTests {
    
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    @Test func testBookInfoDecoding() async throws {
        
        // Normally don't like to use ! but think they get right to the issue in tests
        let frameworkBundle = Bundle(identifier: "com.brandonaubrey.LibraryCoreTests")!
            
        if let path = frameworkBundle.path(forResource: "FictionSearch", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                
                let fetchedData = try decoder.decode(Works.self, from: data)
                let works = fetchedData.works
                #expect(works.count == 20, "Parsed all 20 works properly")
                
                let firstWork = works.first!
                #expect(firstWork.key == "/works/OL151406W", "Key parsed incorrectly")
                #expect(firstWork.title == "Through the Looking-Glass", "Title parsed inincorrectly")
                #expect(firstWork.firstPublishYear == 1865, "Publish Year parsed incorrectly")
                #expect(firstWork.authors.first?.name == "Lewis Carroll", "Author name parsed incorrectly")
                #expect(firstWork.coverId == Optional(11272464), "Cover Id parsed incorrectly")
                
                let mirror = Mirror(reflecting: firstWork)
                // You updated properties and didn't update tests
                #expect(mirror.children.count == 5, "Unexpected number of properties")
            } catch let error {
                print(error)
                throw TestFailure.failedToDecode
            }
        } else {
            throw TestFailure.failedToFindJSON
        }
    }
    
    @Test func testBookItemDecoding() async throws {
        
        // Normally don't like to use ! but think they get right to the issue in tests
        let frameworkBundle = Bundle(identifier: "com.brandonaubrey.LibraryCoreTests")!
            
        if let path = frameworkBundle.path(forResource: "TheVampyre", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                
                let bookItem = try decoder.decode(BookInfo.self, from: data)
                let description: String? = "The Vampyre*, a short gothic novel by John William Polidori, was first published in 1819 and is considered the first modern vampire story. The story features Lord Ruthven, a seductive aristocrat with unnatural powers over men and women, and an insatiable thirst for blood. Polidori\'s innovative portrayal of the vampire as a Byronic figure is said to have set the template for the modern vampire."
                    
                #expect(bookItem.key == "/works/OL3625250W", "Key parsed incorrectly")
                #expect(bookItem.title == "The Vampyre", "Title parsed inincorrectly")
                #expect(bookItem.description == description, "Publish Year parsed incorrectly")
                
                let mirror = Mirror(reflecting: bookItem)
                // You updated properties and didn't update tests
                #expect(mirror.children.count == 3, "Unexpected number of properties")
            } catch let error {
                print(error)
                throw TestFailure.failedToDecode
            }
        } else {
            throw TestFailure.failedToFindJSON
        }
    }
}
