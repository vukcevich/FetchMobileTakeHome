//
//  FetchViewModelTests.swift
//  FetchMobileTakeHome
//
//  Created by MARIJAN VUKCEVICH on 1/27/25.
//

import XCTest
@testable import FetchMobileTakeHome

final class FetchViewModelTests: XCTestCase {
    var viewModel: FetchViewModel!
    var mockNetworkManager: MockNetworkManager!

    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        viewModel = FetchViewModel()
        viewModel.webService = mockNetworkManager
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        super.tearDown()
    }

    func testFetchDataSuccess() async {
        // Arrange
        let recipe1 = Recipe(cuisine: "Malaysian", name: "Apam Balik", photoURLLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg", photoURLSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg", uuid: "0c6ca6e7-e32a-4053-b824-1dbf749910d8", sourceURL: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ", youtubeURL: "https://www.youtube.com/watch?v=6R8ffRRJcrg")
        
        let recipe2 = Recipe(cuisine: "British", name: "Apple & Blackberry Crumble", photoURLLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg", photoURLSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg", uuid: "0c6ca6e7-e32a-4053-b824-1dbf749910d8", sourceURL: "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble", youtubeURL: "https://www.youtube.com/watch?v=4vhcOwVBDO4")
        
        let mockPayload = PostMarkModel(recipes: [recipe1, recipe2])

        mockNetworkManager.mockResponse = mockPayload
        mockNetworkManager.shouldThrowError = false

        // Act
        await viewModel.fetchData()

        // Assert
        XCTAssertEqual(viewModel.postRecipes.count, 2)
        XCTAssertEqual(viewModel.postRecipes.first?.name, "Apam Balik")
    }

    func testFetchDataEmpty() async {
        // Arrange
        let mockPayload = PostMarkModel(recipes: [])
        mockNetworkManager.mockResponse = mockPayload
        mockNetworkManager.shouldThrowError = false

        // Act
        await viewModel.fetchData()

        // Assert
        XCTAssertEqual(viewModel.postRecipes.count, 0)
    }
}
