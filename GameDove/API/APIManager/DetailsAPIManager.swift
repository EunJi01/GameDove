//
//  DetailsAPIManager.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/17.
//

import Foundation

class DetailsAPIManager {
    static func requestDetails(id: String, sc: Bool, completion: @escaping (Details?, Screenshots?, APIError?) -> Void) {
        
        let scheme = "https"
        let host = "api.rawg.io"
        var path = "/api/games/\(id)"
        
        if sc {
            path += "/\(APIQuery.screenshots.rawValue)"
        }
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [URLQueryItem(name: APIQuery.key.rawValue, value: APIKey.RAWG)]

        guard let url = component.url else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Failed Request")
                    completion(nil, nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("No Data Returned")
                    completion(nil, nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Unable Response")
                    completion(nil, nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("Failed Response")
                    completion(nil, nil, .failedRequest)
                    return
                }

                do {
                    if sc {
                        let Screenshots = try JSONDecoder().decode(Screenshots.self, from: data)
                        completion(nil, Screenshots, nil)
                    } else {
                        let Details = try JSONDecoder().decode(Details.self, from: data)
                        completion(Details, nil, nil)
                    }
                } catch {
                    print(error)
                    completion(nil, nil, .invalidData)
                }
            }
        }.resume()
    }
}
