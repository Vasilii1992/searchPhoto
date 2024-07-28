//
//  ImageSaver.swift
//  Photo search
//
//  Created by Василий Тихонов on 28.07.2024.
//

import UIKit

class ImageSaver {
    static let savedImageURLsKey = "savedImageURLs"
    
    static func saveImageURLs(_ urls: [String]) {
        UserDefaults.standard.set(urls, forKey: savedImageURLsKey)
        UserDefaults.standard.synchronize() 
    }
    
    static func loadImageURLs() -> [String] {
        return UserDefaults.standard.stringArray(forKey: savedImageURLsKey) ?? []
    }
}

