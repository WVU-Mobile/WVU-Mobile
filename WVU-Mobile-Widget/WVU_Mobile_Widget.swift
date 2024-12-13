//
//  WVU_Mobile_Widget.swift
//  WVU-Mobile-Widget
//
//  Created by Kaitlyn Landmesser on 11/24/24.
//

import WidgetKit
import SwiftUI
import PRTStatus

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
        Task {
            do {
                let service = PRTStatusService()
                let viewModel = try await service.fetchData(at: Date())
                let timeline = Timeline(entries: [viewModel], policy: .atEnd)
                completion(timeline)
            } catch {
                let timeline = Timeline(entries: [PRTModel](), policy: .atEnd)
                completion(timeline)
            }
        }
    }
}

struct WVU_Mobile_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            PRTWidgetView(viewModel: PRTViewModel(model: entry))
        }
    }
}

struct WVU_Mobile_Widget: Widget {
    let kind: String = "WVU_Mobile_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            PRTWidgetView(viewModel: PRTViewModel(model: entry))
            .containerBackground(for: .widget) {
                Color("background")
            }
        }
        .configurationDisplayName("WVU PRT")
        .description("View the PRT status in one glance.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .accessoryInline, .accessoryCircular, .accessoryRectangular])
    }
}

#Preview(as: .systemSmall) {
    WVU_Mobile_Widget()
} timeline: {
    PRTModel(
        status: .downBetween,
        message: "The PRT is down between Beechurst and Engineering Stations. Buses dispatched.",
        timestamp: "1733054252",
        bussesDispatched: "true"
    )
    PRTModel(
        status: .normal,
        message: "The PRT is running on a normal schedule.",
        timestamp: "1733831852",
        bussesDispatched: "true"
    )
    PRTModel(
        status: .closed,
        message: "The PRT is closed on Sundays.",
        timestamp: "1733896652",
        bussesDispatched: "true"
    )
}
