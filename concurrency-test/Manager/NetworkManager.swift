//
//  NetworkManager.swift
//  concurrency-test
//
//  Created by 서채희 on 2023/03/05.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    func downloadImage(url: URL,
                       task: inout URLSessionDataTask?,
                       successHandler: @escaping ((UIImage)->Void),
                       failHandler: @escaping (()->Void),
                       cancelHandler: @escaping (()->Void)) {
        let request = URLRequest(url: url)
        task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                guard error.localizedDescription == "cancelled" else {
                    fatalError(error.localizedDescription)
                }
                cancelHandler()
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                failHandler()
                return
            }
            successHandler(image)
        }
        task?.resume()
    }
}


