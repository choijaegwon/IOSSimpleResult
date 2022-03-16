//
//  NetworkLayer.swift
//  MovieApp
//
//  Created by Jae kwon Choi on 2022/01/08.
//

import Foundation

enum MovieAPIType {
    case justURL(urlString: String)
    case searchMovie(querys: [URLQueryItem])
}

enum MovieAPIError: Error{
    case badURL
}

class NetworkLayer {
    
    typealias NetworkCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void
    
    // only url
    // url + param
    func request(type: MovieAPIType, completion: @escaping NetworkCompletion) {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        do{
            let request = try buildRequest(type: type)
                
            session.dataTask(with: request) { data, response, error in
                print( (response as! HTTPURLResponse).statusCode )
                
                completion(data, response, error)
                                                    
                }.resume()
                session.finishTasksAndInvalidate()
            
        } catch {
            print(error) //MovieAPIError.badURL
        }
    }
        
    private func buildRequest(type: MovieAPIType) throws -> URLRequest {
        
        switch type {
        case .justURL(urlString: let urlString):
            guard let hasURL = URL(string: urlString) else {
                throw MovieAPIError.badURL
            }
                
            var request = URLRequest(url: hasURL)
            request.httpMethod = "GET"
            return request
            
            
        case .searchMovie(querys: let querys):
            var components = URLComponents(string: "https://itunes.apple.com/search")
            components?.queryItems = querys
            guard let hasurl = components?.url else {
                throw MovieAPIError.badURL
            }
            
            var request = URLRequest(url: hasurl)
            request.httpMethod = "GET"
            return request
            
        }
    }
}
