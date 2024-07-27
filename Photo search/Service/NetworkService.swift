//
//  NetworkService.swift
//  Photo search
//
//  Created by Василий Тихонов on 27.07.2024.
//

import Foundation


class NetworkService {
    
    
    func request(searchTer: String, completion: (Data?, Error) -> Void) {
        let parameters = prepareParameters(searchTerm: searchTer)
        let url = url(params: parameters)
        print(url)
        
        
    }
    
    private func prepareParameters(searchTerm: String?) -> [String: String] {
        var parameters = [String: String]()
        parameters["query"] = searchTerm
        parameters["page"] = String(1)
        parameters["per_page"] = String(30)
        return parameters
    }
    
    private func url(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
}
