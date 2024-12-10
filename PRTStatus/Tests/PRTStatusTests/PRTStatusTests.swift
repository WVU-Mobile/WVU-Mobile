import Testing
import Foundation
@testable import PRTStatus

@Suite
struct PRTStatusServiceTests {
    init() {
        MockURLProtocol.requestHandler = nil
        MockURLProtocol.error = nil
    }

    @Test("Successful API Call")
    func prtStatusSuccess() async throws {
        let successResponse = """
            {
                "status":"1",
                "message":"The PRT is running on a normal schedule.",
                "timestamp":"1",
                "stations":[],
                "bussesDispatched":"0",
                "duration":[]
            }
        """
        let data = successResponse.data(using: .utf8)
        let url = URL(string: "https://prtstatus.wvu.edu/api/1/?format=json")!
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Content-Type":"application/json"])
            return (response!, data!)
        }
        
        let configuration: URLSessionConfiguration = .ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        
        let service = PRTStatusService(session: session)
        
        let result = try await service.fetchData(at: Date(timeIntervalSince1970: 1733412949))
        #expect(result.message == "The PRT is running on a normal schedule.")
    }
    
    @Test("Failed API Call")
    func prtStatusFailure() async throws {
        let successResponse = """
            {
                "status":"1",
                "message":"The PRT is running on a normal schedule.",
                "timestamp":"2",
                "stations":[],
                "bussesDispatched":"0",
                "duration":[]
            }
        """
        let data = successResponse.data(using: .utf8)
        let url = URL(string: "https://prtstatus.wvu.edu/api/2/?format=json")!
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: url,
                statusCode: 400,
                httpVersion: nil,
                headerFields: ["Content-Type":"application/json"])
            return (response!, data!)
        }
        
        let configuration: URLSessionConfiguration = .ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        
        let service = PRTStatusService(session: session)
        
        do {
            let _ = try await service.fetchData(at: Date(timeIntervalSince1970: 1733412949))
            Issue.record("Expecting failure, received success.")
        } catch NetworkingError.invalidStatusCode(statusCode: 400) { }
    }
    
    @Test("Failed Decoding")
    func prtStatusDecodingFailure() async throws {
        let response = """
            {
            }
        """
        let data = response.data(using: .utf8)
        let url = URL(string: "https://prtstatus.wvu.edu/api/3/?format=json")!
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Content-Type":"application/json"])
            return (response!, data!)
        }
        
        let configuration: URLSessionConfiguration = .ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        
        let service = PRTStatusService(session: session)
        
        do {
            let _ = try await service.fetchData(at: Date(timeIntervalSince1970: 1733412949))
            Issue.record("Expecting decoding failure, received success.")
        } catch NetworkingError.decodingFailed { }
    }
}
