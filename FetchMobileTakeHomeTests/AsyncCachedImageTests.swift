//
//  AsyncCachedImageTests.swift
//  FetchMobileTakeHome
//
//  Created by MARIJAN VUKCEVICH on 1/27/25.
//

import XCTest
import SwiftUI
@testable import FetchMobileTakeHome

final class AsyncCachedImageTests: XCTestCase {
    func testDownloadPhotoSuccess() async throws {
        // Mock data
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")!
        let data = try? Data(contentsOf: url)
        let imageData = UIImage(data: data!)?.pngData()
        let mockResponse = HTTPURLResponse(
            url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        let mockSession = MockURLSession(data: imageData, response: mockResponse, error: nil)

        // System under test
        let asyncImage = await AsyncCachedImage(url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"), session: mockSession) { image in
            image
        } placeHolder: {
            Text("Loading...")
        }

        // Trigger download
        let image = await asyncImage.downloadPhoto()

        // Assert image is successfully loaded
        XCTAssertNotNil(image)
        XCTAssertEqual(image?.pngData(), imageData)
    }

    func testDownloadPhotoFailure() async throws {
        // Mock error
        let mockSession = MockURLSession(data: nil, response: nil, error: URLError(.notConnectedToInternet))

        // System under test - bad image url 
        let asyncImage = await AsyncCachedImage(url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/image.jpg"), session: mockSession) { image in
            image
        } placeHolder: {
            Text("Loading...")
        }

        // Trigger download
        let image = await asyncImage.downloadPhoto()

        // Assert image is nil
        XCTAssertNil(image)
    }
}
