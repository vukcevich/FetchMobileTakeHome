//
//  FetchViewModel.swift
//  FetchMobileTakeHome
//
//  Created by MARIJAN VUKCEVICH on 1/26/25.
//

//https://d3jbb8n5wk0qxi.cloudfront.net/take-home-project.html

import Foundation
import SwiftUI
import Combine

class FetchViewModel: ObservableObject {
    @Published var postRecipes: [Recipe] = []
    var webService: NetworkManagerProtocol = NetworkManager()
    @State var showMessage = false
    @State var message = ""
    init() {
        Task {
           await fetchData()
        }
    }
    
    @MainActor
    func fetchData() async {
        do {
            //MARK: testing different options
            let urlStr = EndPoints.FetchAll
            //let urlStr = EndPoints.FetchMalformed
            //let urlStr = EndPoints.FetchEmpty
            
            let payLoad: PostMarkModel = try await webService.fetch(from: urlStr)
            let filteredRecipes = payLoad.recipes?.filter {
                $0.name != nil
            }
            postRecipes = filteredRecipes ?? []
        } catch {
            print(error.localizedDescription)
            showMessage = true
            message = error.localizedDescription
        }
    }
}
