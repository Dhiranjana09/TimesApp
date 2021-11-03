//
//  NetworkRequestManager.swift
//  TimesApp
//
//  Created by Dhiranjana Yadav on 3/11/21.
//

import Foundation
import UIKit

class NetworkRequestManager {
    
    private let defaultSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    
    
    func getSectionData(completionHandler: @escaping (_ result:Results?, _ error: Error?) -> Void) {
        dataTask?.cancel()
        
        let urlString = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=sGecvmIXM2UIIH8QoGslprpSbAvWTqNi"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        dataTask = defaultSession.dataTask(with: url) { [weak self]data, response, networkError in
            defer {
              self?.dataTask = nil
            }

            if let networkError = networkError {
                completionHandler(nil, networkError)
            } else if
              let data = data,
              let response = response as? HTTPURLResponse,
              response.statusCode == 200 {
                let decoder = JSONDecoder()
              //  decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let resultdata = try decoder.decode(Results.self, from: data)
                    print(resultdata)
                    completionHandler(resultdata, nil)
                } catch {
                    completionHandler(nil, error)
                }
            }
          }

        dataTask?.resume()
    }
}
    
 

