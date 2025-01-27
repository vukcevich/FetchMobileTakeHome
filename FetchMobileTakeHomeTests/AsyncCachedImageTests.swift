//
//  AsyncCachedImageViewTests.swift
//  FetchMobileTakeHome
//
//  Created by MARIJAN VUKCEVICH on 1/27/25.
//

import XCTest
import ViewInspector
@testable import YourModuleName

extension AsyncCachedImage: Inspectable {}

final class AsyncCachedImageViewTests: XCTestCase {
    func testPlaceholderIsShownInitially() throws {
        // System under test
        let asyncImage = AsyncCachedImage(
            url: nil,
            session: MockURLSession(data: nil, response: nil, error: nil)
        ) { image in
            image
        } placeHolder: {
            Text("Loading...")
        }

        // Assert the placeholder is initially shown
        let placeholderText = try asyncImage.inspect().vStack().view(Text.self, 0).string()
        XCTAssertEqual(placeholderText, "Loading...")
    }
}
