//
//  PRTStatusViewModel.swift
//  WVU Mobile Networking
//
//  Created by Kaitlyn Landmesser on 12/5/24.
//
import Foundation

public class PRTService: ObservableObject {
    @Published public var headlineText: String = ""
    @Published public var detailText: String = ""
    @Published public var lastUpdatedText: String = ""
        
    public init() {}

    public func fetch() async {
        let service = PRTStatusService()
        let model = try? await service.fetchData(at: Date())
        updatePublishedProperties(prtModel: model)
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

public class PRTStatusViewModel {
    private let model: PRTModel
    
    public init(model: PRTModel) {
        self.model = model
    }
    
    public var headlineText: String {
        switch model.status {
        case .normal:
            return "All systems go."
        case .downBetween, .free, .downOne, .downMultiple:
            return "We've got a problem here."
        case .downAll, .down:
            return "We've got a problem here."
        case .closedSunday, .closed:
            return "No ones home."
        case .unknown:
            return "Searching..."
        }
    }
    
    public var detailText: String {
        return model.message
    }
    
    public var lastUpdatedText: String {
        guard let timeInterval = TimeInterval(model.timestamp) else { return "" }
        let lastUpdatedDate = Date(timeIntervalSince1970: timeInterval)
        return "Updated at \(lastUpdatedDate.hourPrint) on \(lastUpdatedDate.day)."
    }
}
    
extension Date {
    var hourPrint: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: self)
    }
    
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: self)
    }
}
