//
//  NetworkRequestManager.swift
//  TimesApp
//
//  Created by Dhiranjana Yadav on 22/11/21.
//

import Foundation


protocol NetworkRequestable {
    func getSectionData(completionHandler: @escaping (_ result:Results?, _ error: Error?) -> Void)
}

class NetworkRequestManager: NetworkRequestable {
    
    private let defaultSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    static  let shared = NetworkRequestManager()
    
    func getSectionData(completionHandler: @escaping (_ result:Results?, _ error: Error?) -> Void) {
        
        guard let url = RequestBuilder.topStoriesUrl(for: .home) else { return }
        
        dataTask?.cancel()
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            defer { self?.dataTask = nil }
            
            if let error = error { return completionHandler(nil, error) }
            
            ///NOTE: It's possible for API to return data when the response it not 2xx, it always better to check the status code before the data
            if let response = response as? HTTPURLResponse, let data = data {
                
                switch response.statusCode {
                
                case 200...299:
                    
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    do {
                        let resultdata = try decoder.decode(Results.self, from: data)
                        
                        completionHandler(resultdata, nil)
                    } catch {
                        completionHandler(nil, error)
                    }
                    
                default:
                    print("Invalid State Code: \(response.statusCode)")
                    completionHandler(nil, nil)
                }
            }
        }
        dataTask?.resume()
    }
}

class RequestBuilder {
    
    enum APISection: String {
        case arts, automobiles, books, business, fashion, food, health, home, insider, magazine, movies, nyregion, obituaries, opinion, politics, realestate, science, sports, sundayreview, technology, theater, travel, upshot, us, world
    }
    
    static func topStoriesUrl(for section: APISection) -> URL? {
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.nytimes.com"
        urlComponents.path = "/svc/topstories/v2/\(section.rawValue).json"
        
        urlComponents.queryItems = [URLQueryItem(name: "api-key", value: "sGecvmIXM2UIIH8QoGslprpSbAvWTqNi")]
        
        return urlComponents.url
    }
}
