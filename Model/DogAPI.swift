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
    enum Endpoint {
        case listAllBreeds
        case randomImageFromAllDogsCollection
        case randomImageForBreed(String)
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String {
            switch self {
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            case .randomImageFromAllDogsCollection:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            }
        }
    }
    
    // Async API Calls
    class func requestRandomImage(breed: String, completionHandler: @escaping (DogImage?, Error?) -> Void) {
        // Set endpoint for random dog image api
        let randomImageEndpoint = DogAPI.Endpoint.randomImageForBreed(breed).url
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
    
    class func requestBreedsList(completionHandler: @escaping ([String], Error?) -> Void) {
        // Set endpoing to fetch all dogs list
        let allBreedsEndpoint = DogAPI.Endpoint.listAllBreeds.url
        let task = URLSession.shared.dataTask(with: allBreedsEndpoint) { (data, response, error) in
            
            // Validate received data
            guard let data = data else { completionHandler([], error); return }
            
            // Parse JSON Object as Codable
            let decoder = JSONDecoder()
            let breedsResponse = try! decoder.decode(BreedsListResponse.self, from: data)
            
            // Get list of breeds (keys of response in "message") using map 
            let breeds = (breedsResponse.message.keys.map({$0}))
            
            completionHandler(breeds.sorted(), nil)
        }
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

