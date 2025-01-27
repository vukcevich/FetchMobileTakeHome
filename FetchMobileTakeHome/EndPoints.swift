//
//  EndPoints.swift
//  FetchMobileTakeHome
//
//  Created by MARIJAN VUKCEVICH on 1/26/25.
//

//https://d3jbb8n5wk0qxi.cloudfront.net/take-home-project.html

import Foundation

struct EndPoints {
    static var FetchAll: String {
            let urlStr = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
            return urlStr
    }
    
    static var FetchMalformed: String {
            let urlStr = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
            return urlStr
    }
    
    static var FetchEmpty: String {
            let urlStr = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
            return urlStr
    }
}
