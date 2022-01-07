//
//  NetworkRequestManager.swift
//  TimesApp
//
//  Created by Dhiranjana Yadav on 22/11/21.
//

import Foundation
import UIKit

class NetworkRequestManager: NSObject {
    
    private let defaultSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    static  let shared = NetworkRequestManager()
    private let urlString = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=sGecvmIXM2UIIH8QoGslprpSbAvWTqNi"
    
    func getSectionData(completionHandler: @escaping (_ result:Results?, _ error: Error?) -> Void) {
        dataTask?.cancel()
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
    
 

