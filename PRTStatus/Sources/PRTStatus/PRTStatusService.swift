//
//  PRTStatusService.swift
//  WVU Mobile Networking
//
//  Created by Kaitlyn Landmesser on 12/4/24.
//

import Foundation

public protocol PRTStatusServiceProtocol {
    func fetchData(at date: Date) async throws(NetworkingError) -> PRTModel
}

public class PRTStatusService: PRTStatusServiceProtocol {
    private let session: URLSession

    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    public func fetchData(at date: Date) async throws(NetworkingError) -> PRTModel {
        do {
            let url = getURL(at: date)!
            let (data, response) = try await session.data(from: url)
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                throw NetworkingError.invalidStatusCode(statusCode: -1)
            }
            
            guard (200...299).contains(statusCode) else {
                throw NetworkingError.invalidStatusCode(statusCode: statusCode)
            }
            
            return try JSONDecoder().decode(PRTModel.self, from: data)
        } catch let error as DecodingError {
            throw .decodingFailed(innerError: error)
        } catch let error as EncodingError {
            throw .encodingFailed(innerError: error)
        } catch let error as URLError {
            throw .requestFailed(innerError: error)
        } catch let error as NetworkingError {
            throw error
        } catch {
            throw .otherError(innerError: error)
        }
    }
    
    public func getURL(at time: Date) -> URL? {
        let timestamp = Int(time.timeIntervalSince1970)
        let urlPath = "https://prtstatus.wvu.edu/api/\(timestamp)/?format=json"
        return URL(string: urlPath)
    }
}
