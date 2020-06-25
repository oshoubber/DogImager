//
//  DogAPI.swift
//  DogImager
//
//  Created by Osama on 6/24/20.
//  Copyright © 2020 Osama. All rights reserved.
//

import Foundation
import UIKit

// DogAPI Class for Endpoints and URL Retrieval
class DogAPI {
    enum Endpoint: String {
        case randomImageFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random"
        
        var url: URL {
            return URL(string: self.rawValue)!
        }
    }
    
    class func requestRandomImage(completionHandler: @escaping (DogImage?, Error?) -> Void) {
        // Set endpoint for random dog image api
        let randomImageEndpoint = DogAPI.Endpoint.randomImageFromAllDogsCollection.url
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, response, error) in
            
            // Validate received data
            guard let data = data else { completionHandler(nil, error); return }
            
            // Parse JSON Object Codable
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImage.self, from: data)
            
            completionHandler(imageData, nil)
        }
        task.resume()
    }
    
    class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data else { completionHandler(nil, error); return }
             
            let dlImage = UIImage(data: data)
            completionHandler(dlImage, nil)
         })
        task.resume()
    }
    
}

// Parse JSON Object Serially
/*
func json {
    do {
        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        let url = json["message"] as! String
        print(url)
    } catch {
        print(error)
    }
*/

