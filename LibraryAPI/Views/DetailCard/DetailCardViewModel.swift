//
//  DetailCardDataModel.swift
//  LibraryAPI
//
//  Created by Brandon Aubrey on 1/26/25.
//
import LibraryCore
import SwiftUI


// This is more of a datamodel or styler than a viewModel

struct DetailCardViewModel {
    let bookItem: BookItem
    let bookInfo: BookInfo?
    
    let padding: CGFloat = 16
    
    var titleString: String {
        self.bookItem.title
    }
    
    var publishDateString: String {
        let publishString = String(localized: "Publish Date", comment: "Publish Date")
        return "\(publishString): \(self.bookItem.firstPublishYear)"
    }
    
    var descriptionString: String {
        return self.bookInfo?.description ?? "Description not available"
    }
    
    var authorsString: String {
        let authorsArray = self.bookItem.authors.map { $0.name }
        let authorsNamesString = authorsArray.joined(separator: ", ")
        let authorsString = String(localized: "Authors", comment: "Plural authors")
        let authorString = String(localized: "Author", comment: "Singular author")
        let prefixString = authorsArray.count > 1 ? "\(authorsString): " : "\(authorString): "
        return prefixString + authorsNamesString
    }
    
    var descriptionFont: Font {
        return .custom("PlaywriteIN-Regular", size: 12)
    }
}
