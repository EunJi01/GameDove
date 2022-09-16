//
//  DetailsAPIManager.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/17.
//

import Foundation

class DetailsAPIManager {
    static func requestDetails(id: String, completion: @escaping (Details?, APIError?) -> Void) {
        
        let scheme = "https"
        let host = "api.rawg.io"
        let path = "/api/games/\(id)"
        // MARK: id까지는 같고 그 다음에 아무것도 없거나 스크린샷인데... 한번에 이쁘게 묶을 수 없을까?
        
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
                    let Details = try JSONDecoder().decode(Details.self, from: data)
                    completion(Details, nil)
                } catch {
                    print(error)
                    completion(nil, .invalidData)
                }
            }
        }.resume()
    }
}
