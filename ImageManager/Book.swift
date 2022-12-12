//
//  Book.swift
//  ImageManager
//
//  Created by Marc Navarro on 29/11/22.
//

import Foundation

public struct Book{
    var Images: [String : Image] = [:]
    let imageNumber: Int
    //var imagesRepo = NSCache<NSString, NSData>()
    
    init(){
        imageNumber = 0
    }
    
    init(response: APIBook){
        for (key, value) in response.Images {
            self.Images[key] = Image(response: value)
        }
        imageNumber = response.imageNumber
    }
}

