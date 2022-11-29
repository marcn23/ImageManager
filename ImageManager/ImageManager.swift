//
//  ImageManager.swift
//  ImageManager
//
//  Created by Marc Navarro on 29/11/22.
//

import Foundation

struct APIImage: Codable{
    let ttl: String
    let desc: String
    let keyw: String
    let auth: String
    let creat: String
    let dateC: String
    let dateS: String
    let filen: String
    let id: String
    let portrait: Bool
}

struct APIBook: Codable{
    var Images = [String : APIImage]()
    let imageNumber: Int
}

public final class ImageManager: NSObject{
    
    public var completionHandler: ((Book) -> Void)?
    
    let urlString: String
    
    public override init() {
        urlString = "https://b132-37-133-181-255.eu.ngrok.io/Practica4/resources/javaee8/list"
    }
    
    public func getImages(){
        guard let url = URL(string: urlString) else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                //let response = try JSONSerialization.jsonObject(with:data, options: .allowFragments)
                //print(response)
                if let response = try? JSONDecoder().decode(APIBook.self, from: data){
                    let bookResult = Book(response: response)
                    self.completionHandler?(bookResult)
                    print(bookResult.imageNumber)
                    for(key,value) in bookResult.Images{
                        print("")
                        print("Image: " + key + ", Atributes:")
                        print(value.ttl)
                        print(value.desc)
                        print(value.keyw)
                        print(value.auth)
                        print(value.creat)
                        print(value.dateC)
                        print(value.dateS)
                        print(value.portrait)
                        print("")
                    }
                }
            }
        }
        task.resume()
    }
}
