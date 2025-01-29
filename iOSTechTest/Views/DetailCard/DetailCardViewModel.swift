//
//  DetailCardDataModel.swift
//  iOSTechTest
//
//  Created by Brandon Aubrey on 1/26/25.
//
import TechTestCore
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
        "Publish Date: \(self.bookItem.firstPublishYear)"
    }
    
    var descriptionString: String {
        return self.bookInfo?.description ?? "Description not available"
    }
    
    var authorsString: String {
        let authorsArray = self.bookItem.authors.map { $0.name }
        let authorsString = authorsArray.joined(separator: ", ")
        let prefixString = authorsArray.count > 1 ? "Authors: " : "Author: "
        return prefixString + authorsString
    }
    
    var descriptionFont: Font {
        return .custom("PlaywriteIN-Regular", size: 12)
    }
}
