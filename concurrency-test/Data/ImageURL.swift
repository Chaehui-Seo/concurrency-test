//
//  ImageURL.swift
//  concurrency-test
//
//  Created by 서채희 on 2023/03/10.
//

import Foundation

enum ImageURL {
    private static let imageIds: [String] = [
        "europe=4k-1369012",
        "europe-4k-1318341",
        "europe-4k-1379801",
        "cool-lion-167408",
        "iron-man-323408"
    ]
    
    static subscript(index: Int) -> URL {
        let id = imageIds[index]
        return URL(string: "https://wallpaperaccess.com/download/"+id)!
    }
    
    static func count() -> Int {
        imageIds.count
    }
}
