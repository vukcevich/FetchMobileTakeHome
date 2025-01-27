//
//  PostMarkModel.swift
//  FetchMobileTakeHome
//
//  Created by MARIJAN VUKCEVICH on 1/26/25.
//

import Foundation

// MARK: - PostMarkResponse
struct PostMarkModel: Codable {
    let recipes: [Recipe]?
}

// MARK: - Recipe
struct Recipe: Codable {
    let cuisine, name: String?
    let photoURLLarge, photoURLSmall: String?
    let uuid: String?
    let sourceURL: String?
    let youtubeURL: String?

    enum CodingKeys: String, CodingKey {
        case cuisine, name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case uuid
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}

extension Recipe: Identifiable {
    var id: UUID {
        return UUID()
    }
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}

