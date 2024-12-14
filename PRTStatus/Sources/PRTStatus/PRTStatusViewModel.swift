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
            return "All systems go."
        case .downBetween, .free, .downOne, .downMultiple,  .downAll, .down:
            return "We’ve got a problem here."
        case .closedSunday, .closed:
            return "No one’s home."
        case .unknown:
            return "Searching..."
        }
    }
    
    private func getLastUpdatedText(model: PRTModel) -> String {
        guard let timeInterval = TimeInterval(model.timestamp) else { return "" }
        let lastUpdatedDate = Date(timeIntervalSince1970: timeInterval)
        return "Updated \(lastUpdatedDate.relativeDateFull)."
    }
    
    public func getMiniLastUpdatedText(model: PRTModel) -> String {
        guard let timeInterval = TimeInterval(model.timestamp) else { return "" }
        let lastUpdatedDate = Date(timeIntervalSince1970: timeInterval)
        return lastUpdatedDate.relativeDateMini
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
    
    var relativeDateFull: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.string(for: self) ?? ""
    }
    
    var relativeDateMini: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.string(for: self) ?? ""
    }
}
