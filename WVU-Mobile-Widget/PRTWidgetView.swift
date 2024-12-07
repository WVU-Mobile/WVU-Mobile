//
//  PRTWidgetView.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/7/24.
//

import PRTStatus
import SwiftUI

struct PRTWidgetView: View {
    var viewModel: PRTStatusViewModel
    @Environment(\.widgetFamily) var family

    var body: some View {
        VStack(alignment: .center) {
            
            switch family {
            case .systemSmall:
                Image(uiImage: UIImage(imageLiteralResourceName: "prt"))
                    .resizable()
                    .frame(width: 40, height: 40)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(viewModel.headlineText)
                    .font(.custom("AvenirNext-Bold", size: 25))
                    .foregroundColor(Color("text2"))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(viewModel.lastUpdatedText)
                    .font(.custom("AvenirNext-Medium", size: 15))
                    .foregroundColor(Color("text2"))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            case .systemMedium:
                HStack {
                    Text(viewModel.headlineText)
                        .font(.custom("AvenirNext-Bold", size: 25))
                        .foregroundColor(Color("text2"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    Image(uiImage: UIImage(imageLiteralResourceName: "prt"))
                        .resizable()
                        .frame(width: 40, height: 40)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }

                Text(viewModel.detailText)
                    .font(.custom("AvenirNext-Medium", size: 20))
                    .foregroundColor(Color("text2"))
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(viewModel.lastUpdatedText)
                    .font(.custom("AvenirNext-Medium", size: 12))
                    .foregroundColor(Color("text2"))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            case .systemLarge:
                Text(viewModel.headlineText)
                    .font(.custom("AvenirNext-Bold", size: 35))
                    .foregroundColor(Color("text2"))
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(viewModel.detailText)
                    .font(.custom("AvenirNext-Medium", size: 20))
                    .foregroundColor(Color("text2"))
                    .multilineTextAlignment(.center)
                    .lineLimit(7)
                    .frame(maxWidth: .infinity, alignment: .center)
                Image(uiImage: UIImage(imageLiteralResourceName: "prt"))
                    .resizable()
                    .frame(width: 75, height: 75)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(viewModel.lastUpdatedText)
                    .font(.custom("AvenirNext-Medium", size: 12))
                    .foregroundColor(Color("text2"))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .center)
            case .accessoryInline:
                Text(viewModel.headlineText)
            default:
                Text(viewModel.headlineText)
                    .font(.custom("AvenirNext-Bold", size: 25))
                    .foregroundColor(Color("text2"))
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(viewModel.lastUpdatedText)
                    .font(.custom("AvenirNext-Medium", size: 15))
                    .foregroundColor(Color("text2"))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

