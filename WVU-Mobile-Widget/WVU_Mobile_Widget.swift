//
//  WVU_Mobile_Widget.swift
//  WVU-Mobile-Widget
//
//  Created by Kaitlyn Landmesser on 11/24/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> PRTModel {
        PRTModel(status: .unknown,
                 message: "",
                 timestamp: "",
                 bussesDispatched: "")
    }

    func getSnapshot(in context: Context, completion: @escaping (PRTModel) -> ()) {
        let entry = PRTModel(status: .downBetween,
                             message: "The PRT is down between Beechurst and Engineering Stations. Buses dispatched.",
                             timestamp: "",
                             bussesDispatched: "true")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [PRTModel] = []

        PRTRequest.getStatus { model, error in
            DispatchQueue.main.async {
                if let model = model {
                    entries.append(model)
                }
                
                let timeline = Timeline(entries: entries, policy: .atEnd)
                completion(timeline)
            }
        }
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct PRTModel: Codable, TimelineEntry {
    var date: Date {
        guard let timeInterval = TimeInterval(timestamp) else { return Date() }
        return Date(timeIntervalSince1970: timeInterval)
    }
    
    let status: PRTStatus
    let message: String
    let timestamp: String
    let bussesDispatched: String
}

struct WVU_Mobile_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            PRTView(viewModel: PRTStatusViewModel(model: entry))
        }
    }
}

struct WVU_Mobile_Widget: Widget {
    let kind: String = "WVU_Mobile_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            PRTView(viewModel: PRTStatusViewModel(model: entry))
            .containerBackground(for: .widget) {
                Color("background1")
            }
        }
        .configurationDisplayName("WVU PRT")
        .description("View the PRT status in one glance.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .accessoryInline])
    }
}

#Preview(as: .systemSmall) {
    WVU_Mobile_Widget()
} timeline: {
    PRTModel(status: .downBetween,
                         message: "The PRT is down between Beechurst and Engineering Stations. Buses dispatched.",
                         timestamp: "",
                         bussesDispatched: "true")
}

struct PRTView: View {
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
                Text(viewModel.lastUpdatedTextLong)
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

import Foundation

extension Date {
    var hourPrint: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: self)
    }
    
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        return dateFormatter.string(from: self)
    }
}

enum PRTStatus: String, Codable {
    case normal = "1"
    case downBetween = "2"
    case down = "3"
    case downAll = "4"
    case free = "5"
    case downOne = "8"
    case closedSunday = "6"
    case closed = "7"
    case downMultiple = "10"
    case unknown
}

struct PRTRequest {
    private static var url: URL? {
        let timestamp = Int(Date().timeIntervalSince1970)
        let urlPath = "https://prtstatus.wvu.edu/api/\(timestamp)/?format=json"
        return URL(string: urlPath)
    }

    static func getStatus(completion: @escaping (PRTModel?, Error?) -> Void) {
        if let url = url {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                print(url.absoluteString)
                if let data = data, let prtModel = try? JSONDecoder().decode(PRTModel.self, from: data) {
                    completion(prtModel, error)
                } else {
                    completion(nil, error)
                }
            }

            task.resume()
        }
    }
}

class PRTObservableStatusViewModel: ObservableObject {
    @Published var headlineText: String = ""
    @Published var detailText: String = ""
    @Published var lastUpdatedText: String = ""
        
    init() {}

    func fetch() {
        PRTRequest.getStatus { prtModel, error in
            DispatchQueue.main.async {
                self.updatePublishedProperties(prtModel: prtModel)
            }
        }
    }
    
    private func updatePublishedProperties(prtModel: PRTModel?) {
        guard let prtModel = prtModel else {
            headlineText = "Searching..."
            detailText = "Searching..."
            lastUpdatedText = ""
            return
        }
        
        let viewModel = PRTStatusViewModel(model: prtModel)
        headlineText = viewModel.headlineText
        detailText = viewModel.detailText
        lastUpdatedText = viewModel.lastUpdatedText
    }
}

class PRTStatusViewModel {
    private let model: PRTModel
    
    init(model: PRTModel) {
        self.model = model
    }
    
    var headlineText: String {
        switch model.status {
        case .normal:
            return "Running"
        case .downAll, .down, .downBetween, .free, .downOne, .downMultiple:
            return "Down"
        case .closedSunday, .closed:
            return "Closed"
        case .unknown:
            return "Searching..."
        }
    }
    
    var detailText: String {
        return model.message
    }
    
    var lastUpdatedText: String {
        return "\(model.date.hourPrint), \(model.date.day)"
    }
    
    var lastUpdatedTextLong: String {
        return "Updated at \(model.date.hourPrint) on \(model.date.day)."
    }
}
