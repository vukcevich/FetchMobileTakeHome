//
//  NetworkManager.swift
//  FetchMobileTakeHome
//
//  Created by MARIJAN VUKCEVICH on 1/26/25.
//

import Foundation
import OSLog

protocol NetworkManagerProtocol {
    func fetch<T: Codable>(from urlString: String) async throws -> T
}

struct NetworkManager: NetworkManagerProtocol {
    
    func fetch<T: Codable>(from urlString: String) async throws -> T {
        
        guard let url = URL(string: urlString) else  {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        //Easy to read JSON:
        //let dataString = data.prettyjsonString //For Debug only
        //Logger.viewCycle.info("\(#line) - Pretty-JSON-String: \(dataString ?? "")") //For Debug only
        
        let decoder = JSONDecoder()
        let fetchedResult = try decoder.decode(T.self, from: data)
        
        return fetchedResult
    }
}
