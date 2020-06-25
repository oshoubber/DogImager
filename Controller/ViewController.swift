//
//  ViewController.swift
//  DogImager
//
//  Created by Osama on 6/24/20.
//  Copyright © 2020 Osama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DogAPI.requestRandomImage(completionHandler: handleRandomImageResponse(imageData:error:))
    }
    
    func handleRandomImageResponse(imageData: DogImage?, error: Error?) {
        guard let dogImageURL = URL(string: imageData?.message ?? "") else { return }
        DogAPI.requestImageFile(url: dogImageURL, completionHandler: self.handleImageFileResponse(image:error:))
        
    }
    
    func handleImageFileResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}
