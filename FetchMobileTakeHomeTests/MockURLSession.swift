//
//  MockURLSession.swift
//  FetchMobileTakeHome
//
//  Created by MARIJAN VUKCEVICH on 1/27/25.
//

import Foundation
import UIKit

@testable import FetchMobileTakeHome
class MockURLSession: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }

    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }
        guard let data = data, let response = response else {
            throw URLError(.badServerResponse)
        }
        return (data, response)
    }
}
