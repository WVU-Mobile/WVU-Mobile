//
//  PRTView.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 11/27/24.
//

import SwiftUI
import PRTStatus

/// An overview of the current PRT status.
struct PRTView: View {
    @StateObject var viewModel: PRTViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Text(viewModel.headlineText)
                .font(Styles.Fonts.toolbar)
                .foregroundColor(Styles.Colors.text)
            Text(viewModel.detailText)
                .font(Styles.Fonts.bodyStrong)
                .foregroundColor(Styles.Colors.text2)
                .multilineTextAlignment(.center)
            
            Image(uiImage: UIImage(imageLiteralResourceName: "prt"))
                .shadow(
                    color: Styles.Colors.shadow,
                    radius: Styles.Constants.cornerRadius
                )

            Text(viewModel.lastUpdatedText)
                .font(Styles.Fonts.subtitleStrong)
                .foregroundColor(Styles.Colors.text2)
                .multilineTextAlignment(.center)
        }.accessibilityRepresentation(representation: {
            Text("\(viewModel.headlineText) \(viewModel.detailText) \(viewModel.lastUpdatedText)")
        })
        .padding()
        .onAppear {
            viewModel.fetch()
        }
    }
}
