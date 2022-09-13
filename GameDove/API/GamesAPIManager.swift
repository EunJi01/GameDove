//
//  GameListAPIManager.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/09.
//

import Foundation

class GamesAPIManager {
    static func requestGames(order: APIQuery.Ordering, platform: APIQuery.Platforms, startDate: String, completion: @escaping (Games?, APIError?) -> Void) {
        let currentDate = APIQuery.dateFormatter(date: Date())

        let scheme = "https"
        let host = "api.rawg.io"
        let path = "/api/games"
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: APIQuery.key.rawValue, value: APIKey.RAWG),
            URLQueryItem(name: APIQuery.ordering.rawValue, value: order.rawValue),
            URLQueryItem(name: APIQuery.platforms.rawValue, value: platform.rawValue),
            URLQueryItem(name: APIQuery.dates.rawValue, value: "\(startDate),\(currentDate)")
        ]
        
        guard let url = component.url else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Failed Request")
                    completion(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("No Data Returned")
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Unable Response")
                    completion(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("Failed Response")
                    completion(nil, .failedRequest)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Games.self, from: data)
                    completion(result, nil)
                } catch {
                    print(error)
                    completion(nil, .invalidData)
                }
            }
        }.resume()
    }
}