//
//  GameListAPIManager.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/09.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case noData
    case failedRequest
    case invalidData
}

class GamesAPIManager {
    static func requestGames(order: APIQuery.Ordering, platform: APIQuery.Platforms, baseDate: String, search: String = "", page: String = "1", completion: @escaping (Game?, APIError?) -> Void) {
        let currentDate = APIQuery.dateFormatter(date: Date())
        let nextDate = APIQuery.dateFormatter(date: Date(timeIntervalSinceNow: 86400))

        let scheme = "https"
        let host = "api.rawg.io"
        let path = "/api/games"
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: APIQuery.key.rawValue, value: APIKey.RAWG),
            URLQueryItem(name: APIQuery.pageSize.rawValue, value: "40"),
            URLQueryItem(name: APIQuery.ordering.rawValue, value: order.rawValue),
            URLQueryItem(name: APIQuery.platforms.rawValue, value: platform.rawValue),
            URLQueryItem(name:APIQuery.search.rawValue , value: search),
            URLQueryItem(name: APIQuery.page.rawValue, value: page)
        ]
        
        if baseDate == defaultEndDate {
            component.queryItems?.append(URLQueryItem(name: APIQuery.dates.rawValue, value: "\(nextDate),\(baseDate)"))
        } else {
            component.queryItems?.append(URLQueryItem(name: APIQuery.dates.rawValue, value: "\(baseDate),\(currentDate)"))
        }

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
                    let result = try JSONDecoder().decode(Game.self, from: data)
                    completion(result, nil)
                } catch {
                    print(error)
                    completion(nil, .invalidData)
                }
            }
        }.resume()
    }
}
