//
//  MockNetworkManager.swift
//  FetchMobileTakeHome
//
//  Created by MARIJAN VUKCEVICH on 1/27/25.
//

import Foundation

@testable import FetchMobileTakeHome
class MockNetworkManager: NetworkManagerProtocol {
    var shouldThrowError = false
    var mockResponse: PostMarkModel?

    func fetch<T: Decodable>(from url: String) async throws -> T {
        if shouldThrowError {
            throw URLError(.badServerResponse)
        }

        guard let mockResponse = mockResponse as? T else {
            throw URLError(.cannotDecodeContentData)
        }

        return mockResponse
    }
}
