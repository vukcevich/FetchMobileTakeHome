//
//  URLSessionProtocol+.swift
//  FetchMobileTakeHome
//
//  Created by MARIJAN VUKCEVICH on 1/27/25.
//

import Foundation
import UIKit

//Added in order to do Unit Test for AsyncCachedImage
protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse) {
        // Explicitly call the original method on `URLSession`
        return try await self.data(for: URLRequest(url: url))
    }
}
