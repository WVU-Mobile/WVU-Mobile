//
//  PRTWidgetView.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/7/24.
//

import PRTStatus
import SwiftUI

/// Support for Small, Medium, and Large Home Screen Widgets. 
struct PRTWidgetView: View {
    var viewModel: PRTViewModel
    @Environment(\.widgetFamily) var family

    var body: some View {
        VStack(alignment: .center) {
            
            switch family {
            case .systemSmall:
                Image(uiImage: UIImage(imageLiteralResourceName: "prt"))
                    .resizable()
                    .frame(width: 40, height: 40)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(viewModel.miniHeadlineText)
                    .font(Styles.Fonts.headline)
                    .foregroundColor(Styles.Colors.text)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(viewModel.miniLastUpdatedText)
                    .font(Styles.Fonts.bodyStrong)
                    .foregroundColor(Styles.Colors.text)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            case .systemMedium:
                HStack {
                    Text(viewModel.headlineText)
                        .font(Styles.Fonts.headlineMedium)
                        .foregroundColor(Styles.Colors.text)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Image(uiImage: Styles.Image.prt)
                        .resizable()
                        .frame(
                            width: Styles.ImageSize.small,
                            height: Styles.ImageSize.small)
                        .frame(maxWidth: .leastNonzeroMagnitude, alignment: .trailing)
                }

                Text(viewModel.detailText)
                    .font(Styles.Fonts.bodyStrong)
                    .foregroundColor(Styles.Colors.text)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(viewModel.lastUpdatedText)
                    .font(Styles.Fonts.subtitle)
                    .foregroundColor(Styles.Colors.text)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            case .systemLarge:
                Text(viewModel.headlineText)
                    .font(Styles.Fonts.headline)
                    .foregroundColor(Styles.Colors.text)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(viewModel.detailText)
                    .font(Styles.Fonts.bodyStrong)
                    .foregroundColor(Styles.Colors.text)
                    .multilineTextAlignment(.center)
                    .lineLimit(7)
                    .frame(maxWidth: .infinity, alignment: .center)
                Image(uiImage: Styles.Image.prt)
                    .resizable()
                    .frame(
                        width: Styles.ImageSize.large,
                        height: Styles.ImageSize.large)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(viewModel.lastUpdatedText)
                    .font(Styles.Fonts.subtitle)
                    .foregroundColor(Styles.Colors.text)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .center)
            case .accessoryInline, .accessoryCircular, .accessoryRectangular:
                Text(viewModel.miniHeadlineText)
            default:
                Text(viewModel.miniHeadlineText)
                    .font(Styles.Fonts.headline)
                    .foregroundColor(Styles.Colors.text)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(viewModel.miniLastUpdatedText)
                    .font(Styles.Fonts.bodyStrong)
                    .foregroundColor(Styles.Colors.text)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

