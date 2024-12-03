//
//  PRTStatusViewModel.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 11/15/22.
//

import Foundation

class PRTService: ObservableObject {
    @Published var headlineText: String = ""
    @Published var detailText: String = ""
    @Published var lastUpdatedText: String = ""
        
    init() {}

    func fetch() {
        PRTStatusService.getStatus { prtModel, error in
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
    
    var detailText: String {
        return model.message
    }
    
    var lastUpdatedText: String {
        guard let timeInterval = TimeInterval(model.timestamp) else { return "" }
        let lastUpdatedDate = Date(timeIntervalSince1970: timeInterval)
        return "Updated at \(lastUpdatedDate.hourPrint) on \(lastUpdatedDate.day)."
    }
}
    
