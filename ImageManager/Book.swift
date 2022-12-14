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
    
    init(response: APIBook) async{
        for (key, value) in response.Images {
            self.Images[key] = await Image(response: value)
        }
        imageNumber = response.imageNumber
    }
}

/*Task{
    result = await ImageManager().getImages()
    print(result.imageNumber)
    for(_, value) in result.Images{
        self.imageView.image = await ImageManager().downloadImg(idImg: value.id)
    }
}
Task{
    //group.enter()
    result = await ImageManager().getImages()
    for ( _ , value) in result.Images{
        imatges.append(value.ttl)
    }
    print(imatges)
    print(result.imageNumber)
    super.viewDidLoad()
    // Do any additional setup after loading the view.

}*/
