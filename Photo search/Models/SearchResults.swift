//
//  SearchResults.swift
//  Photo search
//
//  Created by Василий Тихонов on 27.07.2024.
//

import Foundation

struct SearchResults: Decodable {
    let total: Int
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Decodable {
    let width: Int
    let height: Int
    let urls: [URLKind.RawValue:String]

    enum URLKind: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
    
}
