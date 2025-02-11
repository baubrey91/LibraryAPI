//
//  DetailCardView.swift
//  iOSTechTest
//
//  Created by Brandon Aubrey on 1/26/25.
//
import SwiftUI

struct DetailCardView: View {
    var viewModel: DetailCardViewModel

    var body: some View {
        List {
            Text(self.viewModel.titleString)
                .font(.largeTitle)
                .padding(viewModel.padding)
                .accessibilityIdentifier("detailCardTitle")
            Text(self.viewModel.publishDateString)
                .font(.callout)
                .padding(viewModel.padding)
            Text(self.viewModel.descriptionString)
                .padding(viewModel.padding)
                .font(self.viewModel.descriptionFont)
            Text(viewModel.authorsString)
                .padding(self.viewModel.padding)
        }
    }
}
