//
//  NetworkingError.swift
//  WVU Mobile Networking
//
//  Created by Kaitlyn Landmesser on 12/6/24.
//

import Foundation

public enum NetworkingError: Error {
    case encodingFailed(innerError: EncodingError)
    case decodingFailed(innerError: DecodingError)
    case invalidStatusCode(statusCode: Int)
    case requestFailed(innerError: URLError)
    case otherError(innerError: Error)
}
