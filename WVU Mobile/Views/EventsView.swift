//
//  EventsView.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 11/19/24.
//

import SwiftUI

/// A view to showcase the events happening today, with the ability to search for future dates.
struct EventsView: View {
    @StateObject var viewModel = EventsObservableViewModel()
    @State var current_date = Date()
    @State var showDatePicker = false

    let staticDiningHalls: [EventsViewModel] = [
        EventsViewModel(name: "Cafe Evansdale", locationId: "34178001", menuId: "15274"),
        EventsViewModel(name: "Summit Cafe", locationId: "34178001", menuId: "35160"),
        EventsViewModel(name: "Hatfields", locationId: "34178001", menuId: "35161")
    ]
    var body: some View {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Styles.Colors.background1, Styles.Colors.background2]),
                               startPoint: .top,
                               endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                VStack {
                    if showDatePicker {
                        
                        DatePicker("Date", selection: $current_date, in: Date()..., displayedComponents: [.date])
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .padding()
                            .onChange(of: current_date) { _, _ in
                                showDatePicker = !showDatePicker
                            }
                    } else {
                        Button("\(current_date.day)", systemImage: "calendar") {
                            showDatePicker = !showDatePicker
                        }
                        .buttonStyle(.bordered)
                        .foregroundStyle(.tint)
                        .tint(Styles.Colors.text2)
                        .controlSize(.large)
                    }
                    
                    ScrollView (.vertical, showsIndicators: true) {
                        VStack {
                            if viewModel.events.isEmpty {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .foregroundStyle(.tint)
                                    .tint(Styles.Colors.text2)
                                    .controlSize(.large)
                                
                            } else {
                                let calendar =  NSCalendar(calendarIdentifier: .gregorian)
                                let eventsOnDate = viewModel.events.filter({ element in
                                    calendar?.isDate(element.date, inSameDayAs: current_date) ?? false
                                })
                                if eventsOnDate.isEmpty {
                                    Text("No events to display for \(current_date)")
                                }
                                ForEach(eventsOnDate, id: \.self) { event in
                                    let eventModel = RSSModel(title: event.title,
                                                               body: event.description,
                                                               imageName: event.source?.imageName ?? "wv",
                                                               urlString: event.link,
                                                               date: event.date)
                                    NewsHeadlineDetailsView(newsModel: eventModel, showBody: false)
                                }
                            }
                        }.padding()
                            .onAppear {
                                viewModel.fetch()
                            }
                    }
                    .clipped()
                }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Events")
                    .font(Styles.Fonts.toolbar)
                    .foregroundColor(Styles.Colors.text)
            }
        }
        .toolbarBackground(Styles.Colors.background1, for: .navigationBar)
    }
}

struct EventsViewDetailsView: View {
    @State var showSafari = false
    
    var model: EventsViewModel
    var body: some View {
        VStack {
            Text(model.name)
                .font(Styles.Fonts.body)
                .foregroundColor(Styles.Colors.text)
                .multilineTextAlignment(.leading)
        }
        .padding()
        .background(Styles.Colors.accent)
        .cornerRadius(10)
        .shadow(color: Styles.Colors.shadow, radius: 10)
        .frame(maxWidth: .infinity)
        .onTapGesture {
            self.showSafari = true
        }
        .sheet(isPresented: self.$showSafari) {
            if let url = model.url {
                SafariView(url: url)
            } else {
                Text("Something went wrong.")
            }
        }

    }
}
