//
//  PRTStatusViewModel.swift
//  WVU Mobile Networking
//
//  Created by Kaitlyn Landmesser on 12/5/24.
//
import Foundation

/// Holds the published values to connect to the various PRT views throughout the app. Also retrieves values.. Is it a view model? Still haven't decided.
@MainActor public class PRTViewModel: ObservableObject {
    @Published public var headlineText: String = ""
    @Published public var detailText: String = ""
    @Published public var lastUpdatedText: String = ""
    @Published public var miniHeadlineText: String = ""
    @Published public var miniLastUpdatedText: String = ""

    private var model: PRTModel?
    
    public init() {}
    
    public init(model: PRTModel) {
        self.model = model
        updatePublishedValues(for: model)
    }

    public func fetch() {
        Task {
            do {
                let service = PRTStatusService()
                let model = try await service.fetchData(at: Date())
                
                updatePublishedValues(for: model)
            } catch {
                headlineText = "Searching..."
                detailText = "Searching..."
                lastUpdatedText = ""
            }

        }
    }
    
    private func updatePublishedValues(for model: PRTModel) {
        headlineText = getHeadlineText(model: model)
        detailText = model.message
        lastUpdatedText = getLastUpdatedText(model: model)
        miniHeadlineText = getMiniText(model: model)
        miniLastUpdatedText = getMiniLastUpdatedText(model: model)
    }
    
    private func getHeadlineText(model: PRTModel) -> String {
        switch model.status {
        case .normal:
            return "Let's Go Mountaineers!"
        case .downBetween, .free, .downOne, .downMultiple,  .downAll, .down:
            return "Eat ..it Pitt."
        case .closedSunday, .closed:
            return "No ones home."
        case .unknown:
            return "Searching..."
        }
    }
    
    private func getLastUpdatedText(model: PRTModel) -> String {
        guard let timeInterval = TimeInterval(model.timestamp) else { return "" }
        let lastUpdatedDate = Date(timeIntervalSince1970: timeInterval)
        return "Updated at \(lastUpdatedDate.hourPrint) on \(lastUpdatedDate.day)."
    }
    
    public func getMiniLastUpdatedText(model: PRTModel) -> String {
        guard let timeInterval = TimeInterval(model.timestamp) else { return "" }
        let lastUpdatedDate = Date(timeIntervalSince1970: timeInterval)
        return "\(lastUpdatedDate.hourPrint), \(lastUpdatedDate.dayShort)"
    }
    
    private func getMiniText(model: PRTModel) -> String {
        switch model.status {
        case .normal:
            return "Up"
        case .downBetween, .free, .downOne, .downMultiple,  .downAll, .down:
            return "Down"
        case .closedSunday, .closed:
            return "Closed"
        case .unknown:
            return "-"
        }
    }
}
    
extension Date {
    var hourPrint: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self)
    }
    
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yy"
        return dateFormatter.string(from: self)
    }
    
    var dayShort: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d"
        return dateFormatter.string(from: self)
    }
}
